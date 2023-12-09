class FallingPancake {
  final PVector ACC = {0, 9.8f};
  final float RADIUS = 5.0f;

  PVector pos, vel;

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
  }
  
  private void render() {
    pushMatrix();
    
    translate(pos.x, pos.y);
    fill(PANCAKE_COLOR);
    strokeWeight(2.5);
    stroke(PANCAKE_OUTLINE);
    ellipseMode(RADIUS);
    ellipse(0, 0, RADIUS, RADIUS, 10);
    
    popMatrix();
  }
}