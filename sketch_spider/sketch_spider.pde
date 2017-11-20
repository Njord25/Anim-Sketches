ArrayList<Spider> spiders = new ArrayList<Spider>();
int numSpiders = 1;
float pi;

void setup() {
  size(1000, 1000);
  pi = PI;
  
  for(int i=0; i<numSpiders; i++) {
    spiders.add(new Spider(width/2, height/2, TWO_PI*0.75));
  }
}

void draw() {
  background(0);
  
  for(Spider s : spiders) {
    s.run();
  }
}

static class Penner {
  static float easeInOutBack(float t, float b, float c, float d) {
    float s = 0;
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525f))+1)*t + s) + 2) + b;
  }
};