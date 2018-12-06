module Main exposing (main)

import Browser
import Update exposing (..)
import View exposing (..)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }
