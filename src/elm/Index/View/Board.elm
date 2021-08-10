module Index.View.Board exposing
    ( Board
    , Msg
    , addColumn
    , addNote
    , deleteColumn
    , deleteNote
    , init
    , restore
    , update
    , view
    )

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as Event
import Json.Decode as JD
import Json.Encode as JE
import Lia.Utils exposing (focus)
import List.Extra
    exposing
        ( find
        , getAt
        , removeAt
        , swapAt
        , updateAt
        )
import Translations exposing (Lang(..))


type alias Board note =
    { store : Maybe JE.Value
    , moving : Maybe Reference
    , newColumn : Maybe String
    , changeColumn : Maybe Int
    , columns : List (Column note)
    }


type alias Return note withParent =
    { board : Board note
    , cmd : Maybe (Cmd (Msg withParent))
    , parentMsg : Maybe withParent
    , store : Maybe JE.Value
    }


type alias Column note =
    { name : String
    , notes : List note
    }


type Reference
    = NoteID Int Int
    | ColumnID Int


init : String -> Board { note | id : String }
init default =
    Board
        Nothing
        Nothing
        Nothing
        Nothing
        [ Column default [] ]


type Msg withParent
    = Move Reference
    | Drop Reference
    | AddColumnInput String
    | AddColumnStart
    | AddColumnStop
    | ChangeColumnInput String
    | ChangeColumnStart Int
    | ChangeColumnStop
    | Parent withParent
    | Ignore


return :
    Board { note | id : String }
    -> Return { note | id : String } withParent
return board =
    Return board Nothing Nothing Nothing


returnCmd :
    Cmd (Msg withParent)
    -> Return { note | id : String } withParent
    -> Return { note | id : String } withParent
returnCmd cmd return_ =
    { return_ | cmd = Just cmd }


returnMsg :
    parent
    -> Return { note | id : String } parent
    -> Return { note | id : String } parent
returnMsg msg return_ =
    { return_ | parentMsg = Just msg }


returnStore :
    Return { note | id : String } withParent
    -> Return { note | id : String } withParent
returnStore return_ =
    { return_ | store = Just (store return_.board) }


update :
    Msg withParent
    -> Board { note | id : String }
    -> Return { note | id : String } withParent
update msg board =
    case msg of
        Parent parentMsg ->
            board
                |> return
                |> returnMsg parentMsg

        AddColumnStart ->
            { board | newColumn = Just "" }
                |> return
                |> returnCmd (focus Ignore inputID)

        AddColumnStop ->
            returnStore <|
                return <|
                    case board.newColumn |> Maybe.map String.trim |> Maybe.withDefault "" of
                        "" ->
                            { board | newColumn = Nothing }

                        new ->
                            addColumn new { board | newColumn = Nothing }

        AddColumnInput name ->
            return { board | newColumn = Just name }

        ChangeColumnStart id ->
            { board | changeColumn = Just id }
                |> return
                |> returnCmd (focus Ignore inputID)

        ChangeColumnStop ->
            { board | changeColumn = Nothing }
                |> return
                |> returnStore

        ChangeColumnInput name ->
            return <|
                case board.changeColumn of
                    Just id ->
                        { board
                            | columns =
                                updateAt
                                    id
                                    (\col -> { col | name = name })
                                    board.columns
                        }

                    Nothing ->
                        board

        Move ref ->
            { board
                | moving =
                    case board.moving of
                        Nothing ->
                            Just ref

                        _ ->
                            board.moving
            }
                |> return

        Drop ref ->
            returnStore <|
                return <|
                    { board
                        | moving = Nothing
                        , columns =
                            case ( board.moving, ref ) of
                                ( Just (NoteID sourceId id), ColumnID targetId ) ->
                                    case getNote sourceId id board.columns of
                                        Just note ->
                                            board.columns
                                                |> updateAt targetId (\col -> { col | notes = note :: col.notes })
                                                |> updateAt sourceId (\col -> { col | notes = removeAt id col.notes })

                                        _ ->
                                            board.columns

                                ( Just (ColumnID sourceId), ColumnID targetId ) ->
                                    swapAt sourceId targetId board.columns

                                ( Just (ColumnID sourceId), NoteID targetId _ ) ->
                                    swapAt sourceId targetId board.columns

                                ( Just (NoteID a1 a2), NoteID b1 b2 ) ->
                                    swapNotes a1 a2 b1 b2 board.columns

                                _ ->
                                    board.columns
                    }

        _ ->
            return board


swapNotes : Int -> Int -> Int -> Int -> List (Column { note | id : String }) -> List (Column { note | id : String })
swapNotes columnA noteA columnB noteB columns =
    case ( getNote columnA noteA columns, getNote columnB noteB columns ) of
        ( Just a, Just b ) ->
            columns
                |> setNote columnA noteA b
                |> setNote columnB noteB a

        _ ->
            columns


deleteNote :
    Int
    -> Int
    -> List (Column { note | id : String })
    -> List (Column { note | id : String })
deleteNote columnID noteID =
    updateAt columnID (\col -> { col | notes = removeAt noteID col.notes })


deleteColumn :
    Int
    -> List (Column { note | id : String })
    -> List (Column { note | id : String })
deleteColumn i columns =
    case columns of
        [] ->
            []

        [ col ] ->
            [ col ]

        _ ->
            columns
                |> updateAt
                    (if i == 0 then
                        i + 1

                     else
                        i - 1
                    )
                    (\col ->
                        { col
                            | notes =
                                columns
                                    |> getAt i
                                    |> Maybe.map .notes
                                    |> Maybe.withDefault []
                                    |> List.append col.notes
                        }
                    )


getNote :
    Int
    -> Int
    -> List (Column { note | id : String })
    -> Maybe { note | id : String }
getNote columnID noteID =
    getAt columnID >> Maybe.andThen (.notes >> getAt noteID)


setNote :
    Int
    -> Int
    -> { note | id : String }
    -> List (Column { note | id : String })
    -> List (Column { note | id : String })
setNote columnID noteID note =
    updateAt columnID (\col -> { col | notes = col.notes |> updateAt noteID (always note) })


view :
    ({ note | id : String } -> Html withParent)
    -> List (Attribute (Msg withParent))
    -> Board { note | id : String }
    -> Html (Msg withParent)
view fn attributes board =
    board.columns
        |> List.indexedMap (viewColumn fn attributes board.changeColumn)
        |> viewAddColumn attributes board.newColumn
        |> Html.div
            [ Attr.style "display" "flex"
            , Attr.style "align-items" "flex-start"
            , Attr.style "overflow-x" "auto"
            ]


inputID : String
inputID =
    "lia-index-column-input"


viewAddColumn : List (Attribute (Msg withParent)) -> Maybe String -> List (Html (Msg withParent)) -> List (Html (Msg withParent))
viewAddColumn attributes newColumn columns =
    List.append columns
        [ case newColumn of
            Nothing ->
                Html.button
                    (Attr.style "flex" "1"
                        :: Attr.style "width" "100%"
                        :: Event.onClick AddColumnStart
                        :: attributes
                    )
                    [ Html.h3
                        [ Attr.style "width" "inherit"
                        , Attr.style "margin-bottom" "0px"
                        ]
                        [ plus
                        , Html.span
                            []
                            [ Html.text "Add New Column" ]
                        ]
                    ]

            Just name ->
                Html.div
                    (Attr.style "flex" "1" :: attributes)
                    [ Html.h3 []
                        [ plus
                        , Html.input
                            [ Attr.value name
                            , Event.onInput AddColumnInput
                            , Event.onBlur AddColumnStop
                            , Attr.style "float" "right"
                            , Attr.style "display" "block"
                            , Attr.style "width" "calc(100% - 5rem)"
                            , Attr.style "color" "#000"
                            , Attr.style "height" "4.2rem"
                            , Attr.id inputID
                            , Attr.autofocus True
                            ]
                            []
                        ]
                    ]
        ]


plus : Html msg
plus =
    Html.span
        [ Attr.style "padding" "0px 1rem 0px 1rem"
        , Attr.style "background" "#888"
        , Attr.style "border-radius" "1rem"
        , Attr.style "float" "left"
        ]
        [ Html.text "+ "
        ]


viewColumn :
    ({ note | id : String } -> Html withParent)
    -> List (Attribute (Msg withParent))
    -> Maybe Int
    -> Int
    -> Column { note | id : String }
    -> Html (Msg withParent)
viewColumn fn attributes changingID id column =
    draggable (ColumnID id)
        (Attr.style "flex" "1" :: attributes)
        [ Html.h3
            [ Attr.style "width" "inherit"
            , Attr.style "margin-bottom" "0px"
            ]
            [ Html.span
                [ Attr.style "padding" "0px 1rem 0px 1rem"
                , Attr.style "background" "#888"
                , Attr.style "border-radius" "2rem"
                , Attr.style "float" "left"
                ]
                [ column.notes
                    |> List.length
                    |> String.fromInt
                    |> Html.text
                ]
            , if changingID /= Just id then
                Html.span
                    [ Attr.style "text-align" "center"
                    , Attr.style "display" "block"
                    , Event.onDoubleClick (ChangeColumnStart id)
                    ]
                    [ Html.text column.name ]

              else
                Html.input
                    [ Attr.value column.name
                    , Attr.style "float" "right"
                    , Attr.style "display" "block"
                    , Attr.style "width" "calc(100% - 5rem)"
                    , Attr.style "color" "#000"
                    , Attr.style "height" "4.2rem"
                    , Attr.id inputID
                    , Attr.autofocus True
                    , Event.onInput ChangeColumnInput
                    , Event.onBlur ChangeColumnStop
                    ]
                    []
            ]
        , column.notes
            |> List.indexedMap (viewNote fn id)
            |> Html.div
                [ Attr.style "overflow-y" "auto"
                , Attr.style "float" "left"
                ]
        ]


viewNote :
    ({ note | id : String } -> Html withParent)
    -> Int
    -> Int
    -> { note | id : String }
    -> Html (Msg withParent)
viewNote fn columnID noteID note =
    draggable (NoteID columnID noteID)
        [ Attr.style "padding-top" "1rem" ]
        [ fn note
            |> Html.map Parent
        ]


draggable :
    Reference
    -> List (Attribute (Msg withParent))
    -> (List (Html (Msg withParent)) -> Html (Msg withParent))
draggable ref attributes =
    [ Attr.attribute "draggable" "true"
    , Attr.attribute "ondragover" "return false"
    , onDrop <| Drop ref
    , onDragStart <| Move ref
    , Attr.attribute "ondragstart" "event.dataTransfer.setData('text/plain', '')"
    ]
        |> List.append attributes
        |> Html.div


addNote :
    Int
    -> { note | id : String }
    -> Board { note | id : String }
    -> Board { note | id : String }
addNote id note board =
    { board | columns = updateAt id (\col -> { col | notes = note :: col.notes }) board.columns }


addColumn :
    String
    -> Board { note | id : String }
    -> Board { note | id : String }
addColumn name board =
    { board | columns = List.append board.columns [ Column name [] ] }


onDragStart : msg -> Attribute msg
onDragStart message =
    Event.on "dragstart" (JD.succeed message)


onDrop : msg -> Attribute msg
onDrop message =
    Event.custom "drop"
        (JD.succeed
            { message = message
            , preventDefault = True
            , stopPropagation = True
            }
        )


store : Board { note | id : String } -> JE.Value
store =
    .columns
        >> List.map
            (\column ->
                [ ( "name", JE.string column.name )
                , ( "id"
                  , column.notes
                        |> List.map .id
                        |> JE.list JE.string
                  )
                ]
            )
        >> JE.list JE.object


restore : List { note | id : String } -> JE.Value -> Maybe (Board { note | id : String })
restore data json =
    case JD.decodeValue (JD.list decoder) json of
        Ok list ->
            let
                columns =
                    List.map (merge data) list

                runaways =
                    catchRunaways columns data
            in
            columns
                |> updateAt 0 (\col -> { col | notes = List.append col.notes runaways })
                |> Board Nothing Nothing Nothing Nothing
                |> Just

        Err _ ->
            Nothing


catchRunaways :
    List (Column { note | id : String })
    -> List { note | id : String }
    -> List { note | id : String }
catchRunaways columns =
    let
        ids =
            columns
                |> List.map (.notes >> List.map .id)
                |> List.concat
    in
    List.filter (\elem -> not <| List.member elem.id ids)


merge : List { note | id : String } -> Column String -> Column { note | id : String }
merge data column =
    { name = column.name
    , notes = List.filterMap (match data) column.notes
    }


match : List { note | id : String } -> String -> Maybe { note | id : String }
match data id =
    find (\elem -> elem.id == id) data


decoder : JD.Decoder (Column String)
decoder =
    JD.map2 Column
        (JD.field "name" JD.string)
        (JD.field "id" (JD.list JD.string))
