class BoxManager {
  ArrayList<Box> boxes;
  ArrayList<Wall> walls;
  ArrayList<Target> targets;
  
  boolean isAnimating;

  BoxManager() {
    boxes = new ArrayList<Box>();
    walls = new ArrayList<Wall>();
    targets = new ArrayList<Target>();
    
    isAnimating = false;
  }

  void addBox(Box box) {
    boxes.add(box);
  }
  
  void addWall(Wall wall) {
    walls.add(wall);
  }
  
  void addTarget(Target target) {
    targets.add(target);
  }

  void setTargetPositions(int keyCode) {
    if (!isAnimating) {
      boolean wasValid = false;
      isAnimating = true;

      for (Box box : boxes) {
        int newRow = box.row;
        int newCol = box.col;

        if (keyCode == UP) {
          newRow--;
        } else if (keyCode == DOWN) {
          newRow++;
        } else if (keyCode == LEFT) {
          newCol--;
        } else if (keyCode == RIGHT) {
          newCol++;
        }

        // If the target tile is valid, move the box there
        if (isValidPosition(newRow, newCol, box)) {
          box.setTargetPosition(newCol, newRow);
          wasValid = true;
        }
      }
      
      if (wasValid) {
        sfx_sweep.play();
      } else {
        sfx_tap.play(); 
      }
      
      // If all boxes are in targets, the game is finished
      if (checkGameState()) {
        gameFinish();
      }
    }
  }
  
  boolean checkGameState() {
    if (targets.size() != boxes.size()) {
      return false;
    }
    
    int count = 0; // Counts how many boxes are in targets
    
    for (Box box : boxes) {
      for (Target target : targets) {
        if (box.getRow() == target.getRow() && box.getCol() == target.getCol()) {
          count++;
          box.inTarget();
          break;
        }
      }
    }
    
    return count == targets.size(); 
  }

  void updatePositions() {
    boolean allFinished = true;
    
    for (Box box : boxes) {
      box.updatePosition();

      // If any box is still animating, it is not finished
      if (box.isAnimating) {
        allFinished = false;
      }
    }
    
    if (allFinished) {
      isAnimating = false;
    }
  }

  void display() {
    for (Box box : boxes) {
      box.display();
    }
    for (Wall wall : walls) {
      wall.display();
    }
    for (Target target : targets) {
      target.display();
    }
  }

  boolean isValidPosition(int row, int col, Box box) {
    // Recursively check if adjacent boxes can move in the same direction
    for (Box nextBox : boxes) {
      if (nextBox.getCol() == col && nextBox.getRow() == row) {
        if (box.getCol() == nextBox.getCol() && box.getRow() < nextBox.getRow()) {
          return isValidPosition(row + 1, col, nextBox);
        } else if (box.getCol() == nextBox.getCol() && box.getRow() > nextBox.getRow()) {
          return isValidPosition(row - 1, col, nextBox);
        } else if (box.getRow() == nextBox.getRow() && box.getCol() < nextBox.getCol()) {
          return isValidPosition(row, col + 1, nextBox);
        } else if (box.getRow() == nextBox.getRow() && box.getCol() > nextBox.getCol()) {
          return isValidPosition(row, col - 1, nextBox);
        } 
      }
    }
    
    // Check for adjacent walls
    for (Wall wall : walls) {
      if (wall.getCol() == col && wall.getRow() == row) {
        return false;
      }
    }
    
    // Check for boundary
    return row >= 0 && row < numRows && col >= 0 && col < numCols;
  }
  
  void gameFinish() {
    sfx_bgm.stop();
    sfx_win.play();
    println("Game finished!");
  }
}
