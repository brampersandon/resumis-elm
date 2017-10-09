module Components.Links.View exposing (..)

import Components.User exposing (Link, Links)
import Html exposing (Html, a, div, i, text)
import Html.Attributes exposing (class, href)
import Update exposing (Msg)


iconForLink : Link -> Html Msg
iconForLink link =
    i
        [ class ("fa fa-" ++ link.meta.rel)
        ]
        []


viewLink : Link -> Html Msg
viewLink link =
    div [ class link.meta.rel ]
        [ iconForLink link
        , a [ href link.href ] [ text link.meta.title ]
        ]


viewLinks : Links -> Html Msg
viewLinks links =
    div [ class "links" ]
        [ viewLink links.twitter
        , viewLink links.github
        , viewLink links.linkedin
        , viewLink links.medium
        ]
