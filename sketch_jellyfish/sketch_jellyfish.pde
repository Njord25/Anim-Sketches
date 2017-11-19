//import spout.*;
//PGraphics pgr; 
//Spout spout;

Jellyfish[] c;
ArrayList<Jellyfish> jellys = new ArrayList<Jellyfish>();
int numJellys = 1;
 
void setup() {
  size(800, 800, P3D);
  //pgr = createGraphics(2000, 2000, P2D);
  for(int i=0; i<numJellys; i++){
    jellys.add(new Jellyfish( new PVector(int(random(width)), int(random(height)) / 2), 12, 12, 12, 30, 10, 10 ));
  }
  
  //spout = new Spout(this); 
  //spout.createSender("Spout Processing");
}
  
void draw() {
  background(0);
  //fill(0,70);
  //rect(0,0,width,height);
  for(Jellyfish c : jellys){
    c.update();
  }
  //spout.sendTexture();
}
 
  
// From Robert Penner's easing equations
static class Penner {
  // time, beginning position, change in position, and duration
  static float easeInOutCubic(float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return c/2*t*t*t + b;
    return c/2*((t-=2)*t*t + 2) + b;
  }
  
  static float easeInOutBack(float t, float b, float c, float d) {
    float s = 1.70158f;
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s-=(1.525f))+1)*t + s) + 2) + b;
  }
  
  static float easeInOutSine(float t, float b, float c, float d) {
    return -c/2 * ((float)Math.cos(Math.PI*t/d) - 1) + b;
  }
};
  
void keyPressed() {
  if(key == 'R' || key == 'r') {
    for(Jellyfish c : jellys) {
      c.rotating = true;
    }
  }
  
  if(key == 'D' || key == 'd') {
    for(Jellyfish c : jellys) {
      c.desintegrating = true;
    }
  }
}

void keyReleased() {
  if(key == 'R' || key == 'r') {
    for(Jellyfish c : jellys) {
      c.rotating = false;
    }
  }
}