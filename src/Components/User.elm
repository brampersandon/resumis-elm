module Components.User exposing (..)

import Fetch exposing (fetch)
import Http
import Json.Decode as Decode


fetchUser : Http.Request User
fetchUser =
    fetch "/api/users/1" decodeUser


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
