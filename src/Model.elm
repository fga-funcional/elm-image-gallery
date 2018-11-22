module Model exposing (Image, Model, getCurrentUrl, imageDecoder, init)

import Array
import Json.Decode as D


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
    Array.fromList []


initialBigImage =
    0


leftArrowImage =
    "https://image.flaticon.com/icons/svg/60/60775.svg"


rightArrowImage =
    "https://image.flaticon.com/icons/svg/60/60758.svg"


dismissButton =
    "https://www.freeiconspng.com/uploads/close-button-png-25.png"


showModal =
    False


init =
    Model initialImages initialBigImage leftArrowImage rightArrowImage dismissButton showModal


getCurrentUrl m =
    Maybe.withDefault "" <| Maybe.map .src (Array.get m.big_image m.imgs)


imageDecoder : D.Decoder (Array.Array Image)
imageDecoder =
    D.array
        (D.map3 Image
            (D.field "title" D.string)
            (D.field "description" D.string)
            (D.field "src" D.string)
        )
