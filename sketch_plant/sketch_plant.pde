//import spout.*;
//PGraphics pgr; 
//Spout spout;

ArrayList<Plant> plants = new ArrayList<Plant>();
int numPlants = 20;
float offy = 600;

void setup(){
  size(1000, 1000, P2D);
  //pgr = createGraphics(2000, 2000, P2D);
  
  for(int i=0; i<numPlants; i++) {
    plants.add(new Plant(int(random(5, 15)), random(width), random(height-offy, height+100)));
  }
  //spout = new Spout(this); 
  //spout.createSender("Spout Processing");
}

void draw(){
  background(0);
  
  for(Plant p : plants) {
    p.display();    
  }
  
  //spout.sendTexture();
}