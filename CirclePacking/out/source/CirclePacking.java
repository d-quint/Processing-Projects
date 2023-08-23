/* autogenerated by Processing revision 1293 on 2023-08-23 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class CirclePacking extends PApplet {

ArrayList<Bubble> bubbles;
final float DEFAULT_RADIUS = 4;

boolean shouldRun = false;

public void setup() {
    /* size commented out by preprocessor */;
    bubbles = new ArrayList<Bubble>();
}

public void draw() {
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

public void runBubbleMachine() {
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

public void mouseClicked() {
    switch (mouseButton) {
        case LEFT:
            shouldRun = !shouldRun;
            break;
        case RIGHT:
            bubbles.clear();
            break;
    }
}

public boolean intersectsAnyBubble(Bubble bubble) {
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

public Bubble generateRandomBubble() {
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
class Bubble {
    float x, y, r, rVel, rAcc;
    boolean isGrowing;
    boolean hasFill;

    int bodyColor;
    int baseColor, maxColor;

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

    private int generateColor() {
        return color(random(255), random(255), random(255));
    }
}


  public void settings() { size(800, 500, P2D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CirclePacking" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
