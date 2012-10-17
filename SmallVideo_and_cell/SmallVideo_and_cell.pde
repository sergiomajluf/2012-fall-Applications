/**
 Trick to go around averaging colors.
 Will take webcamVideoera input, copy all info to a smaller version, so we can then
 take color information from the smaller version.
 
 Thanks Dan!
 
 */

import processing.video.*;

// cellWidth * cols should equal the camera or display's resolution
// 80 * 8 = 640
// 60 * 8 = 480
int cellWidth = 80 ;
int cellHeight = 60 ;
int cols = 8;
int rows = 8;

color tempColor = 190; // initial cell color, not White nor Black

int threshold = 100; // rise to make more sensitive 
// 2D Array of objects
Cell[][] grid; 

Capture webcamVideo;
PImage small;


void setup() {
  size(640, 480);

  grid = new Cell[cols][rows];

  // Happy birthday objects!
  for (int i = 0; i < cols; i ++ ) {
    for (int j = 0; j < rows; j ++ ) {
      grid[i][j] = new Cell(i*cellWidth, j*cellHeight, cellWidth, cellHeight, tempColor);
    }
  }

  webcamVideo = new Capture(this, width, height);
  webcamVideo.start();

  small = createImage(cellWidth, cellHeight, HSB);
}      


void draw() {
  if (webcamVideo.available() == true) {
    webcamVideo.read();
    small.copy(webcamVideo, 0, 0, webcamVideo.width, webcamVideo.height, 0, 0, small.width, small.height);
    small.loadPixels();
  }

  /* for debuggin only, we don't need to display the live feed on screen
  image(webcamVideo, 0, 0);
  image(small, 0, 0);  
  */

  
  // go through the array and fill each cell
  for (int i = 0; i < cols; i ++ ) {
    for (int j = 0; j < rows; j ++ ) {

      // this is from Mirror2 Example
      int loc = (small.width - i - 1) + j*small.width; // Reversing x to mirror the image
      
      tempColor = small.pixels[loc];
      //println (tempColor);
      
      grid[i][j].updateColor(tempColor);
      grid[i][j].display();
    }
  }
}

