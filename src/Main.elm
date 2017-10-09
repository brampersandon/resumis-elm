module Main exposing (..)

import Components.Links.View exposing (viewLinks)
import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (class, src)
import Model exposing (Model)
import RemoteData exposing (..)
import Update exposing (Msg, update, updateUser)


type alias Flags =
    { apiRoot : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { user = NotAsked
      , apiRoot = flags.apiRoot
      }
    , updateUser flags.apiRoot
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
                        , viewLinks user.links
                        ]
            ]
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = Update.update
        , subscriptions = always Sub.none
        }
