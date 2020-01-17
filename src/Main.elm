module Main exposing (..)

import Css exposing (..)
import Html.Styled as Html exposing (div, i, li, span, text, u, ul)
import Html.Styled.Attributes exposing (class, css)


colors =
    { primary = rgb 86 110 132
    }


leftWidth =
    px 150


styles =
    { container = [ margin (px 10) ]
    , content = [ padding4 (px 0) (px 15) (px 15) (px 15) ]
    , section =
        { container =
            [ fontSize (px 20)
            , displayFlex
            , padding4 (px 10) (px 0) (px 5) (px 0)
            , borderBottom3 (px 1) solid (hex "#000000")
            ]
        , left =
            [ width leftWidth
            , minWidth leftWidth
            , maxWidth leftWidth
            , padding4 (px 15) (px 0) (px 0) (px 15)
            , textOverflow clip
            ]
        , right =
            [ borderLeft3 (px 1) solid (hex "#000000")
            , paddingLeft (px 10)
            ]
        }
    , sub = [ fontSize (px 18) ]
    , date =
        [ fontSize (px 15), float right ]
    , header =
        { container =
            [ displayFlex
            , flexDirection row
            , flexWrap wrap
            , alignItems center
            , justifyContent center
            , borderRadius (px 20)
            , border3 (px 3) solid colors.primary
            , padding (px 5)
            ]
        , name =
            [ fontSize (px 35)
            , textAlign center
            , width (pct 100)
            ]
        , info = [ fontSize (px 14) ]
        , infoitem = [ textAlign center ]
        }
    , details =
        { list =
            [ fontSize (px 16)
            , paddingLeft (px 20)
            , margin4 (px 5) (px 0) (px 7) (px 5) -- mark: maybe bigger gap
            ]
        }
    , hint =
        [ fontSize (px 15)
        , paddingBottom (px 2)
        , color (rgba 0 0 0 0.5)
        ]
    , position =
        [ fontSize (px 15)
        , fontStyle italic
        , color (rgba 0 0 0 0.9)
        ]
    }


sub children =
    div [ css styles.sub ] children


section title children =
    div [ css styles.section.container ]
        [ div [ css styles.section.left ]
            [ text (String.toUpper title) ]
        , div [ css styles.section.right ]
            children
        ]


header { name, info } =
    div [ css styles.header.container ]
        [ div [ css styles.header.name ] [ text name ]
        , div [ css styles.header.info ]
            (info
                |> String.split "\n"
                |> List.map
                    (\i ->
                        div [ css styles.header.infoitem ] [ text i ]
                    )
            )
        ]


date children =
    div [ css styles.date ] children


position children =
    div [ css styles.position ] children


details : { coursework : List String, items : List String } -> Html.Html msg
details { coursework, items } =
    ul [ css styles.details.list, class "fa-ul" ]
        ((items
            |> List.map
                (\item ->
                    li []
                        [ i [ class "fa-li fa fa-code" ] []
                        , div [ css [ paddingTop (px 2) ] ] [ text item ]
                        ]
                )
         )
            ++ (if coursework == [] then
                    []

                else
                    [ li []
                        [ i [ class "fa-li fa fa-code" ] []
                        , div [ css [ paddingTop (px 2) ] ]
                            [ span [ css [ fontSize (px 15) ] ]
                                [ span [ css [ fontWeight bold ] ] [ text "Relevant Coursework: " ]
                                , text (String.join ", " coursework)
                                ]
                            ]
                        ]
                    ]
               )
        )


content children =
    div [ css styles.content ] children


resume =
    div [ css styles.container ]
        [ header { name = "Ethan McCue", info = """mccue.et@husky.neu.edu
                                                   481 Washington St.
                                                   Pembroke, MA 02359
                                                   781-588-2411
                                                   Available Jan-June 2019""" }
        , content
            [ section "Education"
                [ sub
                    [ text "NORTHEASTERN UNIVERSITY, BOSTON, MA:"
                    , date [ text "August 2016 - Present" ]
                    ]
                , details
                    { items =
                        [ "College of Computer and Information Science"
                        , "Candidate for a Bachelor of Science in Computer Science & Physics; expected May 2020"
                        , "GPA: 3.494/4.0"
                        ]
                    , coursework =
                        [ "Algorithms (MS)"
                        , "Object Oriented Development"
                        , "Logic and Computation"
                        , "Theory of Computation"
                        , "Modern Physics"
                        , "Electronics"
                        , "Calculus III"
                        ]
                    }
                ]
            , section "TECHNICAL SKILLS"
                [ sub [ text "PROGRAMMING LANGUAGES" ]
                , details { coursework = [], items = [ "Python, Javascript, Clojure, Rust, Elm, Java" ] }
                , sub [ text "PLATFORMS AND TOOLS:" ]
                , details
                    { coursework = []
                    , items =
                        [ "Django, Flask, Express.js, and Ring for web development"
                        , "Mocha, py.test, and JUnit for unit testing"
                        , "React.js and Reagent for building user interfaces"
                        , "NumPy, SciPy, and Matplotlib numerical libraries"
                        , "Clojure, Immutables.js, and vavr for functional programming"
                        ]
                    }
                ]
            , section "PUBLIC PROJECTS"
                [ sub [ text "Emojilang" ]
                , details { coursework = [], items = [] }
                , sub [ text "django-single-page-template" ]
                , details
                    { coursework = []
                    , items = [ "A reusable template for making django apps with UIs rendered in Javascript." ]
                    }
                , sub [ text "Blogger" ]
                , details
                    { coursework = []
                    , items = [ "Microservice for serving blog posts that are written in Markdown." ]
                    }
                , div [ css styles.hint ] [ text "(more projects can be found at ", u [] [ text "github.com/bowbahdoe" ], text ")" ]
                ]
            ]
        , section "WORK EXPERIENCE"
            [ sub [ text "INTUIT: ", date [ text "January 2018 - July 2018" ] ]
            , position [ text "Software Engineering Coop" ]
            , details
                { coursework = []
                , items =
                    [ "Designed and prototyped a system for realtime sync of Q/A content between internal and external services using Kinesis and AWS Lambda"
                    , "Refactored widgets seen by millions of clients daily to a clear functional architecture using React.js and Redux."
                    , "Implemented and E2E tested a system for soft-realtime publishing of internally generated content to an external service using AWS Lambda and DynamoDB"
                    ]
                }
            , sub [ text "BAY STATE IT, BOSTON, MA: ", date [ text "September 2014 - January 2018" ] ]
            , position [ text "Programming Consultant " ]
            , details
                { coursework = []
                , items =
                    [ "Managed code architecture and testing for a realtime network diagnostic service for Shreve, Crump, and Low"
                    , "Built a credential manager chrome extension for Flagship Pioneering using Node.js and React"
                    , "Fully implemented unit and integration tests using Mocha for Bay State IT's in-house central database system"
                    ]
                }
            ]
        ]


main =
    Html.toUnstyled resume
