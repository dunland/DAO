void keyPressed() {
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
      modulesList.get(0).sentData = modulesList.get(0).db[int(random(0, 3))];
      modulesList.get(0).emit = true;
      //sendingMod = modulesList.get(sendingModIdx); //starting signal transmitter is first placed mod
    }
  }
}

void mousePressed() {
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

void mouseReleased() {
  for (Module mod : modulesList) {
    mod.mouseMove = false;
    mod.position = new PVector(mod.xPos, mod.yPos);
  }
}
