// A Cell object that receives color parameter

class Cell {

  // A cell object knows about its location in the grid as well as its size with the variables x, y, w, h.
  float x, y;   // x,y location
  float w, h;   // width and height
  color myColor; // variable to receive each cell's brightness

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, color tempColor) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    myColor = tempColor;
  }

  void updateColor (color tempColor) {
    myColor = tempColor;
  }
  
  void display() {
    //noStroke();
    stroke(255);
    fill(myColor);
    rect(x, y, w, h);
  }
}

