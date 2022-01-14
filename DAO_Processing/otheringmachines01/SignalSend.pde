void keyPressed() {
  //boolean gifRec = false;
  if (soundstate==STOP) {
    println(time()+" key Pressed. sound state=GO");
    soundstate = GO;
    sentData = int(random(25));


    //choose module = signal
    sendingMod = modules.get(sendingModIdx);
    println(time()+" mod "+sendingMod.modnumber+" sends '"+sentData+"'");
  }

  //if (key == 'g' || key == 'G') {
  //  GifMaker gifExport = new GifMaker(this, "export.gif");
  //  if (!gifRec) {
  //    println(time()+" gif record start");
  //    gifRec=true;
  //    gifExport = new GifMaker(this, "export.gif");
  //    gifExport.setRepeat(0);
  //    gifExport.setTransparent(0, 0, 0);
  //  } else {
  //    gifRec=false;
  //    gifExport.finish();
  //    println(time()+" gif record end");
  //  }
  //}
}

void sendSignal() {
  if (signalMag <= 2*height) { //until signal magnitude exceeds screen ...
    noFill();
    stroke(sentData*10+5, sendingMod.xPos/255*sentData, sendingMod.modnumber*sentData*5);
    ellipse(sendingMod.xPos, sendingMod.yPos, signalMag, signalMag); //...draw that circle...
    for (int j = 0; j < moduleAmount; j++) {
      modules.get(j).react(sentData); //..check overlap with objects...
    }
    signalMag+=signalSpeed*1; //increase the magnitude
    float signalNoise = random(-1,1); //add noise to the signal depending on its distance
    if(signalMag%20==0){
      sentData += signalNoise;
      println("***");
    }
  } else {
    soundstate = STOP;
    signalMag=0;
    println(time()+" ################ soundstate = STOP ###############");
  }
}