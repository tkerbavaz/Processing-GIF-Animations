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

Gif lastGif; //create GIF playback object

int imgCounter; // filemnameCount

String lastImgName; //Record last image name

boolean takePic; //picture take state

boolean displayPic; // display pic state

void setup() {
  size(960, 540);

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
  
  if (takePic)
  {
    println ("takePic " + imgCounter); //print image number
    takePicFunct(); //take pic
    
    displayPic = true;
    
    takePic = false;
  }
  
  if (displayPic)
  {
    println(lastGif);
      
    image(lastGif, this.width/4, this.height/2);
      
    text("Here's your Animation!", (width/2 - 10), (height / 10)*8);
  }
  
}

void mouseClicked() {
  
  takePic = true; //Change takepic state
  
  
  /*
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
  */
  
}

void takePicFunct()
{
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
  
  lastImgName = "tcsClubTest" + "-" + nf(imgCounter, 3) + ".gif"; // set last image name
  
  displayFunct(); // load last gif in lastGif
  
  //setup next img
  imgCounter++;
  println("gifAnimation " + Gif.version());
  gifExport = new GifMaker(this, "tcsClubTest" + "-" + nf(imgCounter, 3) + ".gif");
  gifExport.setRepeat(0);        // make it an "endless" animation
}

void displayFunct()
{
  /*
  println(lastImgName);
  currentAnimation = new GifImage(this, dataPath(lastImgName)); //Set animation
  currentAnimation.loop(); //loop animation
  */
  println(lastImgName);
  try {
    lastGif = new Gif(this, lastImgName); //Set animation
    lastGif.loop(); //loop animation
  }
  catch (NullPointerException e){
    println("shabba");
    lastGif = new Gif(this, dataPath("default2.gif")); //Set animation
    lastGif.loop(); //loop animation
  }

}
 
