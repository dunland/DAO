void keyPressed() {
  //-----------------------------STOPPING-----------------------------
  if (soundstate == ACT) {
    if (key == ENTER || key == RETURN) {
      soundstate = STOP;
      print("stopped");
    }
  } else if (soundstate == STOP) {
    if (key == ENTER || key == RETURN) {
      soundstate = ACT;
      println("...    continued.");
    }
  }

  //--------------------------GIF ANIMATION---------------------------

  if (key == 'g' || key == 'G')
  {
    if (gifAnimation)
    {
      gifAnimation = false;
      println("Frame saving paused.");
    } else 
    {
      gifAnimation = true;
      println("Frame saving started.");
    }
  }

  //-------------------------- print float time()---------------------------
  if (key == 't' || key == 'T')
  {
    println("time() returns "+time());
  }

  //-------------------------------INITIAL STATE-------------------------------
  if (soundstate == INIT && moduleAmount > 1) {
    if (key == ENTER || key == RETURN) {
      soundstate = ACT;
      modulesList.get(0).sentData = modulesList.get(0).db[int(random(0, 3))];
      modulesList.get(0).emit = true;
      //sendingMod = modulesList.get(sendingModIdx); //starting signal transmitter is first placed mod
    }
  }
}

//-------------------------------modules placing-------------------------------
void mousePressed() {
  //create new mod:
  //  mouse pressed = add mod at mod position (if not at mod pos)
  if (soundstate == INIT) {
    boolean createMod = true;
    if (moduleAmount < 1)
    {
      modulesList.add(new Module(mouseX, mouseY, moduleAmount+1));
      moduleAmount++;
      println("mod "+moduleAmount+" created:");
      println("["+modulesList.get(moduleAmount-1).db[0]+" | "
        +modulesList.get(moduleAmount-1).db[1]+" | "+modulesList.get(moduleAmount-1).db[2]+"]");
      println("["+modulesList.get(moduleAmount-1).ab[0]+" | "
        +modulesList.get(moduleAmount-1).ab[1]+" | "+modulesList.get(moduleAmount-1).ab[2]+"]");
      println("RGB: "+modulesList.get(moduleAmount-1).redAb+","+
        modulesList.get(moduleAmount-1).greenAb+","+modulesList.get(moduleAmount-1).blueAb);
      println("respondFactor = "+modulesList.get(moduleAmount-1).respondFactor
        +"; stopReact = "+modulesList.get(moduleAmount-1).stopReact);
      println();
    } else
    {
      for (Module mod : modulesList)
      {
        if (moduleAmount >= 1 && mod.xPos-mod.radius <= mouseX && mod.xPos+mod.radius >= mouseX 
          && mod.yPos-mod.radius <= mouseY && mod.yPos+mod.radius >= mouseY)
        {
          println("mod canont be positioned here!");
          createMod = false;
          break;
        }
      }
      if (createMod)
      {
        modulesList.add(new Module(mouseX, mouseY, moduleAmount+1));
        moduleAmount++;
        println("mod "+moduleAmount+" created:");
        println("["+modulesList.get(moduleAmount-1).db[0]+" | "
          +modulesList.get(moduleAmount-1).db[1]+" | "+modulesList.get(moduleAmount-1).db[2]+"]");
        println("["+modulesList.get(moduleAmount-1).ab[0]+" | "
          +modulesList.get(moduleAmount-1).ab[1]+" | "+modulesList.get(moduleAmount-1).ab[2]+"]");
        println("RGB: "+modulesList.get(moduleAmount-1).redAb+","+
          modulesList.get(moduleAmount-1).greenAb+","+modulesList.get(moduleAmount-1).blueAb);
        println("respondFactor = "+modulesList.get(moduleAmount-1).respondFactor
          +"; stopReact = "+modulesList.get(moduleAmount-1).stopReact);
        println();
      }
    }
  }

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
