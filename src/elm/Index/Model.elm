module Index.Model exposing (Course, Model, Release, init)

import Dict exposing (Dict)
import Index.View.Board as Board exposing (Board)
import Lia.Definition.Types exposing (Definition)
import Lia.Markdown.Inline.Types exposing (Inlines)


type alias Model =
    { input : String
    , courses : List Course
    , initialized : Bool
    , board : Board Course
    }


init : Model
init =
    Board.init "Default"
        |> Model "" [] False


type alias Course =
    { id : String
    , versions : Dict String Release
    , active : Maybe String
    , last_visit : String
    }


type alias Release =
    { title : Inlines
    , definition : Definition
    }
