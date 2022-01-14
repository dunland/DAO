class Module {

  //variables
  int modnumber; //a # of each mod to be displayed
  float xPos, yPos;
  PVector position;
  color modColor=color(0);
  boolean mouseMove = false; //if true, mod will be drawn at mouseposition

  float subsidingTime = 25; //time to wait after negative and positive reactions
  boolean subsideAfterEmission = false;
  boolean waitBeforeReaction = false;
  int timedStatement = int(random(640, 1281)); //timed Statement in s
  float respondFactor = timedStatement*0.01; //2.4 to 4.8
  //float pauseAction = time() + 100 * respondFactor;
  float pauseAction = 0;
  boolean emit=false;
  //int react = 0; //0 = standby, 1 = positive reaction, 2 = negative reaction
  boolean react = false; //false = standby, true = react
  //int sentData; //signal output, data used for signalPropagation

  float signalMag = 0; //magnitude of signal
  int signalRange = 300;

  //  boolean dataExists = false;
  //  boolean dbFull = false;
  int freqTol = 50;
  //  int dbLength = 3;
  //  int dbLength = 1;
  int ownData = int(random(0, 3000));
  //int[] db = new int[dbLength];
  //int[] ab = new int[dbLength];

  //------------------------------DISPLAY
  int radius = 30;
  int abTot = 3;
  //int greenAb = 0;
  //int redAb = 0;
  //int blueAb = 0;

  TriOsc sound = new TriOsc(soundProximation00.this); //muss sketch-Name.this sein

  //constructor for individual mods
  Module(float ixPos, float iyPos, int imodnumber) {
    xPos = ixPos;
    yPos = iyPos;
    modnumber = imodnumber;
    position = new PVector(xPos, yPos);

    //------------------------------fill db
    //for (int i = 0; i<dbLength; i++) 
    //  {
    //    db[i] = int(random(lowestDbValue, highestDbValue));
    //    ab[i] = 1;
    //    if (db[i] >= 300 && db[i] < 1000) {
    //      redAb++;
    //    } else if (db[i] >= 1000 && db[i] < 1700) {
    //      greenAb++;
    //    } else if (db[i] >= 1700 && db[i] < 2401) {
    //      blueAb++;
    //    }
    //  }
  }


  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////DRAW////////////////////////////////////////////
  //////////////////////////fills with color until time>pauseAction/////////////////////////
  void draw() {
    noStroke();
    //fill(modColor);
    //----------------------------------------------GLOW WHITE
    if (!emit && time() > pauseAction) {    //if ready: glow white
      fill(255);
      ellipse(xPos, yPos, radius, radius);
    }

    //----------------------------------------------BEFORE REACTION: GLOW RGB
    if (waitBeforeReaction && time() < pauseAction) //if subside, glow RGB LED 
    { 
      float R = (ownData - 750) * 255 / 750;
      float G = (ownData - 1500) * 255 / 750;
      float B = (ownData - 2250) * 255 / 750;
      //println("R = "+R+"G = "+G+"B = "+B);
      //println(redAb);
      //println(abTot);
      fill(R, G, B, 125);
      ellipse(xPos, yPos, 30, 30);
    }
    if (time() > pauseAction) 
    {
      modColor = (0);
    }

    if (mouseMove == true) 
    {
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


  void signalPropagation() //is executed in general loop
  {
    if (emit && time()>pauseAction) 
    {
      if (signalMag == 0) 
      {
        println(time()+" mod "+modnumber+" sends "+ownData+"...");
        playSound = time()+0.6;
      }
      if (signalMag <= signalRange) 
      {
        if (time()<playSound)
        {
          sound.play(ownData, 1);
        } else
        {
          sound.stop();
        }
        //if (signalMag <= 2*height) { //until signal magnitude exceeds screen ...
        noFill();
        stroke(255);
        //stroke(ownData*10+5, xPos/255*ownData, modnumber*ownData*5); //sets color representatively for ownData
        ellipse(xPos, yPos, signalMag, signalMag); //...draw that circle...
        for (int i = 0; i < moduleAmount; i++) 
        {
          if (modulesList.get(i) != this) 
          {
            //println("modulesList.get("+i+").intersect("+ownData+")");
            modulesList.get(i).intersect(this.position, this.modnumber, signalMag, ownData); //..check overlap with objects...
          }
        }
        signalMag+=signalSpeed*1; //increase the magnitude
        //float signalNoise = random(-1,1); //add noise to the signal depending on its distance
        //if(signalMag%20==0){
        //ownData += signalNoise;
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

  void intersect(PVector emittingModPosition, int emittingModNumber, float emittingModSignal, int incomingData) {
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
  //1. compare to own
  //2. calculate new value = half of difference
  //3. emit new value


  void checkIncomingData(int incomingData) {
    println(time()+" mod "+this.modnumber+": checking incomingData... ");
    int newValue = abs((incomingData + ownData) / 2);
    println("(incomingData ("+incomingData+") + ownData ("+ownData+")) / 2 = "+newValue);
    //    //------------------------------positive reaction
    ownData = newValue;
    react = true; 
    pauseAction = time() + 10 * respondFactor; // that makes values from 60 to 120 seconds
    waitBeforeReaction = true;
    println(time()+" mod "+this.modnumber+" responds in "+(this.pauseAction-time())+" s");
    //positiveReaction(db[i]);
    //    break;
    //  }
    //}


    //------------------------------data not within tolerance:
    //1. find lowest entry
    //2. lower abundancy
    //2.1. if 0: replace data
    //3. pick closest entry and respond


    //if (!dataExists) 
    //{
    //  print("no match! ");
    //  //get idx of data, emit closest
    //  int lowest = ab[0];
    //  int lowestIdx = 0;
    //  for (int i = 0; i < dbLength; i++) {
    //    if (ab[i] < lowest) {
    //      lowest = ab[i];
    //      lowestIdx = i;
    //    }
    //  }
    //  println(db[lowestIdx]+"'s abundancy decreased.");

    //  //lower abundancy
    //  ab[lowestIdx]--;
    //  abTot--;
    //  if (incomingData >= 300 && incomingData < 1000) {
    //    redAb--;
    //  } else if (incomingData >= 1000 && incomingData < 1700) {
    //    greenAb--;
    //  } else if (incomingData >= 1700 && incomingData < 2401) {
    //    blueAb--;
    //  }

    //  //if abundancy = 0, rpleace data
    //  if (ab[lowestIdx] == 0) {
    //    db[lowestIdx] = incomingData;
    //    //increase abundancy
    //    ab[lowestIdx] = 1;
    //    abTot++;
    //    if (incomingData >= 300 && incomingData < 1000) {
    //      redAb++;
    //    } else if (incomingData >= 1000 && incomingData < 1700) {
    //      greenAb++;
    //    } else if (incomingData >= 1700 && incomingData < 2401) {
    //      blueAb++;
    //    }

    //    //pick closest entry from db and respond
    //    sortDatabase(db, dbLength);
    //    float wait = 0;
    //    int closest = 0;

    //    if (lowestIdx == 0) {
    //      //entry at start: wait dist
    //      wait = (db[lowestIdx + 1] - db[lowestIdx]) * respondFactor;
    //      closest = db[lowestIdx + 1];
    //      print(time()+" entry at 0, wait = ");
    //      println(wait);
    //    } else if (lowestIdx == dbLength - 1) {
    //      wait = (db[lowestIdx] - db[lowestIdx - 1]) * respondFactor;
    //      closest = db[dbLength - 2];
    //      print("entry at end, wait = ");
    //      println(time()+wait);
    //      //entry at end: wait dist
    //    } else {
    //      //middle: calc diff, wait dist
    //      if (db[lowestIdx] - db[lowestIdx - 1] < db[lowestIdx + 1] - db[lowestIdx]) {
    //        wait = (db[lowestIdx] - db[lowestIdx - 1]) * respondFactor;
    //        closest = db[lowestIdx - 1];
    //        println(time()+db[lowestIdx]+" - "+db[lowestIdx - 1]+" < "+db[lowestIdx + 1]+" - "
    //          +db[lowestIdx]+", difference/wait = "+wait);
    //      } else {
    //        wait = (db[lowestIdx + 1] - db[lowestIdx]) * respondFactor;
    //        closest = db[lowestIdx + 1];
    //        println(time()+db[lowestIdx]+" - "+db[lowestIdx - 1]+" > "+db[lowestIdx + 1]+" - "
    //          +db[lowestIdx]+", difference/wait = "+wait);
    //      }
    //    }
    //    println(time()+" lowest entry = "+db[lowestIdx]+" dropped, "+incomingData+" added.");        
    //    print(time()+" closest sound = ");
    //    println(closest);
    //    ownData = closest;
    //    pauseAction = time() + subsidingTime;
    //    //pauseAction = time() + wait;
    //    react = 2;
    //    waitBeforeReaction = true;
    //  }
    //}
    //println(time()+" ["+db[0]+" | "+db[1]+" | "+db[2]+"]");
    //println(time()+" ["+ab[0]+" | "+ab[1]+" | "+ab[2]+"]");
    //println();
    //dataExists = false;
    //printDatabase();
  }

  //------------------------------POSITIVE REACTION------------------------------
  void react() //executed in general loop 
  {
    if (react == true) 
    {
      //repeats the db match for incoming data
      //returns sent data for signal propagation
      if (time() > pauseAction) //wait
      {    
        emit = true;               //start emitting
        react = false;
      }
    }
  }

  //------------------------------POSITIVE REACTION------------------------------
  //void positiveReaction() //executed in general loop 
  //{
  //  if (react == 1) 
  //  {
  //    //repeats the db match for incoming data
  //    //returns sent data for signal propagation
  //    if (time() > pauseAction) //wait
  //    {    
  //      emit = true;               //start emitting
  //      react = 0;
  //    }
  //  }
  //}

  //------------------------------NEGATIVE REACTION------------------------------
  //void negativeReaction() {
  //  if (react == 2) {
  //    if (time() > pauseAction) {
  //      emit = true;
  //      react = 0;
  //    }
  //  }
  //}


  //------------------------------TIMED STATEMENT---------------------------------

  void timedStatement() {
    if (time() % timedStatement <= 0.01 && time() > pauseAction && react == false && emit == false) {
      //int highest = ab[0];
      //int highestIdx = 0;
      //for (int i = 0; i < dbLength; i++) {
      //  if (ab[i] > highest) {
      //    highestIdx = i;
      //  }
      //}
      //pauseAction = time() + 1;
      emit = true;
      println(time()+" mod "+this.modnumber+"timed statement @" + time()+ "s");
    }
  }


  //void sortDatabase(int a[], int size) 
  //{
  //  for (int i = 0; i < (size - 1); i++) {
  //    for (int o = 0; o < (size - (i + 1)); o++) {
  //      if (a[o] > a[o + 1]) {
  //        int t = a[o];
  //        int b = ab[o]; //abundancy array
  //        a[o] = a[o + 1];
  //        ab[o] = ab[o + 1];
  //        a[o + 1] = t;
  //        ab[o + 1] = b;
  //      }
  //    }
  //  }
  //}
}
