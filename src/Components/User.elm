module Components.User exposing (..)

import Fetch exposing (fetch)
import Http
import Json.Decode as Decode
import RemoteData exposing (..)


fetchUser : String -> Http.Request User
fetchUser root =
    fetch root "/api/users/1" decodeUser


requestUser : String -> Cmd WebDataUser
requestUser root =
    fetchUser root
        |> RemoteData.sendRequest


type alias WebDataUser =
    WebData User


type alias User =
    { avatarUrl : String
    , name : String
    , links : Links
    }


type alias Links =
    { twitter : Link
    , github : Link
    , medium : Link
    , linkedin : Link
    }


type alias Link =
    { href : String
    , meta : LinkMeta
    }


type alias LinkMeta =
    { rel : String
    , title : String
    }


decodeUser : Decode.Decoder User
decodeUser =
    Decode.map3 User
        (Decode.at [ "data", "attributes", "avatar_url" ] Decode.string)
        (Decode.at [ "data", "attributes", "full_name" ] Decode.string)
        (Decode.at [ "data", "links" ] decodeLinks)


decodeLinks : Decode.Decoder Links
decodeLinks =
    Decode.map4 Links
        (Decode.at [ "twitter" ] decodeLink)
        (Decode.at [ "github" ] decodeLink)
        (Decode.at [ "medium" ] decodeLink)
        (Decode.at [ "linkedin" ] decodeLink)


decodeLink : Decode.Decoder Link
decodeLink =
    Decode.map2 Link
        (Decode.at [ "href" ] Decode.string)
        (Decode.at [ "meta" ] decodeLinkMeta)


decodeLinkMeta : Decode.Decoder LinkMeta
decodeLinkMeta =
    Decode.map2 LinkMeta
        (Decode.at [ "rel" ] Decode.string)
        (Decode.at [ "title" ] Decode.string)
