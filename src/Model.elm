module Model exposing (Image, Model, getCurrentUrl, imageDecoder, init)

import Array
import Json.Decode as D


type alias Model =
    { imgs : Array.Array Image
    , selectedImg : Int
    , leftArrow : String
    , rightArrow : String
    , dismissButton : String
    , showModal : Bool
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


dismissButton =
    "https://png.pngtree.com/svg/20170503/pop_ico_close_1353709.png"


showModal =
    False


init =
    Model initialImages initialBigImage leftArrowImage rightArrowImage dismissButton showModal


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
