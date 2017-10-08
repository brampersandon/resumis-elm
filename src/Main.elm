module Main exposing (..)

import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import RemoteData exposing (..)


host : String
host =
    "http://localhost:5000"



---- FETCH ----


fetch : String -> Decode.Decoder a -> Http.Request a
fetch url decoder =
    Http.request
        { method = "GET"
        , headers = [ Http.header "X-Resumis-Version" "v1", Http.header "Accept" "application/vnd.resume+json" ]
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }


fetchUser : Http.Request User
fetchUser =
    fetch (host ++ "/api/users/1") decodeUser


requestUser : Cmd Msg
requestUser =
    fetchUser
        |> RemoteData.sendRequest
        |> Cmd.map UserResponse


type alias User =
    { avatarUrl : String
    , name : String
    , twitterUrl : String
    }


decodeUser : Decode.Decoder User
decodeUser =
    Decode.map3 User
        (Decode.at [ "data", "attributes", "avatar_url" ] Decode.string)
        (Decode.at [ "data", "attributes", "full_name" ] Decode.string)
        (Decode.at [ "data", "links", "twitter", "href" ] Decode.string)


emptyUser : User
emptyUser =
    { avatarUrl = "https://www.gravatar.com/avatar"
    , name = "Joe Schmoe"
    , twitterUrl = "https://twitter.com"
    }



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
