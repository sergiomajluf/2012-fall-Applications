/*
 
 Capture live video, and sort it like a checkerboard (large pixels), 
 then detect bright pixels according to a predefined threshold.
 
 Then act upond, sending serial data.
 
 Sergio Majluf
 ITP - October 2012
 
 to do:
 - better understand mirroring
 - develop coordinate system to act upon bright pixels
 - check performance/stability
 - check modularity
 
 */

import processing.video.*;

int pixelSizeX = 80 ;
int pixelSizeY = 60 ;
int cols = 8;
int rows = 8;
int gutter = 0;
int threshold = 200; // rise to make more sensitive 

Capture video;
Cell[][] grid; 

void setup() {
  size(640, 480);
  noStroke();
  video = new Capture (this, width, height);
  video.start();

  grid = new Cell[cols][rows];

  for (int i = 0; i < cols; i ++ ) {
    for (int j = 0; j < rows; j ++ ) {
      grid[i][j] = new Cell(i*cellWidth, j*cellHeight, cellWidth, cellHeight, c);
    }
  }

  background(0);
}

void draw() {

  if (video.available()) {

    video.read();
    video.loadPixels();

    for (int x = 0 ; x < width; x += (pixelSizeX)) {
      for (int y = 0 ; y < height; y += (pixelSizeY)) {

        // this is from Mirror2 Example

        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image

        // Each rect is colored white with a size determined by brightness
        color c = video.pixels[loc];

        // fill(video.pixels[x+ y*width]);

        if (brightness(c) > threshold) fill(255);
        if (brightness(c) <= threshold) fill(0);

        // fill(brightness(c));

        rect (x, y, pixelSizeX, pixelSizeY);
      }
    }
  }
}

