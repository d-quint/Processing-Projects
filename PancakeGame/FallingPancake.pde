class FallingPancake {
  final PVector ACC = new PVector(0.f, 0.98f);
  final float CAKE_RADIUS = PANCAKE_WIDTH * 0.5f;
  final float BELOW_HEIGHT = 50.f;

  PVector pos, vel;

  FallingPancake() {
    this.pos = new PVector(random(width), random(-100, 0));
    this.vel = new PVector(random(0, 5), random(0, 5));
  }

  FallingPancake(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }

  void update() {
    move();
    render();
  }
  
  private void move() {
    this.vel = vel.add(ACC);
    this.pos = pos.add(vel);

    if (pos.y >= height + BELOW_HEIGHT) {
      this.pos = new PVector(random(width), random(-1000, 0));
      this.vel = new PVector(random(0, 5), random(0, 5));
    }
  }
  
  private void render() {
    pushMatrix();
    
    translate(pos.x, pos.y);
    fill(PANCAKE_COLOR);
    strokeWeight(2.5);
    stroke(PANCAKE_OUTLINE);
    ellipseMode(RADIUS);
    ellipse(0.f, 0.f, CAKE_RADIUS, CAKE_RADIUS);
    
    popMatrix();
  }
}