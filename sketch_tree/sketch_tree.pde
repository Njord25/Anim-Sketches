ArrayList<Tree> trees = new ArrayList<Tree>();
int numTrees = 5;

Boolean wind = false;

void setup() {
  size(1000, 1000);
  
  for(int i=0; i<numTrees; i++) {
    trees.add(new Tree(random(width)));
  }
}

void draw() {
  background(0);
  
  for(Tree t : trees) {
    t.display();
  }
}

void mousePressed() {
  wind = !wind;
}