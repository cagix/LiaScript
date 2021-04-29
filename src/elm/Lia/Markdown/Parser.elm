module Lia.Markdown.Parser exposing (run)

import Combine
    exposing
        ( Parser
        , andMap
        , andThen
        , choice
        , fail
        , ignore
        , keep
        , lazy
        , lookAhead
        , many
        , many1
        , manyTill
        , map
        , maybe
        , modifyState
        , onsuccess
        , optional
        , or
        , putState
        , regex
        , regexWith
        , runParser
        , sepBy
        , sepBy1
        , skip
        , succeed
        , whitespace
        , withState
        )
import Lia.Markdown.Chart.Parser as Chart
import Lia.Markdown.Code.Parser as Code
import Lia.Markdown.Effect.Model exposing (set_annotation)
import Lia.Markdown.Effect.Parser as Effect
import Lia.Markdown.Footnote.Parser as Footnote
import Lia.Markdown.Gallery.Parser as Gallery
import Lia.Markdown.HTML.Attributes as Attributes exposing (Parameters)
import Lia.Markdown.HTML.Parser as HTML
import Lia.Markdown.Inline.Parser exposing (combine, comment, line, lineWithProblems)
import Lia.Markdown.Inline.Types exposing (Inline(..), Inlines)
import Lia.Markdown.Macro.Parser exposing (macro)
import Lia.Markdown.Quiz.Parser as Quiz
import Lia.Markdown.Survey.Parser as Survey
import Lia.Markdown.Table.Parser as Table
import Lia.Markdown.Task.Parser as Task
import Lia.Markdown.Types exposing (Markdown(..), MarkdownS)
import Lia.Parser.Context exposing (Context)
import Lia.Parser.Helper exposing (c_frame, newline, newlines, spaces)
import Lia.Parser.Indentation as Indent
import SvgBob


run : Parser Context (List Markdown)
run =
    footnotes
        |> keep (or blocks problem)
        |> ignore newlines
        |> many
        |> ignore footnotes


footnotes : Parser Context ()
footnotes =
    (Footnote.block ident_blocks |> ignore newlines)
        |> many
        |> skip


blocks : Parser Context Markdown
blocks =
    lazy <|
        \() ->
            Indent.check
                |> keep macro
                |> keep elements
                |> ignore (maybe (whitespace |> keep Effect.hidden_comment))


elements : Parser Context Markdown
elements =
    choice
        [ md_annotations
            |> map Effect
            |> andMap (Effect.markdown blocks)
        , md_annotations
            |> map Tuple.pair
            |> andMap (Effect.comment paragraph)
            |> andThen to_comment
        , md_annotations
            |> map Chart
            |> andMap Chart.parse
        , md_annotations
            |> map (\attr tab -> Table.classify attr tab >> Table attr)
            |> andMap Table.parse
            |> andMap (withState (.effect_model >> .javascript >> succeed))
        , svgbob
        , map Code (Code.parse md_annotations)
        , md_annotations
            |> map Header
            |> andMap subHeader
        , horizontal_line
        , md_annotations
            |> map Survey
            |> andMap Survey.parse
        , md_annotations
            |> map Quiz
            |> andMap Quiz.parse
            |> andMap solution
        , md_annotations
            |> map Task
            |> andMap Task.parse
        , quote
        , md_annotations
            |> map OrderedList
            |> andMap ordered_list
        , md_annotations
            |> map BulletList
            |> andMap unordered_list
        , md_annotations
            |> map HTML
            |> andMap (HTML.parse blocks)
            |> ignore (regex "[ \t]*\n")
        , md_annotations
            |> map Gallery
            |> andMap Gallery.parse
        , md_annotations
            |> map checkForCitation
            |> andMap paragraph
        ]


to_comment : ( Parameters, ( Int, Int ) ) -> Parser Context Markdown
to_comment ( attr, ( id1, id2 ) ) =
    (case attr of
        [] ->
            succeed ()

        _ ->
            modifyState
                (\s ->
                    let
                        e =
                            s.effect_model
                    in
                    { s | effect_model = { e | comments = set_annotation id1 id2 e.comments attr } }
                )
    )
        |> onsuccess (Comment ( id1, id2 ))


svgbody : Int -> Parser Context ( Maybe Inlines, String )
svgbody len =
    let
        control_frame =
            "(`){"
                ++ String.fromInt len
                ++ (if len <= 8 then
                        "}"

                    else
                        ",}"
                   )

        ascii =
            regexWith True False <|
                if len <= 8 then
                    "[\t ]*(ascii|art)[\t ]*"

                else
                    "([\t ]*(ascii|art))?[\t ]*"
    in
    ascii
        |> keep (maybe line)
        |> map Tuple.pair
        |> ignore newline
        |> andMap
            (manyTill
                (maybe Indent.check
                    |> keep (regex ("(?:.(?!" ++ control_frame ++ "))*\\n"))
                )
                (Indent.check
                    |> keep (regex control_frame)
                )
                |> map (String.concat >> String.dropRight 1)
            )


svgbob : Parser Context Markdown
svgbob =
    md_annotations
        |> map ASCII
        |> andMap
            (c_frame
                |> andThen svgbody
                |> andThen svgbobSub
            )


svgbobSub : ( Maybe Inlines, String ) -> Parser Context ( Maybe Inlines, SvgBob.Configuration (List Markdown) )
svgbobSub ( caption, str ) =
    let
        svg =
            SvgBob.getElements
                { fontSize = 14.0
                , lineWidth = 1.0
                , textWidth = 8.0
                , textHeight = 16.0
                , arcRadius = 4.0
                , strokeColor = "black"
                , textColor = "black"
                , backgroundColor = "white"
                , verbatim = '"'
                , multilineVerbatim = True
                , heightVerbatim = Just "100%"
                , widthVerbatim = Nothing
                }
                str

        fn context =
            let
                ( newContext, foreign ) =
                    svg.foreign
                        |> List.foldl
                            (\( code, pos ) ( c, list ) ->
                                case runParser run c (code ++ "\n") of
                                    Ok ( state, _, md ) ->
                                        ( state, ( md, pos ) :: list )

                                    Err _ ->
                                        ( c, list )
                            )
                            ( context, [] )
            in
            putState newContext
                |> keep
                    (succeed
                        ( caption
                        , { svg = svg.svg
                          , foreign = foreign
                          , settings = svg.settings
                          , columns = svg.columns
                          , rows = svg.rows
                          }
                        )
                    )
    in
    withState fn


subHeader : Parser Context ( Inlines, Int )
subHeader =
    line
        |> ignore (regex "[ \t]*\n")
        |> map Tuple.pair
        |> andMap underline
        |> ignore (regex "[ \t]*\n")



--|> ignore (regex "[ \t]*\n")


underline : Parser Context Int
underline =
    or
        (regex "={3,}[ \t]*" |> keep (succeed 1))
        (regex "-{3,}[ \t]*" |> keep (succeed 2))


solution : Parser Context (Maybe ( List Markdown, Int ))
solution =
    let
        rslt e1 blocks_ e2 =
            ( blocks_, e2 - e1 )
    in
    regex "[\t ]*\\*{3,}[\t ]*\\n+"
        |> keep (withState (\s -> succeed s.effect_model.effects))
        |> map rslt
        |> andMap
            (manyTill (blocks |> ignore newlines)
                (regex "[\t ]*\\*{3,}[\t ]*")
            )
        |> andMap (withState (\s -> succeed s.effect_model.effects))
        |> maybe


ident_blocks : Parser Context MarkdownS
ident_blocks =
    blocks
        |> ignore (regex "\n?")
        |> many1
        |> ignore Indent.pop


unordered_list : Parser Context (List MarkdownS)
unordered_list =
    Indent.push "  "
        |> keep
            (regex "[ \t]*[*+-][ \t]+"
                |> keep (sepBy (many newlineWithIndentation) blocks)
            )
        |> ignore Indent.pop
        |> sepBy1
            (newlineWithIndentation
                |> many
                |> ignore Indent.check
            )


ordered_list : Parser Context (List ( String, MarkdownS ))
ordered_list =
    Indent.push "   "
        |> keep
            (regex "[ \t]*-?\\d+"
                |> map Tuple.pair
                |> ignore (regex "\\.[ \t]*")
                |> andMap (sepBy (many newlineWithIndentation) blocks)
            )
        |> ignore Indent.pop
        |> sepBy1
            (newlineWithIndentation
                |> many
                |> ignore Indent.check
            )


newlineWithIndentation : Parser Context ()
newlineWithIndentation =
    Indent.maybeCheck
        |> ignore newline


quote : Parser Context Markdown
quote =
    map Quote md_annotations
        |> ignore (regex "> ?")
        |> ignore (Indent.push "> ?")
        |> ignore Indent.skip
        |> andMap (sepBy newlineWithIndentation blocks)
        |> ignore Indent.pop


checkForCitation : Parameters -> Inlines -> Markdown
checkForCitation attr p =
    case p of
        (Chars "-" _) :: (Chars "-" _) :: rest ->
            Citation attr rest

        _ ->
            Paragraph attr p



--quote : Parser Context Markdown
--quote =
--    map Quote md_annotations
--        |> ignore (indentation_append "> ?")
--        |> andMap
--            (regex "> ?"
--                |> keep
--                    (blocks
--                        |> ignore (maybe indentation)
--                        |> ignore (regex "\\n?")
--                        |> many1
--                    )
--            )
--        |> ignore indentation_pop


horizontal_line : Parser Context Markdown
horizontal_line =
    md_annotations
        |> ignore (regex "-{3,}")
        |> map HLine


paragraph : Parser Context Inlines
paragraph =
    checkParagraph
        |> ignore Indent.skip
        |> keep (many1 (Indent.check |> keep line |> ignore newline))
        |> map (List.intersperse [ Chars " " [] ] >> List.concat >> combine)


{-| A paragraph cannot start with a marker for Comments `--{{1}}--` or Effects
`{{1}}`. This parser checks both case, if the string pattern matches either
Comment or Effect it will fail.

_Note:_ This is mostly the case in ordered and unordered lists.

TODO: This shall be removed in the future, if a `paragraph` is directly used as
to for returning `Paragraph`, `Citation`, or `Comment`.

-}
checkParagraph : Parser Context ()
checkParagraph =
    lookAhead
        (maybe
            (or (regex "[ \t]*--{{\\d+}}--")
                (regex "[ \t]*{{\\d+}}")
            )
            |> andThen
                (\e ->
                    if e == Nothing then
                        succeed ()

                    else
                        fail ""
                )
        )


problem : Parser Context Markdown
problem =
    Indent.skip
        |> ignore Indent.check
        |> keep lineWithProblems
        |> ignore newline
        |> map Problem


md_annotations : Parser Context Parameters
md_annotations =
    let
        attr =
            withState (.defines >> .base >> succeed)
                |> andThen Attributes.parse
    in
    spaces
        |> keep macro
        |> keep (comment attr)
        |> ignore
            (regex "[\t ]*\\n"
                |> ignore Indent.check
                |> maybe
            )
        |> optional []
