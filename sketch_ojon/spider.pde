class Angel {
  
  ArrayList<Wing> wings = new ArrayList<Wing>();
  float numFeet = 10;
  
  PVector pos;
  PVector lastPos = new PVector(0,0,0);
  PVector dest;
  PVector vel;
  PVector acc;
  PVector eyePos;
  
  float size;
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

   Angel(float _x, float _y, float _angle) {
     pos = new PVector(_x, _y);
     lastPos.x = pos.x;  
     lastPos.y = pos.y;  
     size = 50;
     
     float step = _angle/numFeet;   
     for(int i=0; i<numFeet; i++) {
       wings.add(new Wing(step * i, size));
     }
   }
   
   void move() {
     
     lastPos.x = pos.x;  
     lastPos.y = pos.y;  
     float a = random(-360, 360);
     dest = PVector.fromAngle(radians(a));
     dest.normalize();
     float moveDistance = random(50, 150);
     dest.mult(moveDistance);
     moveDuration = int(dest.mag());
   
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
        
        time+=0.001;
        moveTime++;
        rotateAngle+=0.002;   
        if(rotateAngle >= TWO_PI) rotateAngle = 0;
        
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
     stroke(0, 150, 255, 65);
     ellipse(0, 0, size, size);
     fill(0, 150, 255, 65);
     noStroke();
     ellipse(0, 0, size-15, size-15);
     
     popMatrix();
   }
   
   void run() {
     if(stopped) move();
     update();
     display();
     
     for(Wing g : wings) {
       g.run(pos);
     }
   }
}