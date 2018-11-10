module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { imgs : Array.Array String
    , big_image : Int
    , left_arrow : String
    , right_arrow : String
    , dismiss_button : String
    , show_modal : Bool
    }


initialImages =
    Array.fromList
        [ "https://http2.mlstatic.com/240-sementes-da-abobora-halloween-verdadeira-ornamental-D_NQ_NP_848079-MLB26161444586_102017-F.jpg"
        , "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoG4PCwHlqcA7c6HQP2ijopEnf1G2_AZ9pYSuft3SCVlZrovZS"
        , "https://www.rd.com/wp-content/uploads/2016/09/09_tricks_halloween_pumpkin_flawless_mini_pumpkin_fangs_mikeasaurus.jpg"
        , "https://diy.sndimg.com/content/dam/images/diy/fullset/2007/9/26/0/MrHappypumpkin.jpg.rend.hgtvcom.966.725.suffix/1420761586663.jpeg"
        , "https://digitalspyuk.cdnds.net/16/43/480x483/gallery-1477647170-monsters-inc-pumpkin.jpg"
        , "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr3f0ij7ON3wULeiAVMj3Y36Mv2HH8Lv442wsmHOaHXYIW9SAu"
        , "https://image.freepik.com/vetores-gratis/scary-pumpkin-halloween-lanterna-vetor-realista_1441-733.jpg"
        , "https://img-new.cgtrader.com/items/770165/48a695a941/large/halloween-pumpkin-jack-o-lantern-3d-model-obj-fbx-blend-dae-mtl-abc.png"
        , "https://i.ytimg.com/vi/rjZSG9_rgF0/maxresdefault.jpg"
        , "https://www.history.com/.image/t_share/MTU3ODc4Njc0NjQ4MTQ3Njc5/hungry-history-the-halloween-pumpkin-an-american-history-2.jpg"
        , "https://i2-prod.walesonline.co.uk/incoming/article1996256.ece/ALTERNATES/s615/how-to-carve-a-halloween-pumpkin-like-a-pro-image-2-940941603.jpg"
        , "https://i2-prod.mirror.co.uk/incoming/article9023278.ece/ALTERNATES/s615b/Halloween-pumpkin-carving-ideas.jpg"
        , "https://twistedsifter.files.wordpress.com/2010/10/mars-attacks-pumpkin.jpg?w=684&h=799"
        , "http://www.leefendallhouse.org/wp-content/uploads/2014/08/pumpkins-3.jpg"
        , "http://www.stylescastle.com/wp-content/uploads/2015/10/file-7.jpeg"
        , "http://www.mgtdesign.co.uk/webdesign/wp-content/uploads/2011/10/halloween-witch-holding-pumpkin.jpg"
        , "https://cdn3-www.cattime.com/assets/uploads/gallery/30-cat-pumpkin-photos/cat-pumpkin-23z.png"
        , "https://i2-prod.derbytelegraph.co.uk/incoming/article700533.ece/ALTERNATES/s615/0_Pumpkin-halloween.jpg"
        , "https://oddstuffmagazine.com/wp-content/uploads/2011/10/Halloween-Pumpkin-Carving-Inspiration-1.jpg"
        , "https://countryandvictoriantimes.files.wordpress.com/2012/10/230897_10151196190118605_1343266549_n.jpg"
        , "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyiGok_rLazJLD-ddnGKjD33pa-rWGb3tskMrmaRpwnjom00kb"
        ]


leftArrowImage =
    "https://cdn4.iconfinder.com/data/icons/iready-symbols-arrows-vol-1/28/004_008_left_prev_previous_home_arrow_circle1x-512.png"


rightArrowImage =
    "https://www.clker.com/cliparts/J/H/k/9/3/R/go-arrow-next-hi.png"

dismissButton =
    "https://www.freeiconspng.com/uploads/close-button-png-25.png"

showModal = False


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model initialImages 0 leftArrowImage rightArrowImage dismissButton showModal
    , Cmd.none
    )



-- UPDATE


type Msg
    = ShowBig Int
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
            , img [ class "arrowButton", src m.left_arrow, onClick PrevImgBig ] []
            , img [ class "bigImg", src (getImg m m.big_image) ] []
            , img [ class "arrowButton", src m.right_arrow, onClick NextImgBig ] []
            ]
    else
        div [ class "hiddenModal" ] []

showImgs : Array.Array String -> Html Msg
showImgs img_array =
    ul [ class "gallery" ] (Array.toList (Array.indexedMap showImg img_array))


showImg : Int -> String -> Html Msg
showImg idx s =
    li [ class "imgListItem" ]
        [ img [ class "cardImg", src s, onClick (ShowBig idx) ] []
        ]


getImg : Model -> Int -> String
getImg model idx =
    let
        real_idx =
            modBy (Array.length model.imgs) idx
    in
    Maybe.withDefault "" (Array.get real_idx model.imgs)
