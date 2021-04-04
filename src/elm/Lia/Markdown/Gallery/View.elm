module Lia.Markdown.Gallery.View exposing (..)

import Accessibility.Key as A11y_Key
import Accessibility.Role as A11y_Role
import Accessibility.Widget as A11y_Widget
import Array
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Event
import Lia.Markdown.Gallery.Types exposing (Gallery, Vector)
import Lia.Markdown.Gallery.Update exposing (Msg(..))
import Lia.Markdown.HTML.Attributes exposing (Parameters, annotation)
import Lia.Markdown.Inline.Config exposing (Config)
import Lia.Markdown.Inline.Types exposing (Inline)
import Lia.Markdown.Inline.View exposing (viewer)
import Lia.Markdown.Types exposing (Markdown(..))
import Lia.Utils exposing (btnIcon, get)


view : Config sub -> Vector -> Parameters -> Gallery -> Html (Msg sub)
view config vector attr gallery =
    gallery.media
        |> List.indexedMap
            (\i media ->
                [ [ media ]
                    |> viewer config
                    |> List.map (Html.map Script)
                    |> Html.div [ Attr.style "float" "left" ]
                , Html.div
                    [ Event.onClick <| Show gallery.id i
                    , Attr.style "width" "32.2rem"
                    , Attr.style "height" "32.2rem"
                    , Attr.style "position" "relative"
                    , Attr.style "left" "0"
                    ]
                    []
                ]
                    |> Html.div
                        []
            )
        |> Html.div (annotation "lia-gallery" attr)
        |> viewMedia config vector gallery


viewMedia : Config sub -> Vector -> Gallery -> Html (Msg sub) -> Html (Msg sub)
viewMedia config vector gallery div =
    let
        mediaID =
            Array.get gallery.id vector |> Maybe.withDefault -1
    in
    if mediaID < 0 then
        div

    else
        Html.div []
            [ gallery.media
                |> get mediaID
                |> Maybe.map (viewOverlay config gallery.id)
                |> Maybe.withDefault (Html.text "")
            , div
            ]


viewOverlay : Config sub -> Int -> Inline -> Html (Msg sub)
viewOverlay config id media =
    Html.div
        [ Attr.style "position" "fixed"
        , Attr.style "display" "block"
        , Attr.style "width" "100%"
        , Attr.style "height" "100%"
        , Attr.style "top" "0"
        , Attr.style "right" "0"
        , Attr.style "z-index" "10000"
        , Attr.class "lia-modal"
        ]
        [ [ btnIcon
                { icon = "icon-close"
                , msg = Just (Close id)
                , tabbable = True
                , title = "close modal"
                }
                [ Attr.class "lia-btn--transparent"
                , Attr.style "float" "right"
                , Attr.style "padding" "0px"
                , Attr.id "lia-close-modal"
                , A11y_Key.onKeyDown [ A11y_Key.escape (Close id) ]
                ]
          , [ media ]
                |> viewer config
                |> Html.div
                    [ Attr.style "position" "absolute"
                    , Attr.style "top" "4rem"
                    , Attr.style "left" "50%"
                    , Attr.style "width" "100%"
                    , Attr.style "transform" "translate(-50%,0%)"
                    , Attr.style "-ms-transform" "translate(-50%,0%)"
                    ]
                |> Html.map Script
          ]
            |> Html.div
                [ Attr.style "position" "absolute"
                , Attr.style "top" "5%"
                , Attr.style "left" "50%"
                , Attr.style "font-size" "20px"
                , Attr.style "color" "white"
                , Attr.style "transform" "translate(-50%,-30%)"
                , Attr.style "-ms-transform" "translate(-50%,-30%)"
                , Attr.style "width" "90%"
                , A11y_Widget.modal True
                , A11y_Role.dialog
                ]
        , Html.div
            [ Attr.style "background-color" "rgba(0,0,0,0.8)"
            , Attr.style "width" "100%"
            , Attr.style "height" "100%"
            , Attr.style "overflow" "auto"
            , Event.onClick (Close id)
            ]
            []
        ]
