int sentData;

int[] db1 = new int[0];

void setup() {
  frameRate(1);
}


void draw() {
  sentData = int(random(60));
  
  int dbIdx = dbgetIdx();
  if(dbIdx<0){
    db1 = append(db1, sentData);
    db1 = sort(db1);
    printArray(db1);
    println(sentData+" appended at "+dbgetIdx());
  }else{
    println(sentData+" found at "+dbIdx);
  }
}

int dbgetIdx() {
  for (int i = 0; i< db1.length; i++) {
    if (sentData == db1[i]) {
      return i;
    }    
  }
  return -1;
}