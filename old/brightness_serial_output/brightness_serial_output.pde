/**
 Trick to go around averaging colors.
 Will take webcamVideoera input, copy all info to a smaller version, so we can then
 take color information from the smaller version.
 
 Output serial (3 pair of bytes ON/OFF) data to control digital pins in the Arduino
 
 ITP - OCTOBER 2012
 APPLICATION PRESENTATION 
 
 Brightness Detection coded and Serial out by Sergio Majluf

 
 */
import processing.video.*;
import processing.serial.*;     // import the Processing serial library
Serial port;                  // The serial port


// cellWidth * cols should equal the camera or display's resolution
// 80 * 8 = 640
// 60 * 8 = 480
int cellWidth = 80 ;
int cellHeight = 60 ;
int cols = 8;
int rows = 8;
int loc;
String estado, estado1, estado2, estado3;

boolean gridA, gridB, gridC, gridD, gridE, gridF, gridG, gridH, gridI = false;

long lastTime = 0;
int totalCells = 0;

color tempColor = 190; // initial cell color, not White nor Black
//float vol, rate;

int threshold = 150; // rise to make more sensitive 
// 2D Array of objects
Cell[][] grid; 

Capture webcamVideo;
PImage small;


void setup() {
  size(640, 480);

  grid = new Cell[cols][rows];
  frameRate(30);


  // Happy birthday objects!
  for (int i = 0; i < cols; i ++ ) {
    for (int j = 0; j < rows; j ++ ) {
      grid[i][j] = new Cell(i*cellWidth, j*cellHeight, cellWidth, cellHeight, tempColor);
    }
  }

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    //webcamVideo = new Capture(this, width, height);
    webcamVideo = new Capture(this, cameras[0]);
    webcamVideo.start();

    small = createImage(cellWidth, cellHeight, HSB);
  }

  lastTime = millis();

  println(Serial.list());
  // adjust index to the arduino board in next line
  port = new Serial(this, Serial.list()[4], 9600); 
  // read bytes into a buffer until you get a linefeed (ASCII 10):
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
      loc = (small.width - i - 1) + j*small.width; // Reversing x to mirror the image

      tempColor = small.pixels[loc];

      grid[i][j].updateColor(tempColor);
      grid[i][j].display();
      //println(totalCells);
      waitForMe();
    }
  }

  if ( 
  grid[0][0].status == true && grid[1][0].status == true &&
    grid[0][1].status == true && grid[1][1].status == true &&
    grid[0][2].status == true && grid[1][2].status == true) {
    gridA = true;
  } 
  else {
    gridA = false;
  }
  if ( 
  grid[2][0].status == true && grid[3][0].status == true && grid[4][0].status == true &&
    grid[2][1].status == true && grid[3][1].status == true && grid[4][1].status == true &&
    grid[2][2].status == true && grid[3][2].status == true && grid[4][2].status == true) {
    gridB = true;
  } 
  else {
    gridB = false;
  }

  if ( 
  grid[5][0].status == true && grid[6][0].status == true && grid[7][0].status == true &&
    grid[5][1].status == true && grid[6][1].status == true && grid[7][1].status == true &&
    grid[5][2].status == true && grid[6][2].status == true && grid[7][2].status == true) {
    gridC = true;
  } 
  else {
    gridC = false;
  }

  if ( 
  grid[0][3].status == true && grid[1][3].status == true &&
    grid[0][4].status == true && grid[1][4].status == true &&
    grid[0][5].status == true && grid[1][5].status == true ) {
    gridD = true;
  } 
  else {
    gridD = false;
  }
  if ( 
  grid[2][3].status == true && grid[3][3].status == true && grid[4][3].status == true &&
    grid[2][4].status == true && grid[3][4].status == true && grid[4][4].status == true &&
    grid[2][5].status == true && grid[3][5].status == true &&  grid[4][5].status == true) {
    gridE = true;
  } 
  else {
    gridE = false;
  }
  if ( 
  grid[5][3].status == true && grid[6][3].status == true && grid[7][3].status == true &&
    grid[5][4].status == true && grid[6][4].status == true && grid[7][4].status == true &&
    grid[5][5].status == true && grid[6][5].status == true && grid[7][5].status == true) {
    gridF = true;
  } 
  else {
    gridF = false;
  }

  if ( 
  grid[0][6].status == true && grid[1][6].status == true &&
    grid[0][7].status == true && grid[1][7].status == true) {
    gridG = true;
  } 
  else {
    gridG = false;
  }
  if ( 
  grid[2][6].status == true && grid[3][6].status == true && grid[4][6].status == true &&
    grid[2][7].status == true && grid[3][7].status == true && grid[4][7].status == true) {
    gridH = true;
  } 
  else {
    gridH = false;
  }
  if ( 
  grid[5][6].status == true && grid[6][6].status == true && grid[7][6].status == true &&
    grid[5][7].status == true && grid[6][7].status == true && grid[7][7].status == true) {
    gridI = true;
  }
  else {
    gridI = false;
  }
}


void keyPressed() {
  if (keyCode == UP) {
    threshold++;
  } 
  else if (keyCode == DOWN) {

    threshold--;
  }
  //println(threshold);
}

void waitForMe() {
  if ( millis() - lastTime > 500 ) {

    //  println( "threshold is: "+ threshold+ '\t'+"On Cells: "+totalCells+ '\t'+estado);
    println( "threshold is: "+ threshold+'\t'+estado1+'\t'+estado2+'\t'+estado3);

    
    /*
    println("A: "+gridA+'\t'+"B: "+gridB+'\t'+"C: "+gridC+'\t'+"D: "+gridD+'\t'+
     "E: "+gridE+'\t'+"F: "+gridF+'\t'+"G: "+gridG+'\t'+"H: "+gridH+'\t'+"I: "+gridI);
    */
    
    lastTime = millis();
    /* 
     port.write('H'); // H or L
     port.write('U'); // U or D
     port.write('I'); // R or I
     */
     
    if (gridA || gridD || gridG) {
      port.write('H'); // H or L
      estado1 = "ON";
    } 
    else if (gridA==false && gridD==false && gridG==false) {
      port.write('L'); // H or L
      estado1 = "OFF";
    }

    if (gridB || gridE || gridH) {
      port.write('U'); // U or D
      estado2 = "ON";
    } 
    else if (gridB==false && gridE==false && gridH==false) {
      port.write('D'); // H or L
      estado2 = "OFF";
    }

    if (gridC || gridF || gridI) {
      port.write('R'); // R or I
      estado3 = "ON";
    } 
    else if (gridC==false && gridF==false && gridI==false) {
      port.write('I'); // R or I
      estado3 = "OFF";
    }
  }
}

