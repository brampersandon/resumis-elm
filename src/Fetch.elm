module Fetch exposing (..)

import Http
import Json.Decode as Decode


---- FETCH ----


fetch : String -> String -> Decode.Decoder a -> Http.Request a
fetch host url decoder =
    Http.request
        { method = "GET"
        , headers = [ Http.header "X-Resumis-Version" "v1", Http.header "Accept" "application/vnd.resume+json" ]
        , url = host ++ url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }
