class Target extends Wall {
   Target(int col, int row) {
      super(col, row);
   }
   
   @Override
   void display() {
     fill(201, 230, 192, 200);
     rect(x, y, GRID_SIZE, GRID_SIZE);
   }
}
