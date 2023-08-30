import processing.sound.SoundFile;

SoundFile sfx_sweep, sfx_win, sfx_tap, sfx_bgm;

final int GRID_SIZE = 60;
final float EASING_FACTOR = 0.8f;

int numRows, numCols;
BoxManager boxManager;

void setup() {
  size(600, 600, P2D);
  numRows = height / GRID_SIZE;
  numCols = width / GRID_SIZE;
  boxManager = new BoxManager();
  
  loadSfx();
}

void draw() {
  background(240);
  drawGrid();
  boxManager.updatePositions();
  boxManager.display();
}

void mousePressed() {
  sfx_tap.play();

  if (mouseButton == LEFT)
    boxManager.addBox(new Box(mouseX / GRID_SIZE, mouseY / GRID_SIZE));
    
  if (mouseButton == RIGHT)
    boxManager.addWall(new Wall(mouseX / GRID_SIZE, mouseY / GRID_SIZE));
    
  if (mouseButton == CENTER)
    boxManager.addTarget(new Target(mouseX / GRID_SIZE, mouseY / GRID_SIZE));
}

void drawGrid() {
  stroke(200);
  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      float x = col * GRID_SIZE;
      float y = row * GRID_SIZE;
      noFill();
      rect(x, y, GRID_SIZE, GRID_SIZE);
    }
  }
}

void keyPressed() {
  if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT) {
    boxManager.setTargetPositions(keyCode);
  }
}

void loadSfx() {
  sfx_sweep = new SoundFile(this, "assets/sfx/sweep.wav");
  sfx_win = new SoundFile(this, "assets/sfx/win.wav");
  sfx_tap = new SoundFile(this, "assets/sfx/tap.wav");
  sfx_bgm = new SoundFile(this, "assets/sfx/level_music.mp3");

  sfx_bgm.loop();
}
