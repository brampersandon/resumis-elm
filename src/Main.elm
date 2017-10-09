module Main exposing (..)

import Components.Links.Twitter exposing (viewTwitter)
import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (class, src)
import Model exposing (Model)
import RemoteData exposing (..)
import Update exposing (Msg, update, updateUser)


init : ( Model, Cmd Msg )
init =
    ( { user = NotAsked
      }
    , updateUser
    )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img
            [ src
                (case model.user of
                    NotAsked ->
                        "/logo.svg"

                    Loading ->
                        "/logo.svg"

                    Failure err ->
                        "/logo.svg"

                    Success user ->
                        user.avatarUrl
                )
            ]
            []
        , div []
            [ case model.user of
                NotAsked ->
                    text "Initializing..."

                Loading ->
                    text "Loading..."

                Failure err ->
                    text ("Error: " ++ toString err)

                Success user ->
                    div []
                        [ text user.name
                        , viewTwitter user.links.twitter
                        ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = Update.update
        , subscriptions = always Sub.none
        }
