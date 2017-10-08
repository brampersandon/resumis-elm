module Main exposing (..)

import Components.User exposing (..)
import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import RemoteData exposing (..)


---- MODEL ----


type alias Model =
    { user : WebData User
    }


init : ( Model, Cmd Msg )
init =
    ( { user = NotAsked
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = FetchUser
    | UserResponse (WebData User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchUser ->
            ( model, requestUser )

        UserResponse res ->
            ( { model | user = res }, Cmd.none )


requestUser : Cmd Msg
requestUser =
    fetchUser
        |> RemoteData.sendRequest
        |> Cmd.map UserResponse



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
            [ text
                (case model.user of
                    NotAsked ->
                        "Initializing..."

                    Loading ->
                        "Loading..."

                    Failure err ->
                        "Error: " ++ toString err

                    Success user ->
                        user.name
                )
            ]
        , button [ onClick FetchUser ] [ text "Fetch user" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
