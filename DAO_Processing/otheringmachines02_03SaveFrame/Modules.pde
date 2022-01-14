class Module {

  //variables
  int modnumber; //a # of each mod to be displayed
  float xPos, yPos;
  PVector position;
  color modColor=color(0);
  boolean mouseMove = false; //if true, mod will be drawn at mouseposition

  float stopReact = 0;
  boolean subside = false;
  boolean emit=false;
  int react = 0; //0 = standby, 1 = positive reaction, 2 = negative reaction
  int sentData; //signal output, data used for signalPropagation

  float signalMag = 0; //magnitude of signal

  boolean dataExists = false;
  boolean dbFull = false;
  int freqTol = 50;
  int dbLength = 3;
  int[] db = new int[dbLength];
  int[] ab = new int[dbLength];
  int abTot = 3;
  int greenAb = 0;
  int redAb = 0;
  int blueAb = 0;
  int timedStatement = int(random(60, 121));
  float respondFactor = timedStatement*0.01;

  //constructor for individual mods
  Module(float ixPos, float iyPos, int imodnumber) {
    xPos = ixPos;
    yPos = iyPos;
    modnumber = imodnumber;
    position = new PVector(xPos, yPos);
    for (int i = 0; i<dbLength; i++) {                                                    //fill dB
      db[i] = int(random(lowestDbValue, highestDbValue));
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
  //////////////////////////fills with color until time>stopReact/////////////////////////
  void draw() {
    noStroke();
    //fill(modColor);
    if (!emit && time() > stopReact) {    //if ready: glow white
      fill(255);
      ellipse(xPos, yPos, 30, 30);
    }
    if (subside && time() < stopReact) { //if subside (10s), glow RGB LED
      float abTotF = float(abTot);
      float R = (redAb/abTotF) * 255;
      float G = (greenAb/abTotF) * 255;
      float B = (blueAb/abTotF) * 255;
      //println("R = "+R+"G = "+G+"B = "+B);
      //println(redAb);
      //println(abTot);
      fill(R, G, B, 125);
      ellipse(xPos, yPos, 30, 30);
    }
    if (time() > stopReact) {
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
  }


  ////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////SIGNAL PROPAGATION/////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////


  void signalPropagation() {
    if (emit && time()>stopReact) {
      if (signalMag == 0){
        println("mod "+modnumber+" sends "+sentData+"...");
      }
      if (signalMag <= height) {
        //if (signalMag <= 2*height) { //until signal magnitude exceeds screen ...
        noFill();
        stroke(255);
        //stroke(sentData*10+5, xPos/255*sentData, modnumber*sentData*5); //sets color representatively for sentData
        ellipse(xPos, yPos, signalMag, signalMag); //...draw that circle...
        for (int i = 0; i < moduleAmount; i++) {
          if (modulesList.get(i) != this) {
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
      } else {
        emit = false;
        signalMag=0;
        subside = true;
        stopReact = time() + 10;
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////WHEN INTERSECTING///////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  void intersect(PVector emittingModPosition, int emittingModNumber, float emittingModSignal, int incomingData) {
    //check distance to other modules by signal:
    if (this.emit == false) {
      //println("modulesList.get("+j+").emit == true");
      if (abs(PVector.dist(this.position, emittingModPosition))-25<=emittingModSignal/2       //check actual intersection
        && abs(PVector.dist(this.position, emittingModPosition))+25>=emittingModSignal/2) {
        //if (abs(PVector.dist(this.position, emittingModPosition))-5<=emittingModSignal/2       //check actual intersection
        //  && abs(PVector.dist(this.position, emittingModPosition))+5>=emittingModSignal/2) {
        if (time()>stopReact) { //only react once
          println("mod "+emittingModNumber+" intercepting with mod "+this.modnumber+": ");
          //receive data, compare data, add
          checkIncomingData(incomingData);
        }
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////CHECK INCOMING DATA/////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////


  void checkIncomingData(int incomingData) {
    print("mod "+this.modnumber+": checking incomingData... ");

    //data within tolerance?
    for (int i = 0; i < dbLength; i++) {
      if (abs(incomingData - db[i]) < freqTol) {
        //-> increase abundancy

        println("match found at ["+i+"]: "+db[i]);
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
        //positive reaction
        sentData = db[i];
        react = 1; // 1 = positiveReaction, 2 = negativeReaction
        stopReact = time() + 100 * respondFactor; // that makes values from 60 to 120 seconds
        //positiveReaction(db[i]);
        break;
      }
    }
    //data not within tolerance:

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

      //if abundancy = 0, add data
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
          print("entry at 0, wait = ");
          println(wait);
        } else if (lowestIdx == dbLength - 1) {
          wait = (db[lowestIdx] - db[lowestIdx - 1]) * respondFactor;
          closest = db[dbLength - 2];
          print("entry at end, wait = ");
          println(wait);
          //entry at end: wait dist
        } else {
          //middle: calc diff, wait dist
          if (db[lowestIdx] - db[lowestIdx - 1] < db[lowestIdx + 1] - db[lowestIdx]) {
            wait = (db[lowestIdx] - db[lowestIdx - 1]) * respondFactor;
            closest = db[lowestIdx - 1];
            println(db[lowestIdx]+" - "+db[lowestIdx - 1]+" < "+db[lowestIdx + 1]+" - "
              +db[lowestIdx]+", difference/wait = "+wait);
          } else {
            wait = (db[lowestIdx + 1] - db[lowestIdx]) * respondFactor;
            closest = db[lowestIdx + 1];
            println(db[lowestIdx]+" - "+db[lowestIdx - 1]+" > "+db[lowestIdx + 1]+" - "
              +db[lowestIdx]+", difference/wait = "+wait);
          }
        }
        println("lowest entry = "+db[lowestIdx]+" dropped, "+incomingData+" added.");        
        print("closest sound = ");
        println(closest);
        sentData = closest;
        stopReact = time() + 5;
        //stopReact = time() + wait;
        react = 2;
      }
    }
    println("["+db[0]+" | "+db[1]+" | "+db[2]+"]");
    println("["+ab[0]+" | "+ab[1]+" | "+ab[2]+"]");
    println();
    dataExists = false;
    //printDatabase();
  }

  void positiveReaction() {
    if (react == 1) {
      //repeats the db match for incoming data
      //returns sent data for signal propagation
      if (time() > stopReact) {    //wait
        emit = true;               //start emitting
        react = 0;
      }
    }
  }

  void negativeReaction() {
    if (react == 2) {
      //vibrate
      //wait + busy blinking
      if (time() > stopReact) {
        emit = true;
        react = 0;
      }
    }
  }

  void timedStatement() {
    //if (this.modnumber==1){
    //  println(time() % timedStatement);
    //}
    if (time() % timedStatement <= 1 && time() > stopReact) {
      //int highest = ab[0];
      //int highestIdx = 0;
      //for (int i = 0; i < dbLength; i++) {
      //  if (ab[i] > highest) {
      //    highestIdx = i;
      //  }
      //}
      stopReact = time() + 1;
      emit = true;
      sentData = db[int(random(0,dbLength))];
    }
  }


  void sortDatabase(int a[], int size) {
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