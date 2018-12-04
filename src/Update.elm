module Update exposing (Msg(..), init, subscriptions, update)

import Array
import Browser.Events exposing (onKeyDown)
import Html.Events exposing (keyCode)
import Http exposing (..)
import Json.Decode as Decode
import Model exposing (Image, Model, imageDecoder)


type Msg
    = ShowSelected Int
    | ShowCurrent
    | ShowRealSize
    | ShowResized
    | HideSelected
    | SelectNext
    | SelectPrev
    | FetchedImg (Result Http.Error (Array.Array Image))
    | FetchImgs
    | NoOp


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.init, Http.send FetchedImg fetchImages )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowSelected idx ->
            ( { model | selectedImg = idx, showBigScreen = True }, Cmd.none )

        ShowCurrent ->
            ( { model | showBigScreen = True }, Cmd.none )

        ShowResized ->
            ( { model | showRealSize = False }, Cmd.none )

        ShowRealSize ->
            ( { model | showRealSize = True }, Cmd.none )

        SelectNext ->
            ( { model | selectedImg = fixIdx model <| model.selectedImg + 1 }, Cmd.none )

        SelectPrev ->
            ( { model | selectedImg = fixIdx model <| model.selectedImg - 1 }, Cmd.none )

        HideSelected ->
            ( { model | showBigScreen = False }, Cmd.none )

        FetchImgs ->
            ( model, Http.send FetchedImg fetchImages )

        FetchedImg result ->
            case result of
                Err httpError ->
                    ( model, Cmd.none )

                Ok images ->
                    ( { model | imgs = images }, Cmd.none )

        _ ->
            ( model, Cmd.none )


fixIdx : Model -> Int -> Int
fixIdx model idx =
    modBy (Array.length model.imgs) idx


key : Bool -> Int -> Msg
key isDown keycode =
    case keycode of
        -- left
        37 ->
            SelectPrev

        -- left - vim like
        72 ->
            SelectPrev

        -- right
        39 ->
            SelectNext

        -- right - vim like
        76 ->
            SelectNext

        -- enter
        13 ->
            ShowCurrent

        -- esc
        27 ->
            HideSelected

        -- r
        82 ->
            ShowRealSize

        -- f
        70 ->
            ShowResized

        _ ->
            NoOp



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onKeyDown (Decode.map (key True) keyCode)
        ]



-- HTTP


fetchImages : Http.Request (Array.Array Image)
fetchImages =
    Http.get "http://localhost:3000/images" imageDecoder
