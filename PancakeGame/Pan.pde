final int OFFSET = 50;
final float EASING_FACTOR = 0.925f;

class Pan {
  float bodyWidth, thickness;
  PVector pos, target;
  
  Pancake head;
  
  Pan(float bodyWidth) {
    this.bodyWidth = bodyWidth;
    this.thickness = 20.0f;
    
    this.pos = new PVector(width * 0.5f, height - OFFSET);
    this.target = new PVector(mouseX, mouseY);
  }
  
  void update() {
    move();
    render();
  }
  
  PVector getPos() {
    return this.pos;
  }
  
  float getThickness() {
    return this.thickness;
  }
  
  private void move() {
    float halfWidth = bodyWidth * 0.5f;
    target = new PVector(mouseX, mouseY);
    
    // If a side touches an edge and the target isn't inward, don't move any further
    if (pos.x - halfWidth <= 0) {
      if (target.x - pos.x <= 0) {
        pos.x = halfWidth;
        return;
      }
    } else if (pos.x + halfWidth >= width) {
      if (target.x - pos.x >= 0) {
        pos.x = width - halfWidth;
        return;
      }
    }
    
    pos.x = lerp(target.x, pos.x, EASING_FACTOR);
  }
  
  private void render() {
    pushMatrix();
    
    translate(pos.x, pos.y);
    fill(PLAYER_COLOR);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, bodyWidth, thickness, 5);
    
    popMatrix();
  }
}
