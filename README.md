Processing-GIF-Animations
=========================

Animated GIF generation with USB Webcam and Processing - Stereo images and animations

These were developed as part of a senior project in Technocultural Studies at UC Davis in March 2013.

To see the results of the Jitter 3D code deployed in a real-world environment, visit http://tcspicnicday.org/

They all use the Processing Video Library and the gifAnimation library from extrapixel. 
You can get that library here:http://www.extrapixel.ch/processing/gifAnimation/

These were developed on a Mac, using Processing and Logitech HD Webcams, Model C615.
The camera detection in these sketches is based on my laptop's default hardware addressing, so your milage may vary.


There are 3 different versions of the code:
      One_Camera_Animated_GIF_Single_PImage_GUI takes multiple exposures over time with a single webcam.
                                As it's name suggests, it uses a single PImage 
                                (I had an earlier prototype that used one PImage for each frame)
                                It then combines the images as sequential frames in an animated GIF image.
                                
      Three_Camera_Proc_Lib_Capture Takes one picture with each of up to three webcams, taking the pictures almost simultaniously.
                                This gives a "Jitter 3D" effect when the frames are animated.
                                
      Three_Camera_Proc_Lib_Capture_display adds an image preview funtion after the GIF is created.
