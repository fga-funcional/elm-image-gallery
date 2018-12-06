module View exposing (view)

import Array
import Draggable
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String exposing (fromInt)
import Update exposing (..)
import ViewFunctions exposing (..)


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ h1 [] [ text "Elm Image Gallery" ]
        , showImgs model.imgs
        , bigScreenModal model
        ]


bigScreenModal m =
    div [ style "display" <| getShowBigScreenAttribute m ]
        [ div [ class "overlay" ] []
        , div
            [ class "bigImage"
            , style "background-image" <| getUrlAttribute <| getCurrentUrl m
            , style "background-size" <| getRealSizeAttribute m
            , style "transform" (getTranformTranslateAttribute m ++ getTranformScaleAttribute m)
            , Draggable.mouseTrigger "big-image" DragMsg
            ]
            []
        , div [ class "bigScreenModal" ]
            [ img [ class "dismissButton", src m.dismissButton, onClick HideSelected ] []
            , img [ class "leftArrowButton", src m.leftArrowButton, onClick SelectPrev ] []
            , img [ class "rightArrowButton", src m.rightArrowButton, onClick SelectNext ] []
            , div [ class "toolsBar" ]
                [ img [ class "toolButton", src m.realSizeButton, onClick ShowRealSize ] []
                , img [ class "toolButton", src m.fullScreenButton, onClick ShowResized ] []
                , img [ class "toolButton", src m.zoomInButton, onClick ZoomInBigScreen ] []
                , img [ class "toolButton", src m.zoomOutButton, onClick ZoomOutBigScreen ] []
                ]
            , div [ class "counter" ]
                [ text (getImageCounter m)
                ]
            ]
        ]
