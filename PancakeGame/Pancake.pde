final float PANCAKE_EASING_FACTOR = 0.25f;

class Pancake {
  float bodyWidth, thickness;
  PVector pos, target;
  
  Pancake parent, child;
  Pan plate;
  
  Pancake(Pan plate, float bodyWidth) {
    this.plate = plate;
    
    this.bodyWidth = bodyWidth;
    this.thickness = 15.0f;
    
    float totalOffset = OFFSET + ((plate.getThickness() + this.thickness) * 0.5f);
    
    this.pos = new PVector(width * 0.5f, height - totalOffset);
    this.target = new PVector(mouseX, mouseY);
    
    this.parent = this.child = null;
  }
  
  void addChild() {
    if (child == null) {
      this.child = new Pancake(plate, bodyWidth + 2.0f);
      this.child.setParent(this);
    } else {
      child.addChild();
    }
  }
  
  void setParent(Pancake parent) {
    this.parent = parent;
    this.pos.y = this.parent.getPos().y - thickness;
  }
  
  PVector getPos() {
    return this.pos; 
  }
  
  void update() {
    move();
    render();
    
    if (child != null) {
      child.update();
    }
  }
  
  private void move() {
    float halfWidth = bodyWidth * 0.5f;
    target = (parent != null ? parent.getPos() : plate.getPos());
    
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
    
    pos.x = lerp(target.x, pos.x, PANCAKE_EASING_FACTOR);
  }
  
  private void render() {
    pushMatrix();
    
    translate(pos.x, pos.y);
    fill(PANCAKE_COLOR);
    strokeWeight(2.5);
    stroke(PANCAKE_OUTLINE);
    rectMode(CENTER);
    rect(0, 0, bodyWidth, thickness, 10);
    
    popMatrix();
  }
}
