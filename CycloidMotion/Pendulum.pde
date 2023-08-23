class Pendulum {
    PVector position; // Position of ball in the canvas
    color ballColor; // Color of the ball

    int time; // Time elapsed since the start of the pendulum simulation
    float percent; // Value from 0 to 1 that denotes its position in the "pendulum"
    float rotation; // Angle of rotation of the "pendulum" in radians
    PVector ep_1, ep_2; // Endpoints of the "pendulum"

    final PVector ANCHOR_POS = new PVector(width * 0.5, height * 0.5);
    final float DEF_RADIUS = 10.0f;

    Pendulum(float rotation, float length) {
        initEndpoints(rotation, length);

        this.rotation = rotation;
        this.position = getBallPosition();
        this.ballColor = color(255);
    }

    Pendulum(float rotation, float length, color ballColor) {
        initEndpoints(rotation, length);

        this.rotation = rotation;
        this.position = getBallPosition();
        this.ballColor = ballColor;
    }

    void initEndpoints(float rotation, float length) {
        // Note: length is in pixels (px)
        float r = length * 0.5;
        float theta = rotation;

        // Simple polar to xy-plane transformation
        float x1 = r * cos(theta);
        float y1 = r * sin(theta);

        float x2 = -1 * r * cos(theta);
        float y2 = -1 * r * sin(theta);

        // Initialize endpoints with computed values
        ep_1 = new PVector(x1, y1).add(ANCHOR_POS);
        ep_2 = new PVector(x2, y2).add(ANCHOR_POS);

        // Initialize percent based on rotation
        float result = -1 * cos(rotation);
        percent = map(result, -1, 1, 0, 1);
    }

    void update() {
        time++;

        move();
        drawLine();
        drawBall();
    }

    void drawLine() {
        stroke(100);
        strokeWeight(1);
        line(ep_1.x, ep_1.y, ep_2.x, ep_2.y);
    }

    void drawBall() {
        noStroke();
        fill(ballColor);
        ellipseMode(RADIUS);
        ellipse(position.x, position.y, DEF_RADIUS, DEF_RADIUS);
    }

    void move() { 
        position = getBallPosition();

        // Now instead of moving linearly, we move using a sine function
        // This gives us a nice pendulum effect
        percent = map(cos(time / 60.0f), -1, 1, 0, 1);
    }   

    PVector getBallPosition() {
        float x = ep_1.x + (percent * (ep_2.x - ep_1.x));
        float y = ep_1.y + (percent * (ep_2.y - ep_1.y));

        // We could probably also do this below instead, but it looked ugly so no
        // return new PVector(0, 0).add(ep_1.add((ep_2.sub(ep_1)).mult(percent)));

        return new PVector(x, y);
    }
}