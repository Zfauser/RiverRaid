/* Assignment: Assignment 5 - Atari Game (River Raid)
Purpose: The classic game of River Raid in the proccessing language
Start Date: November 7th, 2022 */
PImage plane; //plane image
PImage fuel; //fuel image
PImage helicopter; //helicopter image

int width = 800; //width of the screen
int height = 600; //height of the screen

int planeX = 400; //x position of the plane

float BulletY = 342.85715; //y position of the bullet
int BulletX;

float fuelX = 0;
float fuelY = -10;

float helicopterX = 0;
float helicopterY = -50;

boolean shoot = false;

int speed = 10;

void setup() {
    plane = loadImage("plane.png");
    fuel = loadImage("fuel.png");
    helicopter = loadImage("helicopter.png");
    size(800, 600);
    }
void draw() {
    background(57, 76, 180);
    fill(104, 145, 49);
    rect(0, 0, 225, height);
    rect(575, 0, 225, height);
    fill(119, 119, 119);
    rect(0, 500, 800, 100);
    image(plane, planeX, height/1.75);
    if (BulletY > 0) {
            shootBullet();
            BulletY -= speed;
    } else shoot = false;
    if (planeX < 225) {
        planeX = 225;
    } else if (planeX > 545) {
        planeX = 545;
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
    // if bullet hits helicopter
    if (BulletX > helicopterX && BulletX < helicopterX + 30 && BulletY > helicopterY && BulletY < helicopterY + 30) {
        helicopterX = random(225, 545);
        helicopterY = -50;
        fill(119, 119, 119);
        rect(0, 500, 800, 100);
        BulletY = 342.85715;
        shoot = false;
    }
    // if plane hits helicopter
    if (planeX > helicopterX && planeX < helicopterX + 30 && height/1.75 > helicopterY && height/1.75 < helicopterY + 30) {
        //game over
        fill(255, 0, 0);
        textSize(50);
        text("Game Over", 300, 300);
        delay(1000);
    }
}
void keyPressed() {
    if (key == 'a') {
        fill(57, 76, 180);
        stroke(57, 76, 180);
        rect(planeX, height/1.75, 30, 30);
        planeX -= 10;
        image(plane, planeX, height/1.75);
    }
    if (key == 'd') {
        fill(57, 76, 180);
        stroke(57, 76, 180);
        rect(planeX, height/1.75, 30, 30);
        planeX += 10;
        image(plane, planeX, height/1.75);
    }
    if (key == ' ' && shoot == false) {
        BulletY = 342.85715;
        BulletX = planeX + 12;
        shoot = true;
    }
}

void shootBullet() {
    fill(57, 76, 180);
    fill(255, 215, 0);
    rect(BulletX, BulletY, 5, 5);
}
