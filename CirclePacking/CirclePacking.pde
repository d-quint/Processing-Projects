ArrayList<Bubble> bubbles;
final float DEFAULT_RADIUS = 4;

boolean shouldRun = false;

void setup() {
    size(800, 500, P2D);
    bubbles = new ArrayList<Bubble>();
}

void draw() {
    background(22, 14, 14);

    if (shouldRun) {
        runBubbleMachine();
    } else {
        for (Bubble bubble : bubbles) {
            bubble.display();
        }
    }
}

// Event Handlers & Helper Functions

void runBubbleMachine() {
    Bubble newBubble = generateRandomBubble();

    if (newBubble != null) {
        bubbles.add(newBubble);
    }
    
    for (Bubble bubble : bubbles) {
        for (Bubble other : bubbles) {
            if (bubble == other) {
                bubble.checkCollision();
                continue;
            }
            
            bubble.checkCollision(other);
        }

        bubble.grow();
        bubble.display();
    }
}

void mouseClicked() {
    switch (mouseButton) {
        case LEFT:
            shouldRun = !shouldRun;
            break;
        case RIGHT:
            bubbles.clear();
            break;
    }
}

boolean intersectsAnyBubble(Bubble bubble) {
    for (Bubble other : bubbles) {
        if (bubble == other) {
            continue;
        }

        if (bubble.isTouchingBubble(other) || bubble.isTouchingEdge()) {
            return true;
        }
    }

    return false;
}

Bubble generateRandomBubble() {
    float radius = 100.0f;
    int count = 0;

    while (count < 1000) {
        float r = random(0, radius);
        float theta = random(0, TWO_PI);

        float x = r * cos(theta) + mouseX;
        float y = r * sin(theta) + mouseY;

        Bubble bubble = new Bubble(x, y, DEFAULT_RADIUS);

        if (!intersectsAnyBubble(bubble)) {
            return bubble;
        }

        count++;
    }

    return null;
}
