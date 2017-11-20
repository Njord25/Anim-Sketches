class Spider {
  
  ArrayList<SpiderFoot> feet = new ArrayList<SpiderFoot>();
  float numFeet = 16;
  
  PVector pos;
  PVector lastPos;
  PVector dest;
  PVector vel;
  PVector acc;
  PVector eyePos;
  float eyeAngle = 0;
  float eyeLastPos;
  float eyeNextPos;
  
  float size;
  float eyesize;
  float time = 0;
  float maxRest = 5;
  float moveTime = 0;
  float moveDuration = 100;
  float rotateAngle = 0;
  float lastRotateAngle = 0;
  float nextRotateAngle;
  
  Boolean stopped = true;
  Boolean rotating = false;
  Boolean freeze = false;

   Spider(float _x, float _y, float _angle) {
     pos = new PVector(_x, _y);
     eyePos = pos.copy();
     lastPos = pos.copy();  
     size = 100;
     eyesize = size / 4;
     eyePos = new PVector(pos.x + (cos(eyeAngle) * 50), pos.y + (sin(eyeAngle) * 50));
     
     float step = _angle/numFeet;   
     for(int i=0; i<numFeet/2; i++) {
       float vel = random(0.005, 0.007);
       float lenvel = random(0.1, 0.5);
       feet.add(new SpiderFoot(i * step, i, vel*(i+1), true, lenvel*(i+1)));
       feet.add(new SpiderFoot((numFeet - i - 1) * step, int(numFeet - i - 1), vel*(i+1), false, lenvel*(i+1)));
     }
   }
   
   void move() {
     
     lastPos = pos.copy();
     float a = random(-360, 360);
     dest = PVector.fromAngle(radians(a));
     dest.normalize();
     float moveDistance = random(50, 150);
     dest.mult(moveDistance);
     moveDuration = int(dest.mag());
     
     eyeLastPos = eyeAngle;
     eyeNextPos = random(-180, 180);
   
     PVector nextPos = PVector.add(pos, dest);
     if(nextPos.x > width) dest.x = -abs(dest.x);
     else if(nextPos.x < 0) dest.x = abs(dest.x);
     if(nextPos.y  > height) dest.y = -abs(dest.y);
     else if(nextPos.y < 0) dest.y = abs(dest.y);
     
     time = 0;
     moveTime = 0;
     stopped = false;
   }
   
   void update() {
      if(!stopped) {
        pos.x = Penner.easeInOutBack(moveTime, lastPos.x, dest.x, moveDuration);
        pos.y = Penner.easeInOutBack(moveTime, lastPos.y, dest.y, moveDuration);
        
        eyeAngle = Penner.easeInOutBack(moveTime, eyeLastPos, eyeNextPos, moveDuration);
        eyePos.x = (cos(radians(eyeAngle)) * 25);
        eyePos.y = (sin(radians(eyeAngle)) * 25);
        
        time+=0.001;
        moveTime++;
        //rotateAngle+=0.002;   
        if(rotateAngle >= TWO_PI) rotateAngle = 0;
        
        for(SpiderFoot f : feet) {
          if(moveTime > moveDuration - 20) {
            f.freeze = true;
          } else {
            f.freeze = false;
          }
        }
        
        if(moveTime > moveDuration) {
          stopped = true;
          move();
        }
      }
   }
   
   void display() {
     pushMatrix();
     translate(pos.x, pos.y);
     rotate(rotateAngle);
     
     ellipseMode(CENTER);
     noFill();
     strokeWeight(3);
     stroke(255);
     ellipse(0, 0, size, size);
     fill(255);
     noStroke();
     ellipse(0, 0, size-15, size-15);
     
     fill(0);
     ellipse(eyePos.x, eyePos.y, eyesize, eyesize);  
     
     popMatrix();
   }
   
   void run() {
     if(stopped) move();
     update();
     display();
     
     for(SpiderFoot f : feet) {
       f.run(pos, rotateAngle, stopped);
     }
   }
}

class SpiderFoot {
  
  PVector pos;
  PVector footPos;
  Boolean forward;
  Boolean stopped = false;
  Boolean changed = false;
  Boolean freeze = false;
  float angle;
  float vel;
  float footAngle;
  float size = 75;
  float minAngle;
  float maxAngle;
  float len = size/2;
  float lenVel;
  float rotateAngle = 0;
  Boolean lenDirection = true;
  int index;

  SpiderFoot(float _angle, int _index, float _vel, Boolean _forward, float _lenvel) {
    lenVel = _lenvel;
    forward = _forward;
    angle = _angle;
    footAngle = _angle;
    minAngle = angle - (PI/8);
    maxAngle = angle + (PI/8);
    pos = new PVector(0,0);
    footPos = new PVector(0,0);
    index = _index;
    vel = _vel;
  }
  
  void move() {
    
    footAngle = forward ? footAngle - vel : footAngle + vel;
    if(footAngle < minAngle && forward) forward = false;
    if(footAngle > maxAngle && !forward) forward = true;
    
    len = lenDirection ? len - lenVel : len + lenVel;
    if(len < 50 && lenDirection) lenDirection = false;
    if(len > 75 && !lenDirection) lenDirection = true;
    
  }
  
  void update(PVector p, float r, Boolean f) {
    freeze = f;
    rotateAngle = r;
    pos.x = (cos(angle) * size/1.7);
    pos.y = (sin(angle) * size/1.7);
    footPos.x = (!freeze) ? pos.x + (cos(angle) * len) : pos.x + (cos(angle));
    footPos.y = (!freeze) ? pos.y + (sin(angle) * len) : pos.y +(sin(angle));
  }
  
  void display(PVector p) {
    pushMatrix();
    translate(p.x, p.y);
    rotate(rotateAngle);
    strokeWeight(3);
    stroke(255);
    line(pos.x, pos.y, footPos.x, footPos.y);
    ellipse(footPos.x, footPos.y, 5, 5);
    line(footPos.x, footPos.y, footPos.x + (cos(footAngle) * size), footPos.y + (sin(footAngle) * size));
    popMatrix();
  }
  
  void run(PVector _parent, float _rotate, Boolean _freeze) {
    if(!stopped) move();
    update(_parent, _rotate, _freeze);
    display(_parent);
  }
  
}