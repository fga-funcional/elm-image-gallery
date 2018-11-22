module View exposing (displayModal, view)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Update exposing (..)
import ViewFunctions exposing (..)


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ h1 [] [ text "Welcome to the Gallery!!!" ]
        , showImgs model.imgs
        , displayModal model
        ]


displayModal : Model -> Html Msg
displayModal m =
    if m.showModal == True then
        div []
            [ div [ class "overlay" ] []
            , div [ class "bigScreenModal", style "background-image" (getUrlAttribute <| getCurrentUrl m) ]
                [ img [ class "dismissButton", src m.dismissButton, onClick HideSelected ] []
                , img [ class "leftArrowButton", src m.leftArrowButton, onClick SelectPrev ] []
                , img [ class "rightArrowButton", src m.rightArrowButton, onClick SelectNext ] []
                , div [ class "toolsBar" ]
                    [ img [ class "toolButton", src m.realSizeButton ] []
                    , img [ class "toolButton", src m.fullScreenButton ] []
                    ]
                ]
            ]

    else
        div [ class "hiddenModal" ] []
