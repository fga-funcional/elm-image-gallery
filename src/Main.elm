module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Dict
import Browser
import Http exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D
import Json.Encode as E



-- MAIN


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { imgs : Array.Array Image
    , big_image : Int
    , left_arrow : String
    , right_arrow : String
    , dismiss_button : String
    , show_modal : Bool
    }

type alias Image =
    { title : String
    , description : String
    , src : String
    }

initialImages =
    Array.fromList
        [ (Image "" "" "https://www.rd.com/wp-content/uploads/2016/09/09_tricks_halloween_pumpkin_flawless_mini_pumpkin_fangs_mikeasaurus.jpg")
        , (Image "" "" "https://i2-prod.walesonline.co.uk/incoming/article1996256.ece/ALTERNATES/s615/how-to-carve-a-halloween-pumpkin-like-a-pro-image-2-940941603.jpg")
        ]

leftArrowImage =
    "https://image.flaticon.com/icons/svg/60/60775.svg"


rightArrowImage =
    "https://image.flaticon.com/icons/svg/60/60758.svg"

dismissButton =
    "https://www.freeiconspng.com/uploads/close-button-png-25.png"

showModal = False


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model initialImages 0 leftArrowImage rightArrowImage dismissButton showModal
    , Http.send GotImages getImages
    )



-- UPDATE


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


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Welcome to the Gallery!!!" ]
        , showImgs model.imgs
        , displayModal model
        ]

displayModal : Model -> Html Msg
displayModal m =
    if m.show_modal == True then
        div [ class "bigImgModal" ]
            [ img [ class "dismissButton", src m.dismiss_button, onClick CloseBig ] []
            , img [ class "leftArrowButton", src m.left_arrow, onClick PrevImgBig ] []
            , img [ class "rightArrowButton", src m.right_arrow, onClick NextImgBig ] []
            , img [ class "bigImg", src (getImg m m.big_image) ] []
            ]
    else
        div [ class "hiddenModal" ] []

showImgs : Array.Array Image -> Html Msg
showImgs img_array =
    ul [ class "gallery" ] (Array.toList (Array.indexedMap showImg img_array))


showImg : Int -> Image -> Html Msg
showImg idx image =
    li [ class "imgListItem" ]
        [ img [ class "cardImg", src image.src, onClick (ShowBig idx) ] []
        ]

getImg : Model -> Int -> String
getImg model idx =
    let
        real_idx =
            modBy (Array.length model.imgs) idx
    in
    (Maybe.withDefault (Image "" "" "") (Array.get real_idx model.imgs)).src

----------------------------
-- Decoders
----------------------------

imageDecoder : D.Decoder (Array.Array Image)
imageDecoder =
    D.array (
        D.map3 Image
            (D.field "title" D.string)
            (D.field "description" D.string)
            (D.field "src" D.string)
    )

getImages : Http.Request (Array.Array Image)
getImages =
    Http.get "http://localhost:3000/images" imageDecoder