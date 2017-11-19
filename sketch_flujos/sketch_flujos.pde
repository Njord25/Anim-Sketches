/* --------Inputs-------- */
// Clic - Resets positions
// R - Repell
// A - Attract
// T - Tremble
// W - Wave
// E - Inner circle motion
// C - Circular motion 
// L - Outer circle motion
// F - Fall
// I - Invert (Inverts flow and effects)
// S - Stops spiral effect

/* --------Spout-------- */
//import spout.*;
//PGraphics pgr; 
//Spout spout;

ArrayList<Particle> particles = new ArrayList<Particle>();
int particleNum = 5000;

float magnetRadius = 100;
float rippleRadius = 0;
float equatorRadius = 400;
float domeRadius = 450;

float noiseOndulation = 200;
float noiseVariation = 1000;
float noiseInterval = 250;
float noiseResistance = 1000;

int maxTrembleTime = 20;
int particleSpiral = 0;

Boolean ripple = false;
Boolean vortex = false;
Boolean inverted = false;
Boolean falling = false;
Boolean rotating = false;
Boolean innerCircle = false;
Boolean outerCircle = false;
Boolean initializing = false;

ArrayList<PVector> emitters = new ArrayList<PVector>();


void setup() {
  size(1000, 1000, P2D); 
  /* --------Spout-------- */
  //pgr = createGraphics(1000, 1000, P2D);
  
  for(int i=0; i<particleNum; i++) {
    particles.add(new Particle(domeRadius * cos(0) + width/2, domeRadius * sin(0) + height/2, random(0.5, 2), random(0.05, 0.1), i));
  }
  colorMode(HSB, 360, 100, 100);
  
  for (Particle p : particles) {
    falling = false;
    p.stopped = false;
    p.pos.x = random(width);
    p.pos.y = random(height);
  }
  
  /* --------Spout-------- */
  //spout = new Spout(this); 
  //spout.createSender("Spout Processing");
}


void draw() {
  
  /* --------Single particle-------- */
  background(0);
  /* --------Tracing-------- */
  //fill(0,30);
  //rect(0,0,width,height);
  
  for(PVector e : emitters) {
    particles.add(new Particle(e.x, e.y, random(2, 5), random(0.1, 0.5), frameCount));
  }
  
  for (Particle p : particles) {
    if(p.attracting || p.repelling) p.magnet(mouseX, mouseY, magnetRadius, 10);
    if(p.flowing) p.flow();
    if(p.trembling) p.tremble();
    if(falling) p.fall();
    
    if(initializing && particleSpiral > particleNum - 10) {
      initializing = false;
      p.flowing = true;
    } 
    
    if(millis()%((p.index*5)+1)==0 && !p.start) {
      p.start = true;
    }
    
    if(outerCircle) {
      p.flowing = false;
      p.repelling = true;
      p.magnet(width/2, height/2, equatorRadius, 10);
      p.circleRotation(equatorRadius);  
    } else {
      p.flowing = true;
    }

    if(rotating) {
      p.flowing = false;
      p.circleRotation(p.distanceFromCenter);
    } else {
      p.flowing = true;
    }
    
    if(ripple) {
      p.ripple();
    } else {
      p.rippling = false;
      p.ripplingSize = 0;
    }
    
    if(innerCircle) {
      p.flowing = false;
      p.circleRotation(equatorRadius);
    }
    
    if(initializing) {
      //p.emit();
      p.run();
      initializing = false;
    }
    p.run();
  }
  
  if(ripple) {
    rippleRadius += 5;
    if(rippleRadius > domeRadius) ripple = false;
  }
  
  /* --------Image Sequence-------- */
  //saveFrame("image-###.jpg");
  
  /* --------Spout-------- */
  //spout.sendTexture();
}


void mousePressed() {
  for (Particle p : particles) {
    falling = false;
    p.stopped = false;
    p.pos.x = random(width);
    p.pos.y = random(height);
  }
  //PVector mPos = new PVector(mouseX, mouseY);
  //emitters.add(mPos);
}

void keyPressed() {
  if(key == 'R' || key == 'r') {
    for(Particle p : particles) {
      p.attracting = false;
      p.repelling = !p.repelling;
      if(!p.repelling) p.flowing = true;
    }
  }
  
  if(key == 'a' || key == 'A') {
    for(Particle p : particles) {
      p.repelling = false;
      p.attracting = !p.attracting;
      if(!p.attracting) p.flowing = true;
    }
  }
  
  if(key == 't' || key == 'T') {
    for(Particle p : particles) {
      p.trembling = true;
    }
  }  
  
  if(key == 'i' || key == 'I') {
    inverted = !inverted;
  }
    
  if(key == 'f' || key == 'F') {
    falling = !falling;
    for(Particle p : particles) {
      if(!falling) {
        p.stopped = false; 
        p.repelling = false;
      }
    }
  } 
  
  if(key == 'w' || key == 'W') {
    ripple = true;
    rippleRadius = 10;
  } 
  
  if(key == 'l' || key == 'L') {
    outerCircle = !outerCircle;
    if(!outerCircle) {
      for(Particle p : particles) {
        p.repelling = false;
        p.flowing = true;
      }
    }
  } 
  
  if(key == 'C' || key == 'c') {
    rotating = !rotating;
    if(rotating) {
      for(Particle p : particles) {
        p.distanceFromCenter = dist(width/2, height/2, p.pos.x, p.pos.y);
        p.angle = atan2(p.pos.y - height/2, p.pos.x - width/2);
        p.angleIncrement = random(0.005, 0.05);
      }
    }
  }
  
  if(key == 'e' || key == 'E') {
    innerCircle = !innerCircle;
    if(innerCircle) {
      for(Particle p : particles) {
        p.angle = atan2(p.pos.y - height/2, p.pos.x - width/2);
      }
    }
  } 
  
  if(key == 's' || key == 'S') {
    initializing = false;
    for(Particle p : particles) {
      p.flowing = true;
    }
  } 
  
  if(key == 'v' || key == 'V') {
    vortex = !vortex;
    if(vortex) {
        for(Particle p : particles) {
        p.angle = random(0,628) * 0.1;
        p.vortexCenter = new PVector(mouseX, mouseY);
      }
    }
  } 
}