ArrayList<Pendulum> swings;

color c1;
float angle = 0;
int count = 0;

int gifFrameCount = 0;
int desiredFrameCount = 100;

void setup() {
  size(400, 400, P2D);
  swings = new ArrayList<Pendulum>();
  
  colorMode(HSB, 360, 100, 100);
  c1 = color(0, 100, 80);
}

void draw() {
  background(0);
  
  addSwing();
  shiftHue();
  
  for (Pendulum swing : swings) {
    swing.update();
  }
  
  // render();
}

void shiftHue() {
  // Shift the hue of the color
  c1 = color((hue(c1) + 1.5) % 360, saturation(c1), brightness(c1));
}

void addSwing() {
  for (int i = 0; i < 100; i++) {
    count++;
    
    if (count == 1178 && swings.size() < 16) {
      swings.add(new Pendulum(angle, 300, c1));
      angle += HALF_PI * 0.125;
      
      count = 0;
    }   
  }
}

void render() {
  // For rendering into GIF purposes, do not run unless you really want to
  
  if (frameCount >= 377 && frameCount < 377 * 2) {
    saveFrame("frames/gif-" + gifFrameCount + ".jpg");
    
    gifFrameCount++;
  }
  
  if (frameCount == 377 * 2) {
    exit();
  }
}

