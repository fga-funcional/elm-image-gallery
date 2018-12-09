# elm-image-gallery

Gallery for images written in Elm lang. Contains a pre-visualization with thumbnails of all images and a big screen mode to visualize on image at time. Images are yielded through JSON endpoint.

## Features
* Zoom In/Out
* Drag-and-drop
* Fit to screen
* Real size
* Shortcuts!

### Shortchuts
* **Enter:** Go full screen
* **Esc:** Exit full screen
* **Right Arrow:** Next image
* **Left Arrow:** Previous image
* **h:** Previous image _(vim like)_
* **l:** Next image _(vim like)_
* **+:** Zoom in _(numeric keyboard also)_
* **-:** Zoom out _(numeric keyboard also)_
* **r:** Real size
* **f:** Fit to screen

### Screens

#### All images
![Thumbnails](https://raw.githubusercontent.com/fga-funcional/elm-image-gallery/master/images/Elm-image-gallery-thumbnails.png)

#### Visualizing image
![Big Screen](https://github.com/fga-funcional/elm-image-gallery/blob/master/images/Elm-image-gallery-big-screen.png)

## Building

### Requirements
* sass
* elm
* uglifyjs

### Steps
1. Clone repository
2. Run `./compile.sh`

### Compile script
When you just run the script without arguments, the SASS will be compiled to CSS, the Elm to JS and then minified. The resulting files are already integrated with index.html.

Running with elm or sass argument will compile just the sass or elm and then keep watching for modifications.

It's also possible to see the description of the commands with `--help` flag.

## Using
It's necessary to set the right url for the images end-point at the source code. To this change the imagesPath constant value at [Model.elm](https://github.com/fga-funcional/elm-image-gallery/blob/master/src/Model.elm#L8) .

### Expected JSON
The input Json is a list in which each element must have the following fields:

* **src:** With the path to the image, local or online
* **title:** A title for the image
* **description:** A description for the image, it will be shown on the image visualization

```json
[
  {
  "src": "https://myimage.com/",
   "title": "Title",
   "description":"Description"
  },
  {
   "src": "https://myimage.com/",
   "title": "Title",
   "description":"Description"
   }
]
```
