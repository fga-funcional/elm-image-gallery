module Model exposing (Image, Model, getCurrentDescription, getCurrentUrl, imageDecoder, imagesPath, init)

import Array
import Draggable
import Json.Decode as D


imagesPath =
    "http://localhost:3000/images"


type alias Model =
    { images : Array.Array Image
    , selectedImg : Int
    , showBigScreen : Bool
    , showRealSize : Bool
    , bigImageScale : Float
    , leftArrowButton : String
    , rightArrowButton : String
    , dismissButton : String
    , realSizeButton : String
    , fullScreenButton : String
    , zoomInButton : String
    , zoomOutButton : String
    , position : ( Int, Int )
    , drag : Draggable.State String
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


bigImageScale =
    1.0


position =
    ( 0, 0 )


drag =
    Draggable.init


init =
    Model initialImages initialBigImage showBigScreen showRealSize bigImageScale leftArrowImage rightArrowImage dismissImage realSizeImage fullScreenImage zoomIn zoomOut position drag


getCurrentUrl : Model -> String
getCurrentUrl m =
    Maybe.withDefault "" <| Maybe.map .src (Array.get m.selectedImg m.images)


getCurrentDescription : Model -> String
getCurrentDescription m =
    Maybe.withDefault "" <| Maybe.map .description (Array.get m.selectedImg m.images)


imageDecoder : D.Decoder (Array.Array Image)
imageDecoder =
    D.array
        (D.map3 Image
            (D.field "title" D.string)
            (D.field "description" D.string)
            (D.field "src" D.string)
        )
