module Update exposing (Msg(..), init, subscriptions, update)

import Array
import Http exposing (..)
import Model exposing (Image, Model, imageDecoder)


type Msg
    = ShowBig Int
    | GotImages (Result Http.Error (Array.Array Image))
    | GetImages
    | NextImgBig
    | PrevImgBig
    | CloseBig


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowBig idx ->
            ( { model | big_image = idx, show_modal = True }, Cmd.none )

        NextImgBig ->
            ( { model | big_image = model.big_image + 1 }, Cmd.none )

        PrevImgBig ->
            ( { model | big_image = model.big_image - 1 }, Cmd.none )

        CloseBig ->
            ( { model | show_modal = False }, Cmd.none )

        GetImages ->
            ( model, Http.send GotImages getImages )

        GotImages result ->
            case result of
                Err httpError ->
                    ( model, Cmd.none )

                Ok images ->
                    ( { model | imgs = images }, Cmd.none )


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.init, Http.send GotImages getImages )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getImages : Http.Request (Array.Array Image)
getImages =
    Http.get "http://localhost:3000/images" imageDecoder
