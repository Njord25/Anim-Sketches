var waves = new Array(50);

function setup() {
  createCanvas(window.innerWidth, window.innerHeight);

  for (var i = waves.length - 1; i >= 0; i--) {
  	waves[i] = new Wave(random(200), random(1500), random(16));
  }
}

function draw() {
  background(255);
  for (var i = waves.length - 1; i >= 0; i--) {
  	waves[i].calcWave();
  	waves[i].renderWave();
  }
}

function Wave(_a, _p, _s) {
	var self = this;

	self.xspacing = 16;   // How far apart should each horizontal location be spaced
	self.w = window.innerWidth+16;              // Width of entire wave

	self.theta = 0.0;  // Start angle at 0
	self.amplitude = _a;  // Height of wave
	self.period = _p;  // How many pixels before the wave repeats
	self.dx = (Math.PI*2 / self.period) * self.xspacing;  // Value for incrementing X, a function of period and xspacing
	self.yvalues = new Array(Math.round(self.w/self.xspacing));  // Using an array to store height values for the wave
	self.size = _s;


self.calcWave = function() {
  // Increment theta (try different values for 'angular velocity' here
  self.theta += 0.02;

  // For every x value, calculate a y value with sine function
  var x = self.theta;
  for (var i = 0; i < self.yvalues.length; i++) {
    self.yvalues[i] = Math.sin(x)*self.amplitude;
    x+=self.dx;
  }
}

self.renderWave = function() {
  noStroke();
  fill(0);
  // A simple way to draw the wave with an ellipse at each location
  for (var x = 0; x < self.yvalues.length; x++) {
    ellipse(x*self.xspacing, (height/2-50)+self.yvalues[x], self.size, self.size);
  }
}

}