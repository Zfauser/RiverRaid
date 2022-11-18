/* Assignment: Assignment 5 - Atari Game (River Raid)
Purpose: The classic game of River Raid in the proccessing language
Start Date: November 7th, 2022 */
PImage plane; //plane image
PImage fuel; //fuel image
PImage helicopter; //helicopter image
PImage leftPlane; //plane image
PImage rightPlane; //plane image


int width = 800; //width of the screen
int height = 600; //height of the screen

int lives = 2; //number of lives

int score = 0; //score of the game

boolean DEBUGMODE = false; //debug mode

int planeX = 400; //x position of the plane
// the right side of the plane
int planeRight = 430; //y position of the plane

float BulletY = 342.85715; //y position of the bullet
int BulletX;
int BulletRight;

float fuelX = 0;
float fuelY = -10;

float helicopterX = 0;
float helicopterY = -50;

boolean shoot = false;

int speed = 10;

float remainingFuel = 200;

String direction = "straight";

void setup() {
    plane = loadImage("plane.png");
    fuel = loadImage("fuel.png");
    helicopter = loadImage("helicopter.png");
    leftPlane = loadImage("left-wing.png");
    rightPlane = loadImage("right-wing.png");
    size(800, 600);
    }
void draw() {
    background(57, 76, 180);
    fill(104, 145, 49);
    rect(0, 0, 225, height);
    rect(575, 0, 225, height);
    fill(119, 119, 119);
    rect(0, 500, 800, 100);
    if (direction == "straight") {
        image(plane, planeX, height/1.75);
    } else if (direction == "left") {
        image(leftPlane, planeX, height/1.75);
        planeX -= 3;
        planeRight -= 3;
    } else if (direction == "right") {
        image(rightPlane, planeX, height/1.75);
        planeX += 3;
        planeRight += 3;
    }
    if (BulletY > 0) {
            shootBullet();
            BulletY -= speed;
    } else shoot = false;
    if (planeX < 225) {
        planeX = 225;
        planeRight = 255;
    } else if (planeX > 545) {
        planeX = 545;
        planeRight = 575;
    }
    if (fuelX > 0 && fuelY < height) {
        image(fuel, fuelX, fuelY);
        fuelY += 2;
        fill(119, 119, 119);
        rect(0, 500, 800, 100);
    } else {
        fuelX = random(225, 545);
        fuelY = -10;
        fill(119, 119, 119);
        rect(0, 500, 800, 100);
    }
    if (helicopterX > 0 && helicopterY < height) {
        image(helicopter, helicopterX, helicopterY);
        helicopterY += 2;
        fill(119, 119, 119);
        rect(0, 500, 800, 100);
    } else {
        helicopterX = random(225, 545);
        helicopterY = -50;
        fill(119, 119, 119);
        rect(0, 500, 800, 100);
    }
    fuelbar();
    // if the bullet rectangle hits the helicopter rectangle, the helicopter disappears and the bullet disappears
    if (BulletX > helicopterX && BulletX < helicopterX + 30 && BulletY > helicopterY && BulletY < helicopterY + 30 || BulletRight > helicopterX && BulletRight < helicopterX + 30 && BulletY > helicopterY && BulletY < helicopterY + 30) {
        shoot = false;
        helicopterX = random(225, 545);
        while (helicopterX == fuelX) {
            helicopterX = random(225, 545);
        }
        helicopterY = -100;
        score += 100;
        BulletY = -1;
    }
    // if the bullet rectangle hits the fuel rectangle, the fuel disappears and the bullet disappears
    if (BulletX > fuelX && BulletX < fuelX + 30 && BulletY > fuelY && BulletY < fuelY + 30 || BulletRight > fuelX && BulletRight < fuelX + 30 && BulletY > fuelY && BulletY < fuelY + 30) {
        shoot = false;
        fuelX = random(225, 545);
        while (fuelX == helicopterX) {
            fuelX = random(225, 545);
        }
        fuelY = -110;
        BulletY = -1;
    }
    // if the plane hits the helicopter at any angle, the game ends
    if (planeX > helicopterX && planeX < helicopterX + 30 && height/1.75 > helicopterY && height/1.75 < helicopterY + 30 || planeRight > helicopterX && planeRight < helicopterX + 30 && height/1.75 > helicopterY && height/1.75 < helicopterY + 30) {
        if (lives > 0) {
            lives -= 1;
            helicopterX = random(225, 545);
            helicopterY = -100;
        } else {
            lives -= 1;
            // draw rectangle over lives
            fill(119, 119, 119);
            rect(0, 500, 800, 100);
            fill(255, 0, 0);
            textSize(50);
            text("GAME OVER", 300, 300);
            noLoop();
        }
    }
    // if the plane hits the fuel at any angle, the fuel disappears and the fuel bar increases
    if (planeX > fuelX && planeX < fuelX + 30 && height/1.75 > fuelY && height/1.75 < fuelY + 60 || planeRight > fuelX && planeRight < fuelX+ 30 && height/1.75 > fuelY && height/1.75 < fuelY + 60) {
        fuelX = random(225, 545);
        fuelY = -100;
        remainingFuel += 100;
        if (remainingFuel > 200) {
            remainingFuel = 200;
        }
    }
    if (DEBUGMODE == true) {
        debug();
    }
    // draw the score
    fill(255, 255, 255);
    textSize(25);
    text("Score: " + score, 25, 525, 250, 50);
    // draw the lives
    fill(255, 255, 255);
    textSize(25);
    text("Lives: " + (lives+1), 25, 550, 250, 50);
}
void keyPressed() {
    if (key == 'a') {
        fill(57, 76, 180);
        stroke(57, 76, 180);
        rect(planeX, height/1.75, 30, 30);
        planeX -= 10;
        planeRight -= 10;
        image(leftPlane, planeX, height/1.75);
        direction = "left";
    }
    if (key == 'd') {
        fill(57, 76, 180);
        stroke(57, 76, 180);
        rect(planeX, height/1.75, 30, 30);
        planeX += 10;
        planeRight += 10;
        image(rightPlane, planeX, height/1.75);
        direction = "right";
    }
    if (key == 'w') {
        fill(57, 76, 180);
        stroke(57, 76, 180);
        rect(planeX, height/1.75, 30, 30);
        image(plane, planeX, height/1.75);
        direction = "straight";
    }
    if (key == ' ' && shoot == false) {
        BulletY = 342.85715;
        BulletX = planeX + 12;
        BulletRight = planeRight + 12;
        shoot = true;
    }
    if (key == 't') {
        DEBUGMODE = !DEBUGMODE;
    }
}

void shootBullet() {
    fill(57, 76, 180);
    fill(255, 215, 0);
    rect(BulletX, BulletY, 5, 5);
}

void fuelbar() {
    textSize(20);
    fill(255, 255, 255);
    text("Fuel: " + remainingFuel/2, 550, 525);
    remainingFuel = remainingFuel - 0.25;
    fill(255, 0, 0);
    rect(550, 525, 200, 50);
    fill(0, 255, 0);
    rect(550, 525, remainingFuel, 50);
    if (remainingFuel < 0) {
        //game over
        fill(255, 0, 0);
        textSize(50);
        text("Game Over", 300, 300);
        noLoop();
    }
}

void debug(){
    // write debug information to the screen
    fill(255, 255, 255);
    textSize(20);
    text("planeX: " + planeX, 10, 20);
    text("planeRight: " + planeRight, 10, 40);
    text("BulletX: " + BulletX, 10, 60);
    text("BulletRight: " + BulletRight, 10, 80);
    text("BulletY: " + BulletY, 10, 100);
    text("fuelX: " + fuelX, 10, 120);
    text("fuelY: " + fuelY, 10, 140);
    text("helicopterX: " + helicopterX, 10, 160);
    text("helicopterY: " + helicopterY, 10, 180);
    text("shoot: " + shoot, 10, 200);
    // top right corner of the screen write the current frame rate
    text("FPS: " + frameRate, 670, 20);
    // Change window title to show the current frame rate
    surface.setTitle("DEBUG MODE - RiverRaid");
    noFill();
    stroke(255, 0, 0);
    rect(planeX, height/1.75, 30, 30);
    // create a rectangle around the bullet
    noFill();
    stroke(255, 0, 0);
    rect(BulletX, BulletY, 5, 5);
    // create a rectangle around the helicopter
    noFill();
    stroke(255, 0, 0);
    rect(helicopterX, helicopterY, 30, 25);
    // create a rectangle around the fuel
    noFill();
    stroke(255, 0, 0);
    rect(fuelX, fuelY-5, 32, 60);
    // draw a line at planeX
    stroke(255, 0, 0);
    line(planeX, 0, planeX, height);
    // draw a line at planeRight
    stroke(255, 0, 0);
    line(planeRight, 0, planeRight, height);
}

void playAgain() {
    
}