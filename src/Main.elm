module Main exposing (..)

import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode


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
    Http.send RequestUser fetchUser


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
    { user : User
    , error : String
    }


init : ( Model, Cmd Msg )
init =
    ( { user = emptyUser
      , error = ""
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = FetchUser
    | RequestUser (Result Http.Error User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchUser ->
            ( model, requestUser )

        RequestUser (Ok res) ->
            ( { model | user = res }, Cmd.none )

        RequestUser (Err e) ->
            ( { model | error = toString e }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div []
            [ text "This is your brain on Elm!"
            , div
                []
                [ text model.user.name
                ]
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
