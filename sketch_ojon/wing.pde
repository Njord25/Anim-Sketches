class Wing {

  Points[] P = new Points[50];
  int len = 2;
  PVector pos;
  float angle;
  float head;

  Wing(float _a, float _h) {
    angle = _a;
    head = _h;
    pos = new PVector(cos(angle), sin(angle));
     for (int i=0;i<P.length;i++) {
      P[i] = new Points();
    }
  }

  void run(PVector _p) {
    pos.x = _p.x + cos(angle)*head/2;
    pos.y = _p.y + sin(angle)*head/2;
    display();
  }

  void display() {
    P[0].move(pos.x, pos.y);
    P[0].displayHead();
    
    for (int i=1;i<P.length;i++) {
      float t = atan2(P[i].y-P[i-1].y, P[i].x-P[i-1].x);
      float sx = P[i-1].x + len*cos(t);
      float sy = P[i-1].y + len*sin(t);
      sx+=0.2; // for fluidic motion
      sy+=0.5; // for fluidic motion
      P[i].move(sx, sy);
      P[i].display();
      stroke(0, 150, 255, 65);
      line(P[i].x, P[i].y, P[i-1].x, P[i-1].y);
    }
  }


class Points {
  float x=0, y=0; 
  void displayHead() {
    stroke(0, 150, 255);
    strokeWeight(2);
    fill(0, 150, 255, 65);
    ellipse(x,y,10,10);
    fill(0, 150, 255, 65);
    noStroke();
    ellipse(x, y, 5, 5);
  }
  void display() {
    fill(0, 150, 255, 65);
    noStroke();
    ellipse(x, y, 5, 5);
  }
  void move(float x, float y) {
    this.x = x; 
    this.y = y;
  }
}

}