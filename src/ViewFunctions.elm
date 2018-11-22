module ViewFunctions exposing (getUrlAttribute, showImg, showImgs)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Update exposing (..)


showImgs : Array.Array Image -> Html Msg
showImgs img_array =
    ul [ class "gallery" ] (Array.toList (Array.indexedMap showImg img_array))


showImg : Int -> Image -> Html Msg
showImg idx image =
    li [ class "imgListItem" ]
        [ img [ class "cardImg", src image.src, onClick (ShowSelected idx) ] []
        ]


getUrlAttribute : String -> String
getUrlAttribute imgUrl =
    "url(\"" ++ imgUrl ++ "\")"
