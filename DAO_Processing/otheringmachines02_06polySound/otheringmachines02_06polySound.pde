/*Othering Machines v.2.0 / HEARSAY //<>//
 course DAO
 HfK Bremen
 - David Unland

 * gifAnimation controllable with 'g'
 * time() will be printed with 't' hit

 28.10.2018
 Version 02_06:

 TO DO:
 * different verbose options for console prints

 */


//------------------------------------------------------------------
//-------------------------GLOBAL VARIABLES-------------------------
//------------------------------------------------------------------
//import gifAnimation.*;
//import controlP5.*;
//ControlP5 cp5;

import java.util.Collections;
boolean gifAnimation = false;

import processing.sound.*;
//TriOsc sound;

int totalInitialMods = 50; //number of Mods to be initialized automatically
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
int CHOOSEMODE = 3;
int distributionMode;
int GRID = 1;
int RANDOM = 2;
int CHOOSE = 3;

ArrayList<Module> modulesList = new ArrayList<Module>();
//Module sendingMod;




//------------------------------------------------------------------
//-------------------------------SETUP------------------------------
//------------------------------------------------------------------
void setup() {
  randomSeed(millis());
  //frameRate(100);
  //-------------------------------design
  size(1024, 1024);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);

  //-------------------------------library initialization
  //sound = new TriOsc(this);

  //-------------------------------variable declarations
  soundstate = CHOOSEMODE;
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



    //---------------------------CHOOSE MODE-------------------------------
    if (soundstate == CHOOSEMODE)
    {
      textAlign(LEFT, CENTER);
      text("press '1' for Grid distribution", width/3, height/2);
      text("press '2' for Random distribution", width/3, height/2+20);
      text("press '3' for free allocation Mode", width/3, height/2+40);
    }

    //--------------------------INITIALIZATION MODE------------------------
    //---------------------------------------------------------------------
    if (soundstate == INIT)
    {
      fill(255,0,0);
      textAlign(RIGHT, CENTER);
      text("PRESS ENTER TO START", width*0.9, height*0.9);
      text("press 'g' to save frames into workfolder", width-20, height*0.9+40);

      //-------------------------------RANDOM DISTRIBUTION
      if (distributionMode == RANDOM)
      {
        //create one mod
        modulesList.add(new Module(int(random(height)), int(random(width)), moduleAmount+1));
        moduleAmount++;
        println(time()+" mod "+moduleAmount+" created:");
        println(time()+" ["+modulesList.get(moduleAmount-1).db[0]+" | "
          +modulesList.get(moduleAmount-1).db[1]+" | "+modulesList.get(moduleAmount-1).db[2]+"]");
        println(time()+" ["+modulesList.get(moduleAmount-1).ab[0]+" | "
          +modulesList.get(moduleAmount-1).ab[1]+" | "+modulesList.get(moduleAmount-1).ab[2]+"]");
        println(time()+" RGB: "+modulesList.get(moduleAmount-1).redAb+","+
          modulesList.get(moduleAmount-1).greenAb+","+modulesList.get(moduleAmount-1).blueAb);
        println(time()+" respondFactor = "+modulesList.get(moduleAmount-1).respondFactor
          +"; timedStatement = "+modulesList.get(moduleAmount-1).timedStatement);
        println();

        //create all the others
        for (int i = 0; i < totalInitialMods-1; i++)
        {
          boolean positionOccupied = true;
          int x = int(random(0, width));
          int y = int(random(0, height));

          while (positionOccupied)
          {
            for (Module mod : modulesList)
            {
              if (moduleAmount >= 1 && mod.xPos-mod.radius <= x && mod.xPos+mod.radius >= x
                && mod.yPos-mod.radius <= y && mod.yPos+mod.radius >= y)
              {
                positionOccupied = true;
                x = int(random(0, width));
                y = int(random(0, height));
                println(time()+" position ("+x+" | "+y+") occupied.. iterating..");
              }
              positionOccupied = false;
            }
          }
          modulesList.add(new Module(x, y, moduleAmount+1));
          moduleAmount++;
          println(time()+" mod "+moduleAmount+" created:");
          println(time()+" ["+modulesList.get(moduleAmount-1).db[0]+" | "
            +modulesList.get(moduleAmount-1).db[1]+" | "+modulesList.get(moduleAmount-1).db[2]+"]");
          println(time()+" ["+modulesList.get(moduleAmount-1).ab[0]+" | "
            +modulesList.get(moduleAmount-1).ab[1]+" | "+modulesList.get(moduleAmount-1).ab[2]+"]");
          println(time()+" RGB: "+modulesList.get(moduleAmount-1).redAb+","+
            modulesList.get(moduleAmount-1).greenAb+","+modulesList.get(moduleAmount-1).blueAb);
          println(time()+" respondFactor = "+modulesList.get(moduleAmount-1).respondFactor
            +"; timedStatement = "+modulesList.get(moduleAmount-1).timedStatement);
          println();
        }
        //soundstate = ACT;
        distributionMode = 0;
      }



      //-------------------------------GRID DISTRIBUTION
      if (distributionMode == GRID)
      {
        for (int i = 0; i < sqrt(totalInitialMods-1); i++)
        {
          int x = int(width/sqrt(totalInitialMods) + i*(width/sqrt(totalInitialMods))-60);
          for (int j = 0; j < sqrt(totalInitialMods-1); j++)
          {
            int y = int(width/sqrt(totalInitialMods) + j*(width/sqrt(totalInitialMods))-60);
            modulesList.add(new Module(x, y, moduleAmount+1));
            moduleAmount++;
            println(time()+" mod "+moduleAmount+" created:");
            println(time()+" ["+modulesList.get(moduleAmount-1).db[0]+" | "
              +modulesList.get(moduleAmount-1).db[1]+" | "+modulesList.get(moduleAmount-1).db[2]+"]");
            println(time()+" ["+modulesList.get(moduleAmount-1).ab[0]+" | "
              +modulesList.get(moduleAmount-1).ab[1]+" | "+modulesList.get(moduleAmount-1).ab[2]+"]");
            println(time()+" RGB: "+modulesList.get(moduleAmount-1).redAb+","+
              modulesList.get(moduleAmount-1).greenAb+","+modulesList.get(moduleAmount-1).blueAb);
            println(time()+" respondFactor = "+modulesList.get(moduleAmount-1).respondFactor
              +"; timedStatement = "+modulesList.get(moduleAmount-1).timedStatement);
            println();
          }
        }
        //soundstate = ACT;
        distributionMode = 0;
      }



      //-------------------------------FREE ALLOCATION MODE
      if (distributionMode == CHOOSE)
      {
        //Text display
        if (moduleAmount < 2)
        {
          fill(0);
          textAlign(RIGHT, CENTER);
          text("CLICK MOUSE TO PLACE MODS", width*0.9, height*0.9);
          text("press 'g' to save frames into workfolder", width-20, height*0.9+40);
        }
        if (moduleAmount > 1)
        {
          fill(0);
          textAlign(RIGHT, CENTER);
          text("PRESS ENTER TO START", width*0.9, height*0.9);
          text("press 'g' to save frames into workfolder", width-20, height*0.9+40);
        }
      }
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
        println(time()+" Screen saved");
      }
    }
  }

  fill(255);
  textAlign(LEFT, TOP);
  text(time(), 0, 0);
}

float time() {
  return 0.001 * millis() + minute()*60 + hour() * 60 * 60;
}
