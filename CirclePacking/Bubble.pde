class Bubble {
    float x, y, r, rVel, rAcc;
    boolean isGrowing;
    boolean hasFill;

    color bodyColor;
    color baseColor, maxColor;

    public Bubble(float x, float y, float r) {
        this.x = x;
        this.y = y;
        this.r = r;

        rAcc = 0.01f;
        rVel = 1;

        baseColor = color(97, 255, 97, random(100, 255));
        maxColor = color(253, 28, 73);

        hasFill = random(1) > 0.5f;

        bodyColor = baseColor;

        isGrowing = true;
    }

    public void display() {
        if (hasFill) {
            fill(bodyColor);
        } else {
            noFill();
        }

        stroke(bodyColor);
        ellipseMode(RADIUS);
        ellipse(x, y, r, r);
    }

    public void grow() {
        if (isGrowing) {
            rVel += rAcc;
            r += rVel;

            updateColor();
        }
    }

    public void updateColor() {
        float rRatio = r * 0.02f;

        float rColor = red(baseColor) + (red(maxColor) - red(baseColor)) * rRatio;
        float gColor = green(baseColor) + (green(maxColor) - green(baseColor)) * rRatio;
        float bColor = blue(baseColor) + (blue(maxColor) - blue(baseColor)) * rRatio;
        float aColor = alpha(baseColor);

        bodyColor = color(rColor, gColor, bColor, aColor);
    }

    public void stopGrowing() {
        isGrowing = false;
    }

    public void checkCollision(Bubble other) {
        if (!isGrowing) {
            return;
        }

        if (isTouchingEdge()) {
            this.stopGrowing();
        }

        if (isTouchingBubble(other)) {
            this.stopGrowing();
            other.stopGrowing();
        }
    }

    public void checkCollision() {
        if (!isGrowing) {
            return;
        }

        if (isTouchingEdge()) {
            this.stopGrowing();
        }
    }

    public boolean isTouchingBubble(Bubble other) {
        float d = dist(x, y, other.x, other.y);

        return (d < r + other.r);
    }

    public boolean isTouchingEdge() {
        return (x + r > width || x - r < 0 || y + r > height || y - r < 0);
    }
}
