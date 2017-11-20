class Plant {
  
  ArrayList branches = new ArrayList();
  PVector pos;
  int maxSize = 65;
  int numBranches;
  int opacity = 255;
  float scale;

  Plant(int _numBranches, float _x, float _y) {
    numBranches = _numBranches;
    pos = new PVector(_x, _y);
    scale = map(pos.y, height-offy, height, 0.3, 1);
    opacity = int(map(pos.y, height-offy, height, 100, 255));
    
    for(int i = 0; i < numBranches; i++) {
      branches.add(new Branch());
    }
  }
  
  void display() {
    stroke(255, opacity);
    fill(255);
    for(int i = 0; i < branches.size(); i++){
      Branch b = (Branch) branches.get(i);
      pushMatrix();
      translate(pos.x, pos.y);
      scale(scale);
      rotate(radians(b.startAngle));
      b.branch(b.segments);
      popMatrix();
    }  
  }
}


class Branch {
  float segments, startAngle, angle, theta, num;
  
  Branch() {
    segments = random(70, 100);
    startAngle = random(-55, 55);
    angle = map(startAngle, -90, 90, -10, 10);
  }
  
  void branch(float len){
    len *= 0.75;
    float t = map(len, 1, 70, 1, 7);
    theta = angle + sin(len+num) * 5;
    strokeWeight(t);
    line(0, 0, 0, -len);
    //ellipse(0, 0, t, t);
    
    if(len<30) {
      float t2 = map(len, 1, 70, 1, 5);
      strokeWeight(t2);
      line(0 + (cos(PI/4) * (5 + t)), -len + (sin(PI/4) * (5+t)), (cos(PI/4) * (15+t)), (sin(PI/4) * (15+t)) - len);
      line(0 + (cos(PI*0.75) * (5 + t)), -len + (sin(PI*0.75) * (5+t)), (cos(PI*0.75) * (15+t)), (sin(PI*0.75) * (15+t)) - len);
    }
    
    translate(0, -len);
    if(len > 5) {
      pushMatrix();
      rotate(radians(-theta));
      branch(len);
      popMatrix(); 
    }
    num += 0.003;
  }
}