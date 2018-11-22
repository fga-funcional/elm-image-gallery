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
    if m.show_modal == True then
        div []
            [ div [ class "overlay" ] []
            , div [ class "modal", style "background-image" (getUrlAttribute <| getCurrentUrl m) ]
                [ img [ class "dismissButton", src m.dismiss_button, onClick CloseBig ] []
                , img [ class "leftArrowButton", src m.left_arrow, onClick PrevImgBig ] []
                , img [ class "rightArrowButton", src m.right_arrow, onClick NextImgBig ] []
                ]
            ]

    else
        div [ class "hiddenModal" ] []
