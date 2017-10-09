module Components.Links.Twitter exposing (..)

import Components.User exposing (Link)
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class, href)
import Update exposing (Msg)


viewTwitter : Link -> Html Msg
viewTwitter link =
    div [ class "Twitter" ]
        [ a [ href link.href ] [ text link.meta.title ]
        ]
