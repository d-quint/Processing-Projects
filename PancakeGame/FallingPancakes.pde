class FallingPancakes {
  ArrayList<FallingPancake> fallingPancakes;

  FallingPancakes() {
    fallingPancakes = new ArrayList<FallingPancake>();
  }

  void renderAll() {
    if (fallingPancakes.size() == 0) {
      return;
    }

    for (FallingPancake pancake : fallingPancakes) {
      pancake.update();
    }
  }
}