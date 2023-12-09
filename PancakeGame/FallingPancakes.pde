class FallingPancakes {
  ArrayList<FallingPancake> fallingPancakes;

  FallingPancakes(int numOfPancakes) {
    fallingPancakes = new ArrayList<FallingPancake>();

    for (int i = 0; i < numOfPancakes; i++) {
      fallingPancakes.add(new FallingPancake());
    }
  }

  void update() {
    if (fallingPancakes.size() == 0) {
      return;
    }

    for (FallingPancake pancake : fallingPancakes) {
      pancake.update();
    }
  }

  void addPancake() {
    fallingPancakes.add(new FallingPancake());
  }
}