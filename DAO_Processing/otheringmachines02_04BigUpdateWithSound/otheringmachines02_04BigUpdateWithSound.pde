 //<>//

/*Othering Machines v.2.0 / HEARSAY
 course DAO
 HfK Bremen
 - David Unland
 
 19.10.2018
 Version 02_04:
 * programming 9 modules for presentation @HEC
 * no initial mod overlapping possible anymore
 * gifAnimation controllable with 'g'
 * time() will be printed with 't' hit
 * subsiding times adjusted. now as general variable in Modules.
 * sound library added for sound playback
 
 TO DO: one sound object for each module --> real multilayer sound
 */


//------------------------------------------------------------------
//-------------------------GLOBAL VARIABLES-------------------------
//------------------------------------------------------------------
//import gifAnimation.*;

import java.util.Collections;
boolean gifAnimation = false;

import processing.sound.*;
TriOsc sound;

int moduleAmount;
int tolerance = 20; //closest allowed proximity of modules
int sendingModIdx;
int lowestDbValue = 300;
int highestDbValue = 2401;

//float signalSpeed = 5;
float signalSpeed = 50;
float playSound; //will hold the sound for a durancy of 600ms
//int sentData;

int soundstate;
int ACT = 1;
int STOP = 0;
int INIT = 2;

ArrayList<Module> modulesList = new ArrayList<Module>();
//Module sendingMod;




//------------------------------------------------------------------
//-------------------------------SETUP------------------------------
//------------------------------------------------------------------
void setup() {
  //frameRate(100);
  //design
  size(720, 720);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  sound = new TriOsc(this);

  soundstate = INIT;
}  





//------------------------------------------------------------------
//-------------------------------LOOP-------------------------------
//------------------------------------------------------------------
//1. draw mods
//2. initial state
//3. act mode:
//3.1. timed emission
//3.2. save Frames
void draw() {
  if (soundstate != STOP) {
    background(125, 125, 125);

    for (Module mod : modulesList) {
      mod.draw(); //draws mods at position
      mod.signalPropagation(); //extends signal if emit == true
      if (mod.react !=0) {
        mod.positiveReaction();
        mod.negativeReaction();
      }
      // mod.move();
    }

    //-------------------------INITIAL STATE-----------------------------
    //Text display
    if (soundstate == INIT && moduleAmount < 2)
    {
      fill(0);
      textAlign(RIGHT, CENTER);
      text("CLICK MOUSE TO PLACE MODS", width*0.9, height*0.9);
      text("press 'g' to save frames into workfolder", width-20, height*0.9+40);
    }
    if (soundstate == INIT && moduleAmount > 1) 
    {
      fill(0);
      textAlign(RIGHT, CENTER);
      text("PRESS ENTER TO START", width*0.9, height*0.9);
      text("press 'g' to save frames into workfolder", width-20, height*0.9+40);
    }



    //-------------------------------ACT MODE----------------------------
    //1. timed Statement
    //2. save Frames
    if (soundstate == ACT) {
      for (Module mod : modulesList) {
        mod.timedStatement();
      }
    }

    if (gifAnimation) 
    {
      if (millis() % 1000 <= 5) {
        saveFrame();
        println("Screen saved");
      }
    }
  }

  fill(0);
  textAlign(LEFT, TOP);
  text(time(), 0, 0);
}

float time() {
  return 0.001 * millis() + second() + minute()*60 + hour() * 60 * 60;
}
