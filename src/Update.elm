module Update exposing (Msg(..), init, subscriptions, update)

import Array
import Http exposing (..)
import Model exposing (Image, Model, imageDecoder)


type Msg
    = ShowSelected Int
    | HideSelected
    | SelectNext
    | SelectPrev
    | FetchedImg (Result Http.Error (Array.Array Image))
    | FetchImgs


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.init, Http.send FetchedImg fetchImages )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowSelected idx ->
            ( { model | selectedImg = idx, showModal = True }, Cmd.none )

        SelectNext ->
            ( { model | selectedImg = fixIdx model <| model.selectedImg + 1 }, Cmd.none )

        SelectPrev ->
            ( { model | selectedImg = fixIdx model <| model.selectedImg - 1 }, Cmd.none )

        HideSelected ->
            ( { model | showModal = False }, Cmd.none )

        FetchImgs ->
            ( model, Http.send FetchedImg fetchImages )

        FetchedImg result ->
            case result of
                Err httpError ->
                    ( model, Cmd.none )

                Ok images ->
                    ( { model | imgs = images }, Cmd.none )


fixIdx : Model -> Int -> Int
fixIdx model idx =
    modBy (Array.length model.imgs) idx



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


fetchImages : Http.Request (Array.Array Image)
fetchImages =
    Http.get "http://localhost:3000/images" imageDecoder
