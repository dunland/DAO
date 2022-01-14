import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Collections; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class otheringmachines02_06polySound extends PApplet {

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


boolean gifAnimation = false;


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
public void setup() {
  randomSeed(millis());
  //frameRate(100);
  //-------------------------------design
  
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
public void draw() {
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
      text("PRESS ENTER TO START", width*0.9f, height*0.9f);
      text("press 'g' to save frames into workfolder", width-20, height*0.9f+40);

      //-------------------------------RANDOM DISTRIBUTION
      if (distributionMode == RANDOM)
      {
        //create one mod
        modulesList.add(new Module(PApplet.parseInt(random(height)), PApplet.parseInt(random(width)), moduleAmount+1));
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
          int x = PApplet.parseInt(random(0, width));
          int y = PApplet.parseInt(random(0, height));

          while (positionOccupied)
          {
            for (Module mod : modulesList)
            {
              if (moduleAmount >= 1 && mod.xPos-mod.radius <= x && mod.xPos+mod.radius >= x
                && mod.yPos-mod.radius <= y && mod.yPos+mod.radius >= y)
              {
                positionOccupied = true;
                x = PApplet.parseInt(random(0, width));
                y = PApplet.parseInt(random(0, height));
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
          int x = PApplet.parseInt(width/sqrt(totalInitialMods) + i*(width/sqrt(totalInitialMods))-60);
          for (int j = 0; j < sqrt(totalInitialMods-1); j++)
          {
            int y = PApplet.parseInt(width/sqrt(totalInitialMods) + j*(width/sqrt(totalInitialMods))-60);
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
          text("CLICK MOUSE TO PLACE MODS", width*0.9f, height*0.9f);
          text("press 'g' to save frames into workfolder", width-20, height*0.9f+40);
        }
        if (moduleAmount > 1)
        {
          fill(0);
          textAlign(RIGHT, CENTER);
          text("PRESS ENTER TO START", width*0.9f, height*0.9f);
          text("press 'g' to save frames into workfolder", width-20, height*0.9f+40);
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

public float time() {
  return 0.001f * millis() + minute()*60 + hour() * 60 * 60;
}
class Module {

  //variables
  int modnumber; //a # of each mod to be displayed
  float xPos, yPos;
  PVector position;
  int modColor=color(0);
  boolean mouseMove = false; //if true, mod will be drawn at mouseposition

  float subsidingTime = 20; //time to wait after negative and positive reactions
  boolean subsideAfterEmission = false;
  boolean waitBeforeReaction = false;
  int timedStatement = PApplet.parseInt(random(640, 1281)); //timed Statement in s
  float respondFactor = timedStatement*0.01f; //2.4 to 4.8
  //float pauseAction = time() + 100 * respondFactor;
  float pauseAction = 0;
  boolean emit=false;
  int react = 0; //0 = standby, 1 = positive reaction, 2 = negative reaction
  int sentData; //signal output, data used for signalPropagation

  float signalMag = 0; //magnitude of signal
  int signalRange = 600;

  boolean dataExists = false;
  boolean dbFull = false;
  int freqTol = 50;
  int dbLength = 3;
  int[] db = new int[dbLength];
  int[] ab = new int[dbLength];

  //------------------------------DISPLAY
  int radius = 30;
  int abTot = 3;
  int greenAb = 0;
  int redAb = 0;
  int blueAb = 0;

  TriOsc sound = new TriOsc(otheringmachines02_06polySound.this);

  //constructor for individual mods
  Module(float ixPos, float iyPos, int imodnumber) {
    xPos = ixPos;
    yPos = iyPos;
    modnumber = imodnumber;
    position = new PVector(xPos, yPos);

    //------------------------------fill db
    for (int i = 0; i<dbLength; i++) {
      db[i] = PApplet.parseInt(random(lowestDbValue, highestDbValue));
      ab[i] = 1;
      if (db[i] >= 300 && db[i] < 1000) {
        redAb++;
      } else if (db[i] >= 1000 && db[i] < 1700) {
        greenAb++;
      } else if (db[i] >= 1700 && db[i] < 2401) {
        blueAb++;
      }
    }
  }


  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////DRAW////////////////////////////////////////////
  //////////////////////////fills with color until time>pauseAction/////////////////////////
  public void draw() {
    noStroke();
    //fill(modColor);
    //----------------------------------------------GLOW WHITE
    if (!emit && time() > pauseAction) {    //if ready: glow white
      fill(255);
      ellipse(xPos, yPos, radius, radius);
    }

    //----------------------------------------------BEFORE REACTION: GLOW RGB
    if (waitBeforeReaction && time() < pauseAction) { //if subside, glow RGB LED
      float abTotF = PApplet.parseFloat(abTot);
      float R = (redAb/abTotF) * 255;
      float G = (greenAb/abTotF) * 255;
      float B = (blueAb/abTotF) * 255;
      //println("R = "+R+"G = "+G+"B = "+B);
      //println(redAb);
      //println(abTot);
      fill(R, G, B, 125);
      ellipse(xPos, yPos, 30, 30);
    }
    if (time() > pauseAction) {
      modColor = (0);
    }

    if (mouseMove == true) {
      xPos = mouseX;
      yPos = mouseY;
    }
    fill(0);
    ellipse(xPos, yPos, 20, 20);
    fill(255);
    textAlign(CENTER, CENTER);
    text(modnumber, xPos, yPos);

    //----------------------------------------------SUBSIDE: DON'T GLOW
    if (subsideAfterEmission && time() < pauseAction)
    {
      fill(0);
      ellipse(xPos, yPos, 20, 20);
      fill(255);
      textAlign(CENTER, CENTER);
      text(modnumber, xPos, yPos);
    }
  }


  ////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////SIGNAL PROPAGATION/////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////


  public void signalPropagation() //is executed in general loop
  {
    if (emit && time()>pauseAction) 
    {
      if (signalMag == 0) 
      {
        println(time()+" mod "+modnumber+" sends "+sentData+"...");
        playSound = time()+0.6f;
      }
      if (signalMag <= signalRange) 
      {
        if (time()<playSound)
        {
          sound.play(sentData, 1);
        } else
        {
          sound.stop();
        }
        //if (signalMag <= 2*height) { //until signal magnitude exceeds screen ...
        noFill();
        stroke(255);
        //stroke(sentData*10+5, xPos/255*sentData, modnumber*sentData*5); //sets color representatively for sentData
        ellipse(xPos, yPos, signalMag, signalMag); //...draw that circle...
        for (int i = 0; i < moduleAmount; i++) 
        {
          if (modulesList.get(i) != this) 
          {
            //println("modulesList.get("+i+").intersect("+sentData+")");
            modulesList.get(i).intersect(this.position, this.modnumber, signalMag, sentData); //..check overlap with objects...
          }
        }
        signalMag+=signalSpeed*1; //increase the magnitude
        //float signalNoise = random(-1,1); //add noise to the signal depending on its distance
        //if(signalMag%20==0){
        //sentData += signalNoise;
        //println("***");
        //}
      } else 
      {
        sound.stop();
        emit = false;
        signalMag=0;
        subsideAfterEmission = true;
        pauseAction = time() + subsidingTime;
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////WHEN INTERSECTING///////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  public void intersect(PVector emittingModPosition, int emittingModNumber, float emittingModSignal, int incomingData) {
    //check distance to other modules by signal:
    if (this.emit == false) {
      //println("modulesList.get("+j+").emit == true");
      if (abs(PVector.dist(this.position, emittingModPosition))-25<=emittingModSignal/2       //check actual intersection
        && abs(PVector.dist(this.position, emittingModPosition))+25>=emittingModSignal/2) {
        //if (abs(PVector.dist(this.position, emittingModPosition))-5<=emittingModSignal/2       //check actual intersection
        //  && abs(PVector.dist(this.position, emittingModPosition))+5>=emittingModSignal/2) {
        if (time()>pauseAction) { //only react once
          println(time()+" mod "+emittingModNumber+" intercepting with mod "+this.modnumber+": ");
          //receive data, compare data, add
          checkIncomingData(incomingData);
        }
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////CHECK INCOMING DATA/////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //1. data within tolerance?
  //2. data exists: increase abundancy


  public void checkIncomingData(int incomingData) {
    print(time()+" mod "+this.modnumber+": checking incomingData... ");

    //------------------------------data within tolerance?
    for (int i = 0; i < dbLength; i++) {
      if (abs(incomingData - db[i]) < freqTol) {
        //-> increase abundancy

        println(time()+" match found at ["+i+"]: "+db[i]);
        ab[i]++;
        abTot++;
        if (incomingData >= 300 && incomingData < 1000) {
          redAb++;
        } else if (incomingData >= 1000 && incomingData < 1700) {
          greenAb++;
        } else if (incomingData >= 1700 && incomingData < 2401) {
          blueAb++;
        }
        dataExists = true;

        //------------------------------positive reaction
        sentData = db[i];
        react = 1; // 1 = positiveReaction, 2 = negativeReaction
        pauseAction = time() + 10 * respondFactor; // that makes values from 60 to 120 seconds
        waitBeforeReaction = true;
        println(time()+" mod "+this.modnumber+" responds in "+(this.pauseAction-time())+" s");
        //positiveReaction(db[i]);
        break;
      }
    }


    //------------------------------data not within tolerance:
    //1. find lowest entry
    //2. lower abundancy
    //2.1. if 0: replace data
    //3. pick closest entry and respond


    if (!dataExists) {
      print("no match! ");
      //get idx of data, emit closest
      int lowest = ab[0];
      int lowestIdx = 0;
      for (int i = 0; i < dbLength; i++) {
        if (ab[i] < lowest) {
          lowest = ab[i];
          lowestIdx = i;
        }
      }
      println(db[lowestIdx]+"'s abundancy decreased.");

      //lower abundancy
      ab[lowestIdx]--;
      abTot--;
      if (incomingData >= 300 && incomingData < 1000) {
        redAb--;
      } else if (incomingData >= 1000 && incomingData < 1700) {
        greenAb--;
      } else if (incomingData >= 1700 && incomingData < 2401) {
        blueAb--;
      }

      //if abundancy = 0, rpleace data
      if (ab[lowestIdx] == 0) {
        db[lowestIdx] = incomingData;
        //increase abundancy
        ab[lowestIdx] = 1;
        abTot++;
        if (incomingData >= 300 && incomingData < 1000) {
          redAb++;
        } else if (incomingData >= 1000 && incomingData < 1700) {
          greenAb++;
        } else if (incomingData >= 1700 && incomingData < 2401) {
          blueAb++;
        }

        //pick closest entry from db and respond
        sortDatabase(db, dbLength);
        float wait = 0;
        int closest = 0;

        if (lowestIdx == 0) {
          //entry at start: wait dist
          wait = (db[lowestIdx + 1] - db[lowestIdx]) * respondFactor;
          closest = db[lowestIdx + 1];
          print(time()+" entry at 0, wait = ");
          println(wait);
        } else if (lowestIdx == dbLength - 1) {
          wait = (db[lowestIdx] - db[lowestIdx - 1]) * respondFactor;
          closest = db[dbLength - 2];
          print("entry at end, wait = ");
          println(time()+wait);
          //entry at end: wait dist
        } else {
          //middle: calc diff, wait dist
          if (db[lowestIdx] - db[lowestIdx - 1] < db[lowestIdx + 1] - db[lowestIdx]) {
            wait = (db[lowestIdx] - db[lowestIdx - 1]) * respondFactor;
            closest = db[lowestIdx - 1];
            println(time()+db[lowestIdx]+" - "+db[lowestIdx - 1]+" < "+db[lowestIdx + 1]+" - "
              +db[lowestIdx]+", difference/wait = "+wait);
          } else {
            wait = (db[lowestIdx + 1] - db[lowestIdx]) * respondFactor;
            closest = db[lowestIdx + 1];
            println(time()+db[lowestIdx]+" - "+db[lowestIdx - 1]+" > "+db[lowestIdx + 1]+" - "
              +db[lowestIdx]+", difference/wait = "+wait);
          }
        }
        println(time()+" lowest entry = "+db[lowestIdx]+" dropped, "+incomingData+" added.");        
        print(time()+" closest sound = ");
        println(closest);
        sentData = closest;
        pauseAction = time() + subsidingTime;
        //pauseAction = time() + wait;
        react = 2;
        waitBeforeReaction = true;
      }
    }
    println(time()+" ["+db[0]+" | "+db[1]+" | "+db[2]+"]");
    println(time()+" ["+ab[0]+" | "+ab[1]+" | "+ab[2]+"]");
    println();
    dataExists = false;
    //printDatabase();
  }


  //------------------------------POSITIVE REACTION------------------------------
  public void positiveReaction() //executed in general loop 
  {
    if (react == 1) 
    {
      //repeats the db match for incoming data
      //returns sent data for signal propagation
      if (time() > pauseAction) //wait
      {    
        emit = true;               //start emitting
        react = 0;
      }
    }
  }

  //------------------------------NEGATIVE REACTION------------------------------
  public void negativeReaction() {
    if (react == 2) {
      if (time() > pauseAction) {
        emit = true;
        react = 0;
      }
    }
  }
  
  
  //------------------------------TIMED STATEMENT---------------------------------

  public void timedStatement() {
    if (time() % timedStatement <= 0.01f && time() > pauseAction) {
      //int highest = ab[0];
      //int highestIdx = 0;
      //for (int i = 0; i < dbLength; i++) {
      //  if (ab[i] > highest) {
      //    highestIdx = i;
      //  }
      //}
      //pauseAction = time() + 1;
      emit = true;
      sentData = db[PApplet.parseInt(random(0, dbLength))];
      println(time()+" mod "+this.modnumber+"timed statement @" + time()+ "s");
    }
  }


  public void sortDatabase(int a[], int size) {
    for (int i = 0; i < (size - 1); i++) {
      for (int o = 0; o < (size - (i + 1)); o++) {
        if (a[o] > a[o + 1]) {
          int t = a[o];
          int b = ab[o]; //abundancy array
          a[o] = a[o + 1];
          ab[o] = ab[o + 1];
          a[o + 1] = t;
          ab[o + 1] = b;
        }
      }
    }
  }
}
public void keyPressed() {
  //-----------------------------STOPPING-----------------------------
  if (soundstate == ACT) {
    if (key == ENTER || key == RETURN) {
      soundstate = STOP;
      print(time()+" stopped");
    }
  } else if (soundstate == STOP) {
    if (key == ENTER || key == RETURN) {
      soundstate = ACT;
      println(time()+" ...    continued.");
    }
  }

  //--------------------------GIF ANIMATION---------------------------

  if (key == 'g' || key == 'G')
  {
    if (gifAnimation)
    {
      gifAnimation = false;
      println(time()+" Frame saving paused.");
    } else 
    {
      gifAnimation = true;
      println(time()+" Frame saving started.");
    }
  }

  //-------------------------- print float time()---------------------------
  if (key == 't' || key == 'T')
  {
    println(time()+" time() returns "+time());
  }

  //-------------------------------CHOOSE MODE AND INITIAL MODE------------------
  if (soundstate == CHOOSEMODE)
  {
    if (key == '1') {
      distributionMode = GRID;
      soundstate = INIT;
    }
  }
  if (soundstate == CHOOSEMODE)
  {
    if (key == '2') {
      distributionMode = RANDOM;
      soundstate = INIT;
    }
  }
  if (soundstate == CHOOSEMODE)
  {
    if (key == '3') {
      distributionMode = CHOOSE;
      soundstate = INIT;
    }
  }

  //--------------------------------STARTING ACT MODE--------------------------------
  if (soundstate == INIT && moduleAmount > 1) 
  {
    if (key == ENTER || key == RETURN) {
      soundstate = ACT;
      modulesList.get(0).sentData = modulesList.get(0).db[PApplet.parseInt(random(0, 3))];
      modulesList.get(0).emit = true;
      //sendingMod = modulesList.get(sendingModIdx); //starting signal transmitter is first placed mod
    }
  }
}

public void mousePressed() {
  //--------------------------------DISTRIBUTION MODE: FREE ALLOCATION--------------------------------
  //create new mod:
  //  mouse pressed = add mod at mod position (if not at mod pos)
  if (soundstate == INIT) {
    boolean createMod = true;
    if (moduleAmount < 1)
    {
      modulesList.add(new Module(mouseX, mouseY, moduleAmount+1));
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
    } else
    {
      for (Module mod : modulesList)
      {
        if (moduleAmount >= 1 && mod.xPos-mod.radius <= mouseX && mod.xPos+mod.radius >= mouseX 
          && mod.yPos-mod.radius <= mouseY && mod.yPos+mod.radius >= mouseY)
        {
          println(time()+" mod canont be positioned here!");
          createMod = false;
          break;
        }
      }
      if (createMod)
      {
        modulesList.add(new Module(mouseX, mouseY, moduleAmount+1));
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
  }



  //--------------------------------ACT MODE------------------------------------
  //moving of modules
  if (soundstate == ACT) {
    PVector mouseposition = new PVector(mouseX, mouseY);
    for (Module mod : modulesList) {
      if (abs(PVector.dist(mouseposition, mod.position)) < 10) {
        mod.mouseMove = true;
        mod.xPos = mouseX;
        mod.yPos = mouseY;
      }
    }
  }
}

public void mouseReleased() {
  for (Module mod : modulesList) {
    mod.mouseMove = false;
    mod.position = new PVector(mod.xPos, mod.yPos);
  }
}
  public void settings() {  size(1024, 1024); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "otheringmachines02_06polySound" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
