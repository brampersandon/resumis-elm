module Update exposing (..)

import Components.User exposing (WebDataUser, requestUser)
import Model exposing (Model)


type Msg
    = FetchUser
    | CreateAPI String
    | UserResponse WebDataUser


updateUser : String -> Cmd Msg
updateUser root =
    requestUser root |> Cmd.map UserResponse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchUser ->
            ( model, updateUser model.apiRoot )

        CreateAPI apiRoot ->
            ( { model | apiRoot = apiRoot }, Cmd.none )

        UserResponse res ->
            ( { model | user = res }, Cmd.none )
