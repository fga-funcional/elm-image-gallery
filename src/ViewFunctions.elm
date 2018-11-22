module ViewFunctions exposing (getImg, getUrlAttribute, showImg, showImgs)

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
        [ img [ class "cardImg", src image.src, onClick (ShowBig idx) ] []
        ]


getImg : Model -> Int -> String
getImg model idx =
    let
        real_idx =
            modBy (Array.length model.imgs) idx
    in
    (Maybe.withDefault (Image "" "" "") (Array.get real_idx model.imgs)).src


getUrlAttribute : String -> String
getUrlAttribute imgUrl =
    "url(\"" ++ imgUrl ++ "\")"
