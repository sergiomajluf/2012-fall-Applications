/**
 Trick to go around averaging colors.
 Will take camera input, copy all info to a smaller version, so we can then
 take color information from the smaller version.
 
 Thanks Dan!
 
 */

import processing.video.*;

Capture cam;
PImage small;

void setup() {
  size(640, 480);

  cam = new Capture(this, width, height);
  cam.start();

  //small = createImage(cols,rows,RGB);
  small = createImage(80, 60, HSB);
}      


void draw() {
  if (cam.available() == true) {
    cam.read();
    small.copy(cam, 0, 0, cam.width, cam.height, 0, 0, small.width, small.height);
    small.updatePixels();
  }
  image(cam, 0, 0);

  image(small, 0, 0);

  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}

