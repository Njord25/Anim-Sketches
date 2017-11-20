//import spout.*;
//PGraphics pgr; 
//Spout spout;

ArrayList<Hongo> hongos = new ArrayList<Hongo>();
int numHongos = 3;

Hongo p;
Hongo p2;
Hongo p3;

void setup() {
  size(1000, 1000, P2D);
  //pgr = createGraphics(2000, 2000, P2D);
  
  p = new Hongo(width/2, 350, 30, 1000, 200, 100, 40, 300, 55); 
  p2 = new Hongo(width/2 - 150, 500, 50, 1500, 100, 200, 40, 30, 25); 
  p3 = new Hongo(width/2 + 150, 650, 10, 500, 350, 175, 40, 175, 45); 
  
  for(int i=0; i<numHongos; i++) {
    float l = random(200, 500);
    float r = random(100, l*0.7);
    float n = random(r*0.5, r*0.1);
    hongos.add(new Hongo(random(width), l, random(5, 50), random(250, 1500), r, random(l*0.25, l*0.5), n, random(l*0.5, l*0.8), random(n*0.5, n*0.1)));
  }
  
  //spout = new Spout(this); 
  //spout.createSender("Spout Processing");
}

void draw() {
  background(0);
  p.run();
  p2.run();
  p3.run();
  
  for(Hongo h : hongos) {
    //h.run();
  }
  //spout.sendTexture();
}