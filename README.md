# elm-image-gallery

Gallery for images written in Elm lang. Contains a pre-visualization with thumbnails of all images and a big screen mode to visualize on image at time. Images are yielded through JSON endpoint.

## Features
* Zoom In/Out
* Drag-and-drop
* Fit to screen
* Real size
* Shortcuts!

## Building

### Requirements
* sass
* elm
* uglifyjs

### Steps
1. Clone repository
2. run `./compile.sh`

### Compile script
When you just run the script without arguments, the SASS will be compiled to CSS, the Elm to JS and then minified. The resulting files are already integrated with index.html.

Running with elm or sass argument will compile just the sass or elm and then keep watching for modifications.

It's also possible to see the description of the commands with `--help` flag.

## Using
It's necessary to set the right url for the images end-point at the source code.

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
