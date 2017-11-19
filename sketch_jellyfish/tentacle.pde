class Tentacle {
  
  PVector position;
  float orientation;
  float angularVelocity;
  int nbParts;
  float compactness;
  ArrayList<TentaclePart> parts;
  Boolean desintegrating = false;
  
  Tentacle(PVector pos, int nb, float w, float h, float o, float c) {
    position = pos;
    nbParts = nb;
    float headWidth = w;
    float headHeight = h;
    compactness = c;
    orientation = o;
    angularVelocity = 0;
    parts = new ArrayList<TentaclePart>();
    float coul = 255.0/nbParts;
    for (int i = 0; i < nbParts; i++) {
      TentaclePart part = new TentaclePart();
      part.width = (nbParts-i) * headWidth / (float)nbParts;
      part.height = (nbParts-i) * headHeight / (float)nbParts;
      part.position = position.copy();
      part.position.x += compactness * i * cos( orientation );
      part.position.y += compactness * i * sin( orientation );
      part.clr = color(255, 255-coul*i);
      parts.add( part );
    }
  }
  
  void desintegrate() {
    for (TentaclePart p : parts) {
      p.update();
    }
  }
  
  void update() {
    PVector pos0 = parts.get(0).position;
    PVector pos1 = parts.get(1).position;
    pos0.set(position.copy());
    pos1.x = pos0.x + ( compactness * cos( orientation ) );
    pos1.y = pos0.y + ( compactness * sin( orientation ) );
    for (int i = 2; i < nbParts; i++) {
      PVector currentPos = parts.get(i).position.copy();
      PVector dist = PVector.sub( currentPos, parts.get(i-2).position.copy() );
      float distmag = dist.mag();
      PVector pos = parts.get(i - 1).position.copy();
      PVector move = PVector.mult(dist, compactness);
      move.div(distmag);
      pos.add(move);
      parts.get(i).position.set(pos);    
    }
  }
  
  //void draw(int time) {
  //  for (int i = nbParts - 1; i >= 0; i--) {
  //    TentaclePart part = parts.get(i);
  //    noStroke();
  //    fill(part.clr);
  //    ellipse(part.position.x, part.position.y, part.width, part.height);
  //  }
  //}
 
  
  void draw(int time) {
    for (TentaclePart p : parts) {
      if(desintegrating) {
        fill(255);
        ellipse(p.position.x, p.position.y, 3,3);
      } else {
        //stroke(i+time, 0, time);
        stroke(255);
        strokeWeight(2);
        float x1 = p.position.x + (cos(45) * 15);
        float y1 = p.position.y + (sin(45) * 15);
        line(p.position.x, p.position.y, x1, y1);
        
        float x2 = p.position.x + (cos(-45) * 15);
        float y2 = p.position.y + (sin(-45) * 15);
        line(p.position.x, p.position.y, x2, y2);
        
        noStroke();
        //fill(i*7, 0, 20);
        fill(255);
        ellipse(x1, y1, p.width, p.height);
        ellipse(x2, y2, p.width, p.height);
      }
    }
  }
};

class TentaclePart {
  PVector position;
  PVector velocity = new PVector(random(-0.5,0.5), random(-0.5,0.5));
  float width;
  float height;
  color clr;
  
  void update() {
    position.add(velocity);
  }
};