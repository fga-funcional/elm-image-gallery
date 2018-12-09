module Update exposing (Msg(..), init, subscriptions, update)

import Array
import Browser.Events exposing (onKeyDown)
import Draggable
import Html.Events exposing (keyCode)
import Http exposing (..)
import Json.Decode as D
import Model exposing (Image, Model, imageDecoder, imagesPath)


type Msg
    = ShowSelected Int
    | ShowCurrent
    | ShowRealSize
    | ShowResized
    | ZoomInBigScreen
    | ZoomOutBigScreen
    | ResetBigScreenScale
    | HideSelected
    | SelectNext
    | SelectPrev
    | FetchedImg (Result Http.Error (Array.Array Image))
    | FetchImgs
    | OnDragBy Draggable.Delta
    | DragMsg (Draggable.Msg String)
    | NoOp


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.init, Http.send FetchedImg fetchImages )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ position } as model) =
    case msg of
        ShowSelected idx ->
            ( { model | selectedImg = idx, showBigScreen = True }, Cmd.none )

        ShowCurrent ->
            ( { model | showBigScreen = True }, Cmd.none )

        ShowResized ->
            ( { model | showRealSize = False, bigImageScale = 1 }, Cmd.none )

        ShowRealSize ->
            ( { model | showRealSize = True, bigImageScale = 1 }, Cmd.none )

        ZoomInBigScreen ->
            ( { model | bigImageScale = min 10 <| max 0.05 <| model.bigImageScale + 0.1 * model.bigImageScale }, Cmd.none )

        ZoomOutBigScreen ->
            if model.bigImageScale > 1 then
                ( { model | bigImageScale = min 10 <| max 0.05 <| model.bigImageScale - 0.1 * model.bigImageScale }, Cmd.none )

            else
                ( { model | bigImageScale = min 10 <| max 0.05 <| model.bigImageScale - 0.1 * model.bigImageScale, position = ( 0, 0 ) }, Cmd.none )

        ResetBigScreenScale ->
            ( { model | bigImageScale = 1, position = ( 0, 0 ) }, Cmd.none )

        SelectNext ->
            if model.showBigScreen then
                ( { model | selectedImg = fixIdx model <| model.selectedImg + 1, bigImageScale = 1, position = ( 0, 0 ) }, Cmd.none )

            else
                ( model, Cmd.none )

        SelectPrev ->
            if model.showBigScreen then
                ( { model | selectedImg = fixIdx model <| model.selectedImg - 1, bigImageScale = 1, position = ( 0, 0 ) }, Cmd.none )

            else
                ( model, Cmd.none )

        HideSelected ->
            ( { model | showBigScreen = False, bigImageScale = 1, position = ( 0, 0 ) }, Cmd.none )

        FetchImgs ->
            ( model, Http.send FetchedImg fetchImages )

        FetchedImg result ->
            case result of
                Err httpError ->
                    ( model, Cmd.none )

                Ok images ->
                    ( { model | images = images }, Cmd.none )

        OnDragBy ( dx, dy ) ->
            let
                ( x, y ) =
                    position
            in
            if model.bigImageScale > 1.0 then
                ( { model | position = ( x + round dx, y + round dy ) }, Cmd.none )

            else
                ( { model | position = ( 0, 0 ) }, Cmd.none )

        DragMsg dragMsg ->
            Draggable.update dragConfig dragMsg model

        _ ->
            ( model, Cmd.none )



-- UTIL FUNCTIONS


fixIdx : Model -> Int -> Int
fixIdx model idx =
    modBy (Array.length model.images) idx


dragConfig : Draggable.Config String Msg
dragConfig =
    Draggable.basicConfig OnDragBy



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onKeyDown (D.map getKey keyCode)
        , Draggable.subscriptions DragMsg model.drag
        ]



-- HTTP


fetchImages : Http.Request (Array.Array Image)
fetchImages =
    Http.get imagesPath imageDecoder



-- SHORTCUTS


getKey : Int -> Msg
getKey keycode =
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

        -- plus
        61 ->
            ZoomInBigScreen

        -- plus numeric
        107 ->
            ZoomInBigScreen

        -- minus
        173 ->
            ZoomOutBigScreen

        -- minus numeric
        109 ->
            ZoomOutBigScreen

        -- 0
        48 ->
            ResetBigScreenScale

        -- 0 numeric
        96 ->
            ResetBigScreenScale

        _ ->
            NoOp
