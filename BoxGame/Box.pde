class Box {
  int col, row;
  color bodyColor;
  
  float x, y;
  float targetX, targetY;
  
  boolean isAnimating;

  Box(int col, int row) {
    this.col = col;
    this.row = row;
    
    this.x = col * GRID_SIZE;
    this.y = row * GRID_SIZE;
    
    this.targetX = this.x;
    this.targetY = this.y;
    
    this.isAnimating = false;
    this.bodyColor = color(0, 150, 200);
  }
  
  int getCol() {
    return col;
  }
  
  int getRow() {
    return row;
  }

  void setTargetPosition(int col, int row) {
    if (!isAnimating) {
      this.col = col;
      this.row = row;
      
      this.targetX = col * GRID_SIZE;
      this.targetY = row * GRID_SIZE;
      
      this.isAnimating = true;
    }
  }

  void updatePosition() {
    if (isAnimating) {
      x = lerp(targetX, x, EASING_FACTOR);
      y = lerp(targetY, y, EASING_FACTOR);

      // Check if the animation is finished
      if (abs(targetX - x) < 1 && abs(targetY - y) < 1) {
        x = targetX;
        y = targetY;
        
        isAnimating = false;
      }
    }
  }
  
  void inTarget() {
    // To be implemented
  }

  void display() {
    pushMatrix();
    noStroke();
    fill(bodyColor);
    rect(x, y, GRID_SIZE, GRID_SIZE, 20);
    popMatrix();
  }
}
