function Fish(x, y, s, v, c, a) {

    var self = this;

    self.size = s;
    self.pos = new p5.Vector(x, y);
    self.vel = new p5.Vector(0, 0);
    self.acc = a;
    self.history = [];

    self.maxvel = v;
    self.maxforce = 1;

    self.run = function(boids) {
        self.flock(boids);
        self.update();
        self.checkEdges();
        self.display();
    }

    self.update = function() {
        self.vel.add(self.acc);
        self.vel.limit(self.maxvel);
        self.pos.add(self.vel);

        self.acc.mult(0);

        var hv = createVector(self.pos.x, self.pos.y);
        self.history.push(hv);
        if (self.history.length > 20) {
            self.history.splice(0, 1);
        }
    }

    self.display = function() {
        noStroke();
        fill(c);
        ellipse(self.pos.x, self.pos.y, self.size, self.size);
        fill(c);
        for (var i = 0; i < self.history.length; i++) {
            ellipse(self.history[i].x, self.history[i].y, (self.size / 2) + i, (self.size / 2) + i);
        }
    }

    self.applyForce = function(force) {
        self.acc.add(force);
    }

    self.flock = function(boids) {
        var sep = self.separate(boids);
        var ali = self.align(boids);
        var coh = self.cohesion(boids);
        sep.mult(1.5);
        ali.mult(1.0);
        coh.mult(1.0);
        self.applyForce(sep);
        self.applyForce(ali);
        self.applyForce(coh);
    }

    self.seek = function(target) {
        var desired = p5.Vector.sub(target, self.pos);
        desired.normalize();
        desired.mult(self.maxvel);
        var steer = p5.Vector.sub(desired, self.vel);
        steer.limit(self.maxforce);
        return steer;
    }

    self.separate = function(boids) {
        var desiredseparation = 25.0;
        var steer = new p5.Vector(0,0,0);
        var count = 0;

        for (var other of boids) {
            var d = p5.Vector.dist(self.pos, other.pos);

            if ((d > 0) && (d < desiredseparation)) {
                var diff = p5.Vector.sub(self.pos, other.pos);
                diff.normalize();
                diff.div(d);
                steer.add(diff);
                count++;
            }
        }

        if (count > 0) {
            steer.div(count);
        }

        if (steer.mag() > 0) {
            steer.normalize();
            steer.mult(self.maxvel);
            steer.sub(self.vel);
            steer.limit(self.maxforce);
        }

        return steer;
    }

    self.align = function(boids) {
        var neighbordist = 50;
        var sum = new p5.Vector(0,0);
        var count = 0;

        for (var other of boids) {
            var d = p5.Vector.dist(self.pos, other.pos);
            if ((d > 0) && (d < neighbordist)) {
                sum.add(other.vel);
                count++;
            }
        }

        if (count > 0) {
            sum.div(count);
            sum.normalize();
            sum.mult(self.maxvel);
            var steer = p5.Vector.sub(sum, self.vel);
            steer.limit(self.maxforce);
            return steer;
        } else {
            return new p5.Vector(0,0);
        }
    }

    self.cohesion = function(boids) {
        var neighbordist = 50;
        var sum = new p5.Vector(0,0);
        var count = 0;

        for (var other of boids) {
            var d = p5.Vector.dist(self.pos, other.pos);

            if ((d > 0) && (d < neighbordist)) {
                sum.add(other.pos);
                count++;
            }
        }

        if (count > 0) {
            sum.div(count);
            return self.seek(sum);
        } else {
            return new p5.Vector(0,0);
        }
    }

    self.checkEdges = function() {
        if (self.pos.x > width - s) {
            self.pos.x = width - s;
            self.vel.x *= -1;
        } else if (self.pos.x < s) {
            self.vel.x *= -1;
            self.pos.x = s;
        }
     
        if (self.pos.y > height - s) {
            self.vel.y *= -1;
            self.pos.y = height - s;
        } else if (self.pos.y < s) {
            self.vel.y *= -1;
            self.pos.y = s;
        }
    }
}

