class Hongo {
  
  float horizon;
  PVector pos;
  float step = 10;
  float len;
  float angle = 0;
  float amplitude;
  float period;
  float dx;
  Float[] points;
  float radius;
  float radiusPos;
  float neck;
  float neckPos;
  float base;
  float vel = 0.1;

  Hongo(float _x, float _l, float _a, float _p, float _r, float _rp, float _n, float _np, float _b) {
    len = _l;
    pos = new PVector(_x, height - len);
    amplitude = _a;
    period = _p;
    dx = (TWO_PI / period) * step;
    points = new Float[int(len / step)];
    radius = _r;
    radiusPos = _rp /* * 100 / len */;
    neck = _n;
    neckPos = _np /* * 100 / len */;
    base = _b;
    horizon = height;
  }
  
  void update() {
    angle += 0.02;
    float x = angle;
    
    for (int i=0; i<points.length; i++) {
      points[i] = sin(x) * amplitude;
      x += dx;
    }
  }
  
  void display() {
    for(int i=0; i<points.length; i++) {
      float posY = pos.y + (i * step);
      float w = getWidth(posY - pos.y);
      noFill();
      stroke(255);
      strokeWeight(2);
      ellipseMode(CENTER);
      ellipse(pos.x + points[i], posY /*+ vel * millis()*/, w, getHeight(posY, w));
    }
  }
  
  void run() {
    update();
    display();
  }
  
  float getWidth(float _y) {
    float w;
    
    if(_y < radiusPos) {
      w = map(_y, 0, radiusPos, 10, radius);
    } else if (_y < neckPos) {
      w = map(_y, radiusPos, neckPos, radius, neck);
    } else {
      w = map(_y, neckPos, pos.y + len, neck, base);
    }  
    return w;
  }
  
  float getHeight(float _y, float _max) {
    float d = abs(horizon - _y);
    float h = d/2 < _max/2 ? d/2 : _max/2;
    return h;
  }
}