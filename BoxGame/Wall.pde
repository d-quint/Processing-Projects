class Wall {
  int col, row;
  float x, y;

  Wall(int col, int row) {
    this.col = col;
    this.row = row;
    
    this.x = col * GRID_SIZE;
    this.y = row * GRID_SIZE;
  }
  
  int getCol() {
    return col;
  }
  
  int getRow() {
    return row;
  }
  
  void display() {
    fill(220, 150, 200);
    rect(x, y, GRID_SIZE, GRID_SIZE);
  }
}
