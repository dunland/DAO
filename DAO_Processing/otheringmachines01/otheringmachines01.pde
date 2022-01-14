/*Othering Machines v.1.0
summer semester 2017
course DAO
HfK Bremen
- David Unland
*/


//import gifAnimation.*;
import java.util.Collections;

int moduleAmount = 30;
int dbStartingValues = 50; //highest predefined number for each db slot in modules
int tolerance = 20; //closest allowed proximity of modules
int sendingModIdx = int(random(moduleAmount)); //starting signal transmitter is random

float signalMag = 0; //magnitude of signal
float signalSpeed = 5;
int sentData;

int soundstate;
int GO = 1;
int STOP = 0;

ArrayList<Module> modules = new ArrayList<Module>();
Module sendingMod;

void setup() {
  //design
  size(400, 400);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);

  soundstate = STOP;

  //create all modules...
  for (int i=0; i<moduleAmount; i++) {
    modules.add(new Module(random(width/4, (width-width/4)-20), random(height/4, (height-height/4)-20), 0.1*i, i));
  }
  //...before module positioning
  for (int i=0; i<moduleAmount; i++) {
    modules.get(i).checkPosition();
  }
}  


void draw() {
  background(255);
  noStroke();
  for (Module mod : modules) {
    mod.draw();
    mod.emit();
    mod.move();
  }
  if (soundstate == GO) {
    sendSignal();
  }
}


class Module {

  //variables
  int modnumber; //a # of each mod to be displayed
  float xPos, yPos;
  float wait;
  PVector position;
  color modColor=color(0);
  float stopReact;
  boolean emit=false;
  int newData=-1;

  boolean moveNow = false;
  boolean agree;
  float travelDistance;

  ArrayList<Integer> dataBase;

  //constructor for individual mods
  Module(float ixPos, float iyPos, float iwait, int imodnumber) {
    xPos = ixPos;
    yPos = iyPos;
    wait = iwait;
    modnumber = imodnumber;
    position = new PVector(xPos, yPos);
    dataBase = new ArrayList<Integer>();
    for (int i = 0; i<5; i++) {
      dataBase.add(int(random(dbStartingValues)));
    }
  }

  void checkPosition() {
    for (int i = 0; i<moduleAmount; i++) {
      if (modules.get(i)!=this) {
        if (PVector.dist(position, modules.get(i).position)<20) {
          println(time()+" ...assigning new position of module "+i);
          xPos = random(width/4, (width-width/4)-20);
          yPos = random(height/4, (height-height/4)-20);
          position = new PVector(xPos, yPos);
        }
      }
    }
  }

  //custom methods
  void draw() {
    fill(modColor);
    if (time() > stopReact) {
      modColor = (0);
    }
    ellipse(xPos, yPos, 20, 20);
    fill(255);
    text(modnumber, xPos, yPos);
  }

  void react(int incomingData) {
    if (this != sendingMod) {
      //check distance to other modules by signal:
      if (abs(PVector.dist(this.position, sendingMod.position))-5<=signalMag/2 
        && abs(PVector.dist(this.position, sendingMod.position))+5>=signalMag/2) {
        if (time()>stopReact) { //only react once
          print("\n"+time()+" intercepting with mod "+this.modnumber+": ");
          //receive data, compare data, add
          checkIncomingData(incomingData);
          //if added: emit() after some time;
          emit();
        }
        stopReact = time() + 2;
      }
    }
  }

  void checkIncomingData(int incomingData) {
    int idxOfIncomingData = dataBase.indexOf(incomingData);
    int delayFactor = 3; //factor for response (emission) delay after reaction

    if (idxOfIncomingData==-1) { //incomingData does not exist
      dataBase.add(incomingData);
      Collections.sort(dataBase);
      printArray(dataBase);
      idxOfIncomingData = dataBase.indexOf(incomingData);

      if (dataBase.size()==1) { //incomingData is now only entry
        newData = incomingData;
        wait = time()+dataBase.get(idxOfIncomingData)*delayFactor;
      } else if (idxOfIncomingData==dataBase.size()-1) { //incomingData is now highest value
        newData = dataBase.get(idxOfIncomingData-1);
        wait = time()+(incomingData-dataBase.get(idxOfIncomingData-1))*delayFactor;  //wait until emit
      } else if (idxOfIncomingData==0) { //entry is lowest
        newData = dataBase.get(idxOfIncomingData+1);
        wait = time()+(dataBase.get(idxOfIncomingData+1)-incomingData)*delayFactor;  //wait until emit
      } else { //entry inside
        int diflower = incomingData-dataBase.get(idxOfIncomingData-1);
        int difhigher = dataBase.get(idxOfIncomingData+1)-incomingData;
        newData = difhigher < diflower ? dataBase.get(idxOfIncomingData+1) : dataBase.get(idxOfIncomingData-1);
        wait = time()+max(difhigher, diflower)*3;  //wait until emit
      }

      println(time()+" incoming data ("+incomingData+") appended at ["+idxOfIncomingData+"]. Closest Value: "+newData+". Will wait "+(wait-time())+" sec");
      modColor=color(255, 0, 0);
      emit = true;
      moveNow = true;
      agree = false;
    } else { //entry does exist
      println(time()+" incoming data ("+sentData+") already exists at ["+idxOfIncomingData+"]");
      modColor=color(0, 255, 0);
      moveNow = true;
      agree = true;
    }
  }


  void emit() {
    if (soundstate == STOP && emit && time()>wait) {
      for (int i=0; i<moduleAmount; i++) {   //prevents all objects from emitting afterwards
        modules.get(i).emit=false;
      }
      soundstate = GO;
      println("\n\n"+time()+" ################ soundstate = GO ################");
      //emit sound
      sentData = newData;
      sendingMod = this;
      println(time()+" mod "+this.modnumber+" sends '"+sentData+"'");
    }
  }

  void move() {
    PVector pTo = new PVector(xPos, yPos);
    float easing = 0.025;

    if (moveNow) {  
      if (travelDistance<25) {
        float dx = sendingMod.xPos - this.xPos;
        if (agree) {
          xPos += dx * easing;
        } else {
          xPos -= dx * easing;
        }

        float dy = sendingMod.yPos - this.yPos;
        if (agree) {
          yPos += dy * easing;
        } else {
          yPos -= dy * easing;
        }
        travelDistance = this.position.dist(pTo);
      } else { 
        moveNow = false;
        travelDistance=0;
        position=pTo;
      }
    }
  }
}

float time() {
  return 0.001 *millis() + second() + minute()*60 + hour() * 60 * 60;
}