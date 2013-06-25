import processing.video.*;
import gifAnimation.*;

Capture cam1; //Capture object

//PIMages store frames for GIF
PImage img1;


long timeToWait = 1000;// in miliseconds
//long timeToWait2 = 1000;// in miliseconds
long lastTime;
//long lastTime2;

final int DISPLAY_DURATION = 3000; // 3s

int count; //counts images

int displayStartTime; //time image playback starts

GifMaker gifExport; //Create export object

Gif currentAnimation; //create GIF layback object

int imgCounter; // filemnameCount
String lastImgName; //Record last image name

boolean takePic; //am I taking the photo?
boolean displayPic; //am I displaying the photo?

void setup() {
  size(1280, 720); //Setup size == camera frame size
//  size(200, 200); //Setup size == camera frame size
  
//  currentAnimation = new Gif(this, "lavalamp.gif");//lastImgName);
//  currentAnimation.loop();

  String time = hour()+":"+minute()+":"+second() + "\n...";
  println(time);
  lastTime = millis();
  
  takePic = false; //starts not taking photo
  displayPic = false; //starts in live view

  String[] cameras = Capture.list(); //make list of camera devices
  
  lastImgName = dataPath("ecs89Pic000.gif");
  
  //begin Capture library sample code
  
  //print list of cameras
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
    cam1 = new Capture(this, cameras[0]);
    cam1.start();
  // end sample library code
  } 

  println("gifAnimation " + Gif.version());
  gifExport = new GifMaker(this, "data/ecs89Pic" + nf(imgCounter, 3) + ".gif"); //Create file for images, iterate file name
  gifExport.setRepeat(0);        // make it an "endless" animation
}

void draw() {


  if (displayPic == true)
  {   
    frameRate(12);
    println("displayPic");
    
    displayAct();
  }
  
  else if (cam1.available() == true) { //Check if camera is availalbe
    frameRate(60);
    cam1.read(); //Read camera
    image(cam1, 0, 0); //Display current webcam image 
  } 


  if (takePic)
  {
    
    println("takePic " + imgCounter);
    
    if (count <= 4){
      
      println ("count is " + count);
    
      if ( millis() - lastTime > timeToWait)
      {
        count++; //increment counter
        
        cam1.read();
        img1 = createImage(1280, 720, RGB); //Create img
        img1.loadPixels(); //Load pixels into img
        gifExport.addFrame(cam1); //Add Frame to GIF
        gifExport.setDelay(1); //Set Delay between frames in GIF playback
        
        println("Frame" + count + " / lastTime =" + lastTime + " / millis =" + millis());
        
        lastTime = millis(); //reset lasttime
        
        
      }
    }
     
     
    if (count >= 4)
    { 
      println("Done / lastTime =" + lastTime  + " / millis =" + millis());
      
      gifExport.finish(); //Finish the GIF and write to disk
      
      lastImgName = "ecs89Pic" + nf(imgCounter, 3) + ".gif";
      
      //displayFunct();

      //setup next img
      
      imgCounter++; //Incriment the filename counter
      println("gifAnimation " + Gif.version());
      gifExport = new GifMaker(this, "data/ecs89Pic" + nf(imgCounter, 3) + ".gif"); //Set up Next file
      gifExport.setRepeat(0);        // make it an "endless" animation
      
      lastTime = millis();
      
      takePic = false; //reset takePic
      
      displayFunct();
      
      count = 0; //reinitialize counter
    }  
      
      
  }  
  
}

void keyPressed() 
{
  
  if (key ==' ')
  {  
    takePic = true;    
  } 
}

void displayFunct()
{
  println("displayFunct" + lastImgName);
  try {
    currentAnimation = new Gif(this, lastImgName); //Set animation
    currentAnimation.loop(); //loop animation
  }
  catch (NullPointerException e){
    println("shabba");
    currentAnimation = new Gif(this, dataPath("default2.gif")); //Set animation
    currentAnimation.loop(); //loop animation
  }
  
    displayPic = true; //show off picture
    
    println("displayPic status " + displayPic);
    displayStartTime = millis();

}

 
void displayAct()
{
  image(currentAnimation, 0, 0); //play current animation at 0,0
      
  text("Here's your Animation!", (width/2), (height / 8)*7); // Display Text
  
  if (millis() - displayStartTime > DISPLAY_DURATION) //Wait Dispay duration, then stop display
  {
    // Stop displaying the message, thus resume the ball moving
    displayPic = false;
  }
  
}


