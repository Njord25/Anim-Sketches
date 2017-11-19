function preload() {
}

var plants = new Array(25);
var flock = new Flock();

function setup() {
    createCanvas(windowWidth-3, windowHeight-3);

    for (var i=0; i<plants.length; i++) {
    	plants[i] = new Plant(getRandomInt(0, windowWidth), getRandomInt(200, 700), getRandomInt(20, 40), Math.random() * (0.5 - 0.05));
    }

    for (var i=0; i<74; i++) {	
    	var myAngle = random(-360, 360);
        var acc = p5.Vector.fromAngle(radians(myAngle));
    	var b = new Fish(getRandomInt(0, windowWidth), getRandomInt(0, windowHeight), getRandomInt(3, 10), getRandomInt(2, 4), color(getRandomInt(0, 50), 50, 50), acc);
    	flock.addBoid(b);
    }
}

function draw() {
	clear();

	flock.runFirst();

	for (var i = plants.length -1; i >= 0; i--) {
		plants[i].move();
	}

	flock.runSec();
}

function getRandomInt(min, max) {
	return Math.floor(Math.random() * (max - min)) + min;
}

function Plant(x, h, a, v) {
	var self = this;
	self.location = new p5.Vector(x, windowHeight-h);
	self.height = h;

	self.startAngle = 0;
	self.angleVel = v;
	self.amplitud = a;

	self.move = function() {

		self.startAngle += 0.02;
		self.angle = self.startAngle;

	  	for (var y = self.location.y; y <= self.location.y + self.height; y += 24) {
		    var x = map(sin(self.angle), -1, 1, 0, self.amplitud) + self.location.x;
		    var x2 = map(sin(self.angle + self.angleVel), -1, 1, 0, self.amplitud) + self.location.x;
		    stroke('#2D9C36');
		    strokeWeight(25);
		    line(x,y,x2,y+24);
		    self.angle += self.angleVel;
	  	}
	}
}

function Flock() {

    var self = this;

    self.boids = [];

    self.runFirst = function() {
    	for (var i = 0; i < self.boids.length / 2; i++) {
    		self.boids[i].run(self.boids);
    	}
    }

    self.runSec = function() {
    	for (var i = self.boids.length / 2; i < self.boids.length; i++) {
    		self.boids[i].run(self.boids);
    	}
    }

    self.addBoid = function(b) {
        self.boids.push(b);
    }
}
