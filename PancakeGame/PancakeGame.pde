final color SKY_BLUE = color(195, 238, 250);
final color PASTEL_RED = color(220, 180, 200);

final color PANCAKE_COLOR = color(247,215,136);

final float PLAYER_WIDTH = 100;
final float PANCAKE_WIDTH = 110;

Pan player;
Pancake cakes;

// ----------------------------------------------------------

void setup() {
    size(1000, 600, P2D);
    loadPixels();
    player = new Pan(PLAYER_WIDTH);
    cakes = new Pancake(player, PANCAKE_WIDTH);
}

void draw() {
    fillGradient(SKY_BLUE, PASTEL_RED);
    player.update();
    cakes.update();
}

void mousePressed() {
    cakes.addChild();
}

// ----------------------------------------------------------

void fillGradient(color c1, color c2) {
    /* 
     *  This function draws a vertical linear gradient
     *  (from top to bottom) with the given two colors.
     */

    for (int y = 0; y < height; y++) {
        float percent = (float) y / height;
        color c = lerpColor(c1, c2, percent);

        for (int x = 0; x < width; x++) {
            pixels[y * width + x] = c;
        }
    }

    updatePixels();
}