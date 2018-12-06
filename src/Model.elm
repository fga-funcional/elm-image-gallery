module Model exposing (Image, Model, getCurrentUrl, imageDecoder, init)

import Array
import Json.Decode as D


type alias Model =
    { imgs : Array.Array Image
    , selectedImg : Int
    , showBigScreen : Bool
    , showRealSize : Bool
    , bigScreenScale : Float
    , leftArrowButton : String
    , rightArrowButton : String
    , dismissButton : String
    , realSizeButton : String
    , fullScreenButton : String
    , zoomInButton : String
    , zoomOutButton : String
    }


type alias Image =
    { title : String
    , description : String
    , src : String
    }


initialImages =
    Array.fromList []


initialBigImage =
    0


leftArrowImage =
    "https://image.flaticon.com/icons/svg/60/60775.svg"


rightArrowImage =
    "https://image.flaticon.com/icons/svg/60/60758.svg"


dismissImage =
    "https://png.pngtree.com/svg/20170503/pop_ico_close_1353709.png"


realSizeImage =
    "https://cdn.iconscout.com/icon/premium/png-256-thumb/zoom-to-actual-size-1-561733.png"


fullScreenImage =
    "https://static.thenounproject.com/png/280-200.png"


zoomIn =
    "https://cdn0.iconfinder.com/data/icons/controls-and-navigation-arrows-1/24/26-512.png"


zoomOut =
    "https://cdn0.iconfinder.com/data/icons/huge-black-icons/512/Zoom_out.png"


showBigScreen =
    False


showRealSize =
    False


bigScreenScale =
    1.0


init =
    Model initialImages initialBigImage showBigScreen showRealSize bigScreenScale leftArrowImage rightArrowImage dismissImage realSizeImage fullScreenImage zoomIn zoomOut


getCurrentUrl m =
    Maybe.withDefault "" <| Maybe.map .src (Array.get m.selectedImg m.imgs)


imageDecoder : D.Decoder (Array.Array Image)
imageDecoder =
    D.array
        (D.map3 Image
            (D.field "title" D.string)
            (D.field "description" D.string)
            (D.field "src" D.string)
        )
