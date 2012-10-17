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
 - serial output
 
 */

import processing.video.*;

int pixelSizeX = 128 ;
int pixelSizeY = 64 ;
int gutter = 0;
int threshold = 150; // rise to make more sensitive 

Capture video;

void setup() {
  size(640, 480);
  noStroke();
  String[] cameras = Capture.list();
  //video = new Capture (this, width, height);
  video = new Capture(this, cameras[0]);
  video.start();
  background(0);
}

void draw() {

  if (video.available()) {

    video.read();
    video.loadPixels();

    for (int x = 0 ; x < width; x += (pixelSizeX+gutter)) {
      for (int y = 0 ; y < height; y += (pixelSizeY+gutter)) {

        // Code to mirror image
        int loc = (video.width - x - 1) + y*video.width;

        // Each rect is colored white with a size determined by brightness
        color c = video.pixels[loc];

        // fill(video.pixels[x+ y*width]);

        if (brightness(c) > threshold) fill(255);
        if (brightness(c) <= threshold) fill(0);

        //fill(brightness(c));

        rect (x, y, pixelSizeX, pixelSizeY);
      }
    }
  }
}

