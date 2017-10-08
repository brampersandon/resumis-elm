module Fetch exposing (..)

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
        , url = host ++ url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }
