/* autogenerated by Processing revision 1293 on 2023-08-24 */
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

public class CycloidMotion extends PApplet {

ArrayList<Pendulum> swings;

int c1;
float angle = 0;
int count = 0;

int gifFrameCount = 0;
int desiredFrameCount = 100;

public void setup() {
    /* size commented out by preprocessor */;
    swings = new ArrayList<Pendulum>();

    colorMode(HSB, 360, 100, 100);
    c1 = color(0, 100, 80);
}

public void draw() {
    background(0);

    addSwing();
    shiftHue();

    for (Pendulum swing : swings) {
        swing.update();
    }

    // render();
}

public void shiftHue() {
    // Shift the hue of the color
    c1 = color((hue(c1) + 1.5f) % 360, saturation(c1), brightness(c1));
}

public void addSwing() {
    for (int i = 0; i < 100; i++) {
        count++;

        if (count == 1178 && swings.size() < 16) {
            swings.add(new Pendulum(angle, 300, c1));
            angle += HALF_PI * 0.125f;

            count = 0;
        }   
    }
}

public void render() {
    // For rendering into GIF purposes, do not run unless you really want to

    if (frameCount >= 377 && frameCount < 377 * 2) {
        saveFrame("frames/gif-" + gifFrameCount + ".jpg");

        gifFrameCount++;
    }

    if (frameCount == 377 * 2) {
        exit();
    }
}

class Pendulum {
    PVector position; // Position of ball in the canvas
    int ballColor; // Color of the ball

    int time; // Time elapsed since the start of the pendulum simulation
    float percent; // Value from 0 to 1 that denotes its position in the "pendulum"
    float rotation; // Angle of rotation of the "pendulum" in radians
    PVector ep_1, ep_2; // Endpoints of the "pendulum"

    final PVector ANCHOR_POS = new PVector(width * 0.5f, height * 0.5f);
    final float DEF_RADIUS = 10.0f;

    Pendulum(float rotation, float length) {
        initEndpoints(rotation, length);

        this.rotation = rotation;
        this.position = getBallPosition();
        this.ballColor = color(255);
    }

    Pendulum(float rotation, float length, int ballColor) {
        initEndpoints(rotation, length);

        this.rotation = rotation;
        this.position = getBallPosition();
        this.ballColor = ballColor;
    }

    public void initEndpoints(float rotation, float length) {
        // Note: length is in pixels (px)
        float r = length * 0.5f;
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

    public void update() {
        time++;

        move();
        drawLine();
        drawBall();
    }

    public void drawLine() {
        stroke(100);
        strokeWeight(1);
        line(ep_1.x, ep_1.y, ep_2.x, ep_2.y);
    }

    public void drawBall() {
        noStroke();
        fill(ballColor);
        ellipseMode(RADIUS);
        ellipse(position.x, position.y, DEF_RADIUS, DEF_RADIUS);
    }

    public void move() { 
        position = getBallPosition();

        // Now instead of moving linearly, we move using a sine function
        // This gives us a nice pendulum effect
        percent = map(cos(time / 60.0f), -1, 1, 0, 1);
    }   

    public PVector getBallPosition() {
        float x = ep_1.x + (percent * (ep_2.x - ep_1.x));
        float y = ep_1.y + (percent * (ep_2.y - ep_1.y));

        // We could probably also do this below instead, but it looked ugly so no
        // return new PVector(0, 0).add(ep_1.add((ep_2.sub(ep_1)).mult(percent)));

        return new PVector(x, y);
    }
}


  public void settings() { size(400, 400, P2D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CycloidMotion" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
