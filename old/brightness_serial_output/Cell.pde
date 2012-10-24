// A Cell object that receives color parameter

class Cell {

  // A cell object knows about its location in the grid as well as its size with the variables x, y, w, h.
  float x, y;   // x,y location
  float w, h;   // width and height
  color myColor = 0; // variable to receive each cell's brightness
  boolean status = false;
  int outputNumber = 0;

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
    myColor = int (brightness(myColor));
    if (myColor > threshold) {
      myColor = 255;
      status = true;
      if (totalCells < cols*rows) {
        totalCells++;
      }
    }
    else if (myColor <= threshold) {
      myColor = 0;
      status = false;
      if (totalCells > 0) {
        totalCells--;
      }
    }

    fill(myColor);
    rect(x, y, w, h);
  }

  int isOn() {

    if (status) {
      outputNumber = 1;
    } 
    if (!status) {
      outputNumber = -1;
    }
    return outputNumber;
  }
}

