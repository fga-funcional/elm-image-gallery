module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { img : String }


init : Model
init =
    { img = "https://http2.mlstatic.com/240-sementes-da-abobora-halloween-verdadeira-ornamental-D_NQ_NP_848079-MLB26161444586_102017-F.jpg" }



------------------------------------


type Msg
    = Init String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Init s ->
            { model | img = s }



------------------------------------


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello!" ]
        , img [ src model.img ] []
        ]
