//import spout.*;
//PGraphics pgr; 
//Spout spout;

ArrayList<Angel> angels = new ArrayList<Angel>();
int numAngels = 2;

void setup() {
  size(1000, 1000, P3D);
  //pgr = createGraphics(2000, 2000, P3D);
  
  for(int i=0; i<numAngels; i++) {
    angels.add(new Angel(random(width), random(height), TWO_PI));
  }
  
  //spout = new Spout(this); 
  //spout.createSender("Spout Processing");
}

void draw() {
  background(0);
  
  for(Angel s : angels) {
    s.run();
  }
  
  //spout.sendTexture();
}

static class Penner {
  static float easeInOutBack(float t, float b, float c, float d) {
    float s = 0;
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525f))+1)*t + s) + 2) + b;
  }
};