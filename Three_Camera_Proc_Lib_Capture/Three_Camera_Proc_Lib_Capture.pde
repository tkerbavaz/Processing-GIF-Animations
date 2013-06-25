import processing.video.*;
import gifAnimation.*;

Capture cam1;
Capture cam2;
//Capture cam3;

PImage img1;
PImage img2;
//PImage img3;

GifMaker gifExport;
//GifMaker gifExport = new GifMaker(this, "/Users/tkerbavaz/Documents/Processing/Three_Camera_Proc_Lib_Capture/test.gif", 10);

int imgCounter; // filemnameCount

void setup() {
  size(960, 270);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam1 = new Capture(this, cameras[33]);
    cam2 = new Capture(this, cameras[21]);
    //cam3 = new Capture(this, 320, 240, cameras[33]);
    cam1.start();
    cam2.start();
    //cam3.start();    
  } 

  println("gifAnimation " + Gif.version());
  gifExport = new GifMaker(this, "tcsClubTest" + "-" + nf(imgCounter, 3) + ".gif");
  gifExport.setRepeat(0);        // make it an "endless" animation
  
}

void draw() {
  if (cam1.available() == true) {
    cam1.read();
  }
  image(cam1, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);

  
    if (cam2.available() == true) {
    cam2.read();
  }
  image(cam2, 480, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  
/*    if (cam3.available() == true) {
    cam3.read();
  }
  image(cam3, 640, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  */
  
}

void mouseClicked() {
  
  cam1.read();
  img1 = createImage(480, 270, RGB);
  img1.loadPixels();
  gifExport.addFrame(cam1);
  
  gifExport.setDelay(1);
  
  cam2.read();
  img2 = createImage(480, 270, RGB);
  img2.loadPixels();
  gifExport.addFrame(cam2);
  
  //cam3.read ();
  //gifExport.addFrame(cam3);
  
  gifExport.finish();
  
  //setup next img
  imgCounter++;
  println("gifAnimation " + Gif.version());
  gifExport = new GifMaker(this, "tcsClubTest" + "-" + nf(imgCounter, 3) + ".gif");
  gifExport.setRepeat(0);        // make it an "endless" animation
}
