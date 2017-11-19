class Jellyfish {
  
  PVector position;
  float radX, radY;
  float orientation;
  float angleIncrement = 0.01;
  
  color headClr;
  
  ArrayList<Tentacle> tentacles;
  int nbTentacles;
  int tentaclesLength;
  
  int moveTime;
  int moveDuration;
  PVector dest;
  PVector lastPos;
  float moveDistance;
  boolean reachedDest;
  boolean rotating;
  boolean desintegrating = false;
  
  Jellyfish(PVector pos, float rx, float ry, int nb, int l, float ts, float td) {
  
    position = pos;
    radX = rx;
    radY = ry;
    orientation = 0;
  
    nbTentacles = nb;
    tentaclesLength = l;
    tentacles = new ArrayList<Tentacle>();
  
    headClr = color(random(50,200), random(50,200), random(50,200));
  
    dest = new PVector(random(-1,1), random(-1,1));
    dest.mult(moveDistance);
    lastPos = position.copy();
    moveDuration = int(random(80,150));
    moveDistance = random(100,600);
    reachedDest = true;
    rotating = true;
    moveTime = 0;
  
  
    for (int i = 0; i < nbTentacles; i++) {
      float tx = position.x + (cos(i * TWO_PI / nbTentacles) * radX/2);
      float ty = position.y + (sin(i * TWO_PI / nbTentacles) * radY/2);
      float tr = atan2(ty - position.y, tx - position.x);
      Tentacle tentacle = new Tentacle(new PVector(tx, ty), tentaclesLength, ts, ts, tr, td);
      tentacles.add(tentacle);
    }
  }
  
  void update() {
    moveDistance = random(100,600);
    for (int i = 0; i < nbTentacles; i++) {
      Tentacle t = tentacles.get(i);
      if(desintegrating) {
        t.desintegrating = true;
        t.desintegrate();
      } else {
        t.position.x = position.x + (cos((i * TWO_PI / nbTentacles) + orientation) * radX/2);
        t.position.y = position.y + (sin((i * TWO_PI / nbTentacles) + orientation) * radY/2);
        t.orientation = rotating ? t.orientation += angleIncrement : atan2((t.position.y - position.y), (t.position.x - position.x));
        t.update();
      }
    }
  
    if(reachedDest) {    
      lastPos = position.copy();
      dest = new PVector(random(-1,1), random(-1,1));
      dest.normalize();
      dest.mult(moveDistance);
      moveDuration = int(dest.mag());
  
      PVector nextPos = PVector.add(position, dest);
      if(nextPos.x > width) dest.x = -abs(dest.x);
      else if(nextPos.x < 0) dest.x = abs(dest.x);
      if(nextPos.y  > height) dest.y = -abs(dest.y);
      else if(nextPos.y < 0) dest.y = abs(dest.y);
      reachedDest = false;
      moveTime = 0;
    } else {
      position.x = Penner.easeInOutBack(moveTime, lastPos.x, dest.x, moveDuration);
      position.y = Penner.easeInOutBack(moveTime, lastPos.y, dest.y, moveDuration);
      moveTime++;
      if(moveTime >= moveDuration - 10)
        reachedDest = true;
    }
   
    fill(200/*headClr*/);
    for(Tentacle t : tentacles) {
      t.draw(moveTime);
    }
  }
};