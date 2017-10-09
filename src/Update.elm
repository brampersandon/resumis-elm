module Update exposing (..)

import Components.User exposing (WebDataUser, requestUser)
import Model exposing (Model)


type Msg
    = FetchUser
    | UserResponse WebDataUser


updateUser =
    requestUser |> Cmd.map UserResponse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchUser ->
            ( model, updateUser )

        UserResponse res ->
            ( { model | user = res }, Cmd.none )
