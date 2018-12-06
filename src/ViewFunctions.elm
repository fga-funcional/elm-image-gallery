module ViewFunctions exposing (getRealSizeAttribute, getShowBigScreenAttribute, getTranformScaleAttribute, getUrlAttribute, showImg, showImgs)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String exposing (fromFloat)
import Update exposing (..)


showImgs : Array.Array Image -> Html Msg
showImgs imgArray =
    ul [ class "gallery" ] (Array.toList (Array.indexedMap showImg imgArray))


showImg : Int -> Image -> Html Msg
showImg idx image =
    li [ class "imgListItem" ]
        [ img [ class "cardImg", src image.src, onClick (ShowSelected idx) ] []
        ]


getRealSizeAttribute : Model -> String
getRealSizeAttribute m =
    if m.showRealSize then
        "auto"

    else
        "contain"


getShowBigScreenAttribute : Model -> String
getShowBigScreenAttribute m =
    if m.showBigScreen then
        "inline"

    else
        "none"


getTranformScaleAttribute : Model -> String
getTranformScaleAttribute m =
    let
        scaleStr =
            fromFloat m.bigScreenScale
    in
    "scale(" ++ scaleStr ++ ")"


getUrlAttribute : String -> String
getUrlAttribute imgUrl =
    "url(\"" ++ imgUrl ++ "\")"
