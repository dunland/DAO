/*Othering Machines v.2.0 / HEARSAY -  angepasst an den aktuellen μC-Code //<>// //<>//
 11:26 11.12.2017
 summer semester 2017
 course DAO
 HfK Bremen
 - David Unland
 */


//import gifAnimation.*;
import java.util.Collections;

int moduleAmount;
int tolerance = 20; //closest allowed proximity of modules
int sendingModIdx;
int lowestDbValue = 300;
int highestDbValue = 2401;

//float signalSpeed = 5;
float signalSpeed = 50;
//int sentData;

int soundstate;
int ACT = 1;
int STOP = 0;
int INIT = 2;

ArrayList<Module> modulesList = new ArrayList<Module>();
//Module sendingMod;

void setup() {
  //frameRate(100);
  //design
  size(720, 720);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);

  soundstate = INIT;
}  


void draw() {
  if (soundstate != STOP) {
    background(125, 125, 125);

    ///////////////////INITIAL STATE///////////////////
    if (soundstate == INIT && moduleAmount < 2) {
      fill(0);
      textAlign(RIGHT, CENTER);
      text("CLICK MOUSE TO PLACE MODS", width*0.9, height*0.9);
    }
    if (soundstate == INIT && moduleAmount > 1) {
      fill(0);
      textAlign(RIGHT, CENTER);
      text("PRESS ENTER TO START", width*0.9, height*0.9);
    }


    for (Module mod : modulesList) {
      mod.draw(); //draws mods at position
      mod.signalPropagation(); //extends signal if emit == true
      if (mod.react !=0) {
        mod.positiveReaction();
        mod.negativeReaction();
      }
      // mod.move();
    }

    //////////////////////ACT MODE//////////////////////
    if (soundstate == ACT) {
      for (Module mod : modulesList) {
        mod.timedStatement();
      }
    }
  }
}

float time() {
  return 0.001 * millis() + second() + minute()*60 + hour() * 60 * 60;
}