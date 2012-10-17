/*
 
 Capture live video, and sort it like a checkerboard (large pixels), 
 then detect bright pixels according to a predefined threshold.
 
 Then act upond, sending serial data.
 
 Sergio Majluf
 ITP - October 2012
 
 to do:
 - Better understand mirroring
 
 - Develop coordinate system to act upon bright pixels
 » Half done - from Learning Processing example 13-10 two dimensional arrays
 
 - Check performance/stability
 
 - Check modularity
 
 */

import processing.video.*;

int cellWidth = 80 ;
int cellHeight = 60 ;
int cols = 8;
int rows = 8;

int gutter = 0;

color c = 190; // initial cell color, not White nor Black
color tempColor = 190; // initial cell color, not White nor Black
int threshold = 190; // rise to make more sensitive 

// 2D Array of objects
Cell[][] grid; 

Capture video;

void setup() {
  size(640, 480);

  grid = new Cell[cols][rows];

  // Happy birthday objects!
  for (int i = 0; i < cols; i ++ ) {
    for (int j = 0; j < rows; j ++ ) {
      grid[i][j] = new Cell(i*cellWidth, j*cellHeight, cellWidth, cellHeight, c);
    }
  }

  video = new Capture (this, width, height);
  video.start();

  //background(0);
}

void draw() {

  if (video.available()) {

    video.read();
    video.loadPixels();


    // go through the array and fill each cell
    for (int i = 0; i < cols; i ++ ) {
      for (int j = 0; j < rows; j ++ ) {

        for (int x = 0 ; x < width; x += (cellWidth+gutter)) {
          for (int y = 0 ; y < height; y += (cellHeight+gutter)) {

            // this is from Mirror2 Example
            int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image

            color tempColor = int(brightness(video.pixels[loc]));

            if (tempColor > threshold) tempColor = 255;
            if (tempColor <= threshold) tempColor = 0;

            //println(tempColor);
            // Initialize each object
            //grid[i][j] = new Cell(i*cellWidth, j*cellHeight, cellWidth, cellHeight, tempColor);


            fill(video.pixels[loc]);
            rect (x, y, cellWidth, cellHeight);
          }
        }
        grid[i][j].updateColor(tempColor);
        grid[i][j].display();
      }
    }
  }
}

