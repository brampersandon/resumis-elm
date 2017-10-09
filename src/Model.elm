module Model exposing (..)

import Components.User exposing (WebDataUser)


type alias Model =
    { user : WebDataUser
    , apiRoot : String
    }
