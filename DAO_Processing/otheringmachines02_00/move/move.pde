float x=random(width), y=random(height);
float targetX=width/2, targetY=height/2;
float easing = 0.05;
boolean moveGo = false;
PVector pFrom = new PVector (x, y);
PVector pTo;
float dist = 0;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
}

void draw() {
  background(255);
  noStroke();
  fill(129, 129, 129);
  ellipse(targetX, targetY, 50, 50);

  fill(255, 129, 0);
  ellipse(x, y, 50, 50);
  
  move();
}

void mousePressed() {
  moveGo = true;
  dist= 0;
  pFrom = new PVector (x, y);  
  targetX=mouseX;
  targetY=mouseY;
}


void move() {
  pTo = new PVector(x,y);
  if (moveGo) {  
    if (dist<100) {
      float dx = targetX - x;
      x += dx * easing;

      float dy = targetY - y;
      y += dy * easing;
      dist = pFrom.dist(pTo);
  println(dist);
    } else { 
      moveGo = false;
    }
  }
}