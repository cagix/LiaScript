port module Lia.Code.Update exposing (Msg(..), subscriptions, update)

import Array exposing (Array)
import Json.Decode as JD
import Lia.Code.Types exposing (..)
import Lia.Helper exposing (ID)
import Lia.Utils exposing (toJSstring)


port eval2js : ( Int, String ) -> Cmd msg


port eval2elm : (( Bool, Int, String, JD.Value ) -> msg) -> Sub msg


subscriptions : Vector -> Sub Msg
subscriptions model =
    Sub.batch [ eval2elm EvalRslt ]


type Msg
    = Eval ID
    | Update ID ID String
    | FlipView ID ID
    | FlipFullscreen ID ID
    | EvalRslt ( Bool, Int, String, JD.Value )
    | Load ID Int
    | First ID
    | Last ID


update : Msg -> Vector -> ( Vector, Cmd Msg )
update msg model =
    case msg of
        Eval idx ->
            case Array.get idx model of
                Just project ->
                    let
                        code_0 =
                            project.file
                                |> Array.get 0
                                |> Maybe.map .code
                                |> Maybe.withDefault ""
                    in
                    ( update_ idx model (\p -> { p | running = True })
                    , eval2js
                        ( idx
                        , if Array.length project.file == 1 then
                            project.evaluation
                                |> replace ( 0, code_0 )
                                |> default_replace code_0

                          else
                            project.file
                                |> Array.indexedMap (\i f -> ( i, f.code ))
                                |> Array.foldl replace project.evaluation
                                |> default_replace code_0
                                |> toJSstring
                        )
                    )

                Nothing ->
                    ( model, Cmd.none )

        Update id_1 id_2 code_str ->
            update_file id_1 id_2 model (\f -> { f | code = code_str }) Cmd.none

        FlipView id_1 id_2 ->
            update_file id_1 id_2 model (\f -> { f | visible = not f.visible }) Cmd.none

        FlipFullscreen id_1 id_2 ->
            update_file id_1 id_2 model (\f -> { f | fullscreen = not f.fullscreen }) Cmd.none

        Load idx version ->
            ( update_ idx model (load version), Cmd.none )

        First idx ->
            ( update_ idx model (load 0), Cmd.none )

        Last idx ->
            ( update_ idx model (model |> Array.get idx |> Maybe.map (.version >> Array.length >> (+) -1) |> Maybe.withDefault 0 |> load), Cmd.none )

        EvalRslt ( True, idx, message, details ) ->
            if message == "LIA wait!" then
                ( model, Cmd.none )

            else
                ( decode_rslt message details
                    |> Ok
                    |> resulting
                    |> update_ idx model
                , Cmd.none
                )

        EvalRslt ( False, idx, message, details ) ->
            ( decode_rslt message details
                |> Err
                |> resulting
                |> update_ idx model
            , Cmd.none
            )


decode_rslt : String -> JD.Value -> Rslt
decode_rslt message details =
    details
        |> JD.decodeValue (JD.array JD.value)
        |> Result.withDefault Array.empty
        |> Rslt message


replace : ( Int, String ) -> String -> String
replace ( int, insert ) into =
    into
        |> String.split ("@code(" ++ toString int ++ ")")
        |> String.join insert


default_replace : String -> String -> String
default_replace insert into =
    into
        |> String.split "@code"
        |> String.join insert


update_ : ID -> Vector -> (Project -> Project) -> Vector
update_ idx model f =
    case Array.get idx model of
        Just elem ->
            Array.set idx (f elem) model

        Nothing ->
            model


update_file : ID -> ID -> Vector -> (File -> File) -> Cmd msg -> ( Vector, Cmd msg )
update_file id_1 id_2 model f cmd =
    ( case Array.get id_1 model of
        Just project ->
            case Array.get id_2 project.file of
                Just file ->
                    Array.set id_1 { project | file = Array.set id_2 (f file) project.file } model

                Nothing ->
                    model

        Nothing ->
            model
    , cmd
    )


resulting : Result Rslt Rslt -> Project -> Project
resulting result elem =
    let
        ( code, _ ) =
            elem.version
                |> Array.get elem.version_active
                |> Maybe.withDefault ( Array.empty, noResult )

        e =
            { elem
                | result = result
                , running = False
            }

        new_code =
            e.file |> Array.map .code
    in
    if code == new_code then
        { e
            | version = Array.set e.version_active ( code, result ) e.version
        }

    else
        { e
            | version = Array.push ( new_code, result ) e.version
            , version_active = Array.length e.version
        }


load : Int -> Project -> Project
load version elem =
    if (version >= 0) && (version < Array.length elem.version) then
        let
            ( code, result ) =
                elem.version
                    |> Array.get version
                    |> Maybe.withDefault ( Array.empty, noResult )
        in
        { elem
            | version_active = version
            , file = Array.indexedMap (\i a -> { a | code = Array.get i code |> Maybe.withDefault a.code }) elem.file
            , result = result
        }

    else
        elem
