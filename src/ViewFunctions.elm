module ViewFunctions exposing (getImageCounter, getRealSizeAttribute, getShowBigScreenAttribute, getTranformScaleAttribute, getTranformTranslateAttribute, getUrlAttribute, showImg, showImgs)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String exposing (fromFloat, fromInt)
import Tuple
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
            fromFloat m.bigImageScale
    in
    "scale(" ++ scaleStr ++ ")"


getTranformTranslateAttribute : Model -> String
getTranformTranslateAttribute m =
    let
        x =
            Tuple.first m.position

        y =
            Tuple.second m.position

        translateStr =
            fromInt x ++ "px, " ++ fromInt y ++ "px"
    in
    "translate(" ++ translateStr ++ ")"


getUrlAttribute : String -> String
getUrlAttribute imgUrl =
    "url(\"" ++ imgUrl ++ "\")"


getImageCounter : Model -> String
getImageCounter m =
    fromInt m.selectedImg ++ "/" ++ (fromInt <| Array.length m.imgs)
