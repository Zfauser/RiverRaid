PImage plane;
PImage planeTurnLeft;
PImage planeTurnRight;
PImage helicoptor;
PImage ship;
PImage fuel;
PImage startscreen;
PImage gameoverscreen;

int height = 600;
int width = 800;

int lives = 3;

int score = 0;

int planeX = 400;
float planeY = height/1.75;
int planeLeft = 400;
int planeRight = 430;
float planeTop = planeY;
float planeBottom = planeY + 30;
int direction = 0; // 0 = straight, 1 = left, 2 = right

boolean shoot = false;
float bulletX = 0;
float bulletY = 0;
float bulletRight = 0;
float bulletLeft = 0;
int bulletSpeed = 10;

float fuelX;
float fuelY = height + 100;
float fuelRight = 31;
float fuelLeft;
float fuelTop;
float fuelBottom;
float remainingFuel = 200;

float helicoptorX;
float helicoptorY = height + 150;
float helicoptorRight = 30;
float helicoptorLeft;
float helicoptorTop;
float helicoptorBottom;

float shipX;
float shipY = height + 150;
float shipRight = 65;
float shipLeft;
float shipTop;
float shipBottom;

boolean isGameStarted = false;
boolean isGameOver = false;

void setup() {
    size(800, 600);
    plane = loadImage("plane.png");
    planeTurnLeft = loadImage("planeLeft.png");
    planeTurnRight = loadImage("planeRight.png");
    helicoptor = loadImage("helicoptor.png");
    ship = loadImage("ship.png");
    fuel = loadImage("fuel.png");
    startscreen = loadImage("startscreen.png");
    gameoverscreen = loadImage("gameoverscreen.png");
}

void draw() {
    if (isGameStarted == false) {
        image(startscreen, 0, 0);
        if (keyPressed) {
            if (key == ' ') {
                isGameStarted = true;
            }
        }
    } else if (isGameOver == true) {
        image(gameoverscreen, 0, 0);
        if (keyPressed) {
            if (key == ' ') {
                isGameOver = false;
                isGameStarted = false;
                lives = 3;
                score = 0;
                remainingFuel = 200;
                planeX = 400;
                planeY = height/1.75;
                planeLeft = 400;
                planeRight = 430;
                planeTop = planeY;
                planeBottom = planeY + 30;
                direction = 0; // 0 = straight, 1 = left, 2 = right
                shoot = false;
                bulletX = 0;
                bulletY = 0;
                bulletRight = 0;
                bulletLeft = 0;
                bulletSpeed = 10;
                fuelX = 0;
                fuelY = height + 100;
                fuelRight = 31;
                fuelLeft = fuelX;
                fuelTop = fuelY;
                fuelBottom = fuelY + 30;
                helicoptorX = 0;
                helicoptorY = height + 150;
                helicoptorRight = 30;
                helicoptorLeft = helicoptorX;
                helicoptorTop = helicoptorY;
                helicoptorBottom = helicoptorY + 30;
                shipX = 0;
                shipY = height + 150;
                shipRight = 65;
                shipLeft = shipX;
                shipTop = shipY;
                shipBottom = shipY + 30;
            }
        }
    } else {
        background(57, 76, 180);
        fill(104, 145, 49);
        rect(0, 0, width/4, height);
        rect(width/4*3, 0, width/4, height);
        drawEnemiesFuel();
        if (direction == 0) {
            image(plane, planeX, planeY);
        } else if (direction == 1) {
            planeX = planeX - 5;
            planeLeft = planeLeft - 5;
            planeRight = planeRight - 5;
            image(planeTurnLeft, planeX, planeY);
            if (planeX < width/4) {
                planeX = width/4;
                planeLeft = planeX;
                planeRight = planeX + 30;
            }
        } else if (direction == 2) {
            planeX = planeX + 5;
            planeLeft = planeLeft + 5;
            planeRight = planeRight + 5;
            if (planeRight >= width/4*3) {
                planeRight = width/4*3;
                planeX = planeRight - 30;
                planeLeft = planeX;
            }
            image(planeTurnRight, planeX, planeY);
        }
        if (bulletY > 0) {
            fill(255, 0, 0);
            ellipse(bulletX, bulletY, 5, 5);
            bulletY = bulletY - bulletSpeed;
            bulletRight = bulletX + 2.5;
            bulletLeft = bulletX - 2.5;
        } else if (bulletY <= 0) {
            shoot = false;
        } else if (bulletY > height) {
            shoot = false;
        }
        // collision detection
        if (bulletY < helicoptorBottom && bulletY > helicoptorTop && bulletRight > helicoptorLeft && bulletLeft < helicoptorRight) {
            score = score + 100;
            shoot = false;
            bulletY = -10000000;
            helicoptorY = -50;
            helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
            helicoptorRight = helicoptorX + 30;
            helicoptorLeft = helicoptorX;
            helicoptorTop = helicoptorY - 2;
            helicoptorBottom = helicoptorY + 22;
            // do not allow helicopter to overlap with fuel and/or ship
            while (helicoptorX > fuelX - 30 && helicoptorX < fuelX + 30 || helicoptorX > shipX - 30 && helicoptorX < shipX + 30) {
                helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
                helicoptorRight = helicoptorX + 30;
                helicoptorLeft = helicoptorX;
            }
        }
        if (bulletY < shipBottom && bulletY > shipTop && bulletRight > shipLeft && bulletLeft < shipRight) {
            score = score + 100;
            shoot = false;
            bulletY = -10000000;
            shipY = -75;
            shipX = random(width/4, width/4*3 + (shipX - shipRight));
            shipRight = shipX + 65;
            shipLeft = shipX;
            shipTop = shipY;
            shipBottom = shipY + 22;
            // do not allow ship to overlap with fuel and/or helicopter
            while (shipX > fuelX - 65 && shipX < fuelX + 65 || shipX > helicoptorX - 65 && shipX < helicoptorX + 65) {
                shipX = random(width/4, width/4*3 + (shipX - shipRight));
                shipRight = shipX + 65;
                shipLeft = shipX;
            }
        }
        if (bulletY < fuelBottom && bulletY > fuelTop && bulletRight > fuelLeft && bulletLeft < fuelRight) {
            shoot = false;
            bulletY = -10000000;
            fuelY = -100;
            fuelX = random(width/4, width/4*3 + (fuelX - fuelRight));
            fuelRight = fuelX + 31;
            fuelLeft = fuelX;
            fuelTop = fuelY - 5;
            fuelBottom = fuelY + 51;
            // do not allow fuel to overlap with ship and/or helicopter
            while (fuelX > shipX - 31 && fuelX < shipX + 31 || fuelX > helicoptorX - 31 && fuelX < helicoptorX + 31) {
                fuelX = random(width/4, width/4*3 + (fuelX - fuelRight));
                fuelRight = fuelX + 31;
                fuelLeft = fuelX;
            }
        }
        if (planeRight > helicoptorLeft && planeLeft < helicoptorRight && planeBottom > helicoptorTop && planeTop < helicoptorBottom) {
            // make helicopter disappear
            lives = lives - 1;
            helicoptorY = -50;
            helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
            helicoptorRight = helicoptorX + 30;
            helicoptorLeft = helicoptorX;
            helicoptorTop = helicoptorY - 2;
            helicoptorBottom = helicoptorY + 22;
            // do not allow helicopter to overlap with fuel and/or ship
            while (helicoptorX > fuelX - 30 && helicoptorX < fuelX + 30 || helicoptorX > shipX - 30 && helicoptorX < shipX + 30) {
                helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
                helicoptorRight = helicoptorX + 30;
                helicoptorLeft = helicoptorX;
            }
        }
        if (planeRight > shipLeft && planeLeft < shipRight && planeBottom > shipTop && planeTop < shipBottom) {
            // make ship disappear
            lives = lives - 1;
            shipY = -75;
            shipX = random(width/4, width/4*3 + (shipX - shipRight));
            shipRight = shipX + 65;
            shipLeft = shipX;
            shipTop = shipY;
            shipBottom = shipY + 22;
            // do not allow ship to overlap with fuel and/or helicopter
            while (shipX > fuelX - 65 && shipX < fuelX + 65 || shipX > helicoptorX - 65 && shipX < helicoptorX + 65) {
                shipX = random(width/4, width/4*3 + (shipX - shipRight));
                shipRight = shipX + 65;
                shipLeft = shipX;
            }
        }
        if (planeRight > fuelLeft && planeLeft < fuelRight && planeBottom > fuelTop && planeTop < fuelBottom) {
            // make fuel disappear
            remainingFuel = remainingFuel + 100;
            if (remainingFuel > 200) {
                remainingFuel = 200;
            }
            fuelY = -100;
            fuelX = random(width/4, width/4*3 + (fuelX - fuelRight));
            fuelRight = fuelX + 31;
            fuelLeft = fuelX;
            fuelTop = fuelY - 5;
            fuelBottom = fuelY + 51;
            // do not allow fuel to overlap with ship and/or helicopter
            while (fuelX > shipX - 31 && fuelX < shipX + 31 || fuelX > helicoptorX - 31 && fuelX < helicoptorX + 31) {
                fuelX = random(width/4, width/4*3 + (fuelX - fuelRight));
                fuelRight = fuelX + 31;
                fuelLeft = fuelX;
            }
        }
        fill(119, 119, 119);
        rect(0, height-height/5, width, height/5);
        fuelbar();
        score();
        lives();
        controls();
    }
}

void drawEnemiesFuel() {
    if (fuelY > height) {
        fuelY = -25;
        fuelX = random(width/4, width/4*3 + (fuelX - fuelRight));
        fuelRight = fuelX + 31;
        fuelLeft = fuelX;
        fuelTop = fuelY - 5;
        fuelBottom = fuelY + 51;
        // do not allow fuel to overlap with ship and/or helicopter
        while (fuelX > shipX - 31 && fuelX < shipX + 31 || fuelX > helicoptorX - 31 && fuelX < helicoptorX + 31) {
            fuelX = random(width/4, width/4*3 + (fuelX - fuelRight));
            fuelRight = fuelX + 31;
            fuelLeft = fuelX;
        }
    } else {
        image(fuel, fuelX, fuelY);
        fuelY = fuelY + 3;
        fuelRight = fuelX + 31;
        fuelLeft = fuelX;
        fuelTop = fuelY - 5;
        fuelBottom = fuelY + 51;
    }
    if (helicoptorY > height) {
        helicoptorY = -50;
        helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
        helicoptorRight = helicoptorX + 30;
        helicoptorLeft = helicoptorX;
        helicoptorTop = helicoptorY - 2;
        helicoptorBottom = helicoptorY + 22;
        // do not allow helicopter to overlap with fuel and/or ship
        while (helicoptorX > fuelX - 30 && helicoptorX < fuelX + 30 || helicoptorX > shipX - 30 && helicoptorX < shipX + 30) {
            helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
            helicoptorRight = helicoptorX + 30;
            helicoptorLeft = helicoptorX;
        }
    } else {
        image(helicoptor, helicoptorX, helicoptorY);
        helicoptorY = helicoptorY + 3;
        helicoptorRight = helicoptorX + 30;
        helicoptorLeft = helicoptorX;
        helicoptorTop = helicoptorY - 2;
        helicoptorBottom = helicoptorY + 22;
    }
    if (shipY > height) {
        shipY = -75;
        shipX = random(width/4, width/4*3 + (shipX - shipRight));
        shipRight = shipX + 65;
        shipLeft = shipX;
        shipTop = shipY;
        shipBottom = shipY + 22;
        // do not allow ship to overlap with fuel and/or helicopter
        while (shipX > fuelX - 65 && shipX < fuelX + 65 || shipX > helicoptorX - 65 && shipX < helicoptorX + 65) {
            shipX = random(width/4, width/4*3 + (shipX - shipRight));
            shipRight = shipX + 65;
            shipLeft = shipX;
        }
    } else {
        image(ship, shipX, shipY);
        shipY = shipY + 3;
        shipRight = shipX + 65;
        shipLeft = shipX;
        shipTop = shipY;
        shipBottom = shipY + 22;
    }
}

void keyPressed() {
    if (key == 'w') {
        direction = 0;
    } else if (key == 'a') {
        direction = 1;
    } else if (key == 'd') {
        direction = 2;
    } else if (key == ' ' && isGameOver == false && isGameStarted == true && shoot == false) {
        shoot = true;
        bulletX = planeX + 15;
        bulletY = planeY;
        bulletRight = bulletX + 5;
        bulletLeft = bulletX;
    }
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
    if (remainingFuel <= 0) {
        isGameOver = true;
    }
}

void score() {
    textSize(20);
    fill(255, 255, 255);
    text("Score: " + score, 50, 525);
}

void lives() {
    textSize(20);
    fill(255, 255, 255);
    text("Lives: " + lives, 300, 525);
    if (lives <= 0) {
        isGameOver = true;
    }
}

void controls() {
    textSize(20);
    fill(255, 255, 255);
    text("Controls:", 30, 50);
    text("W - Move Forward", 30, 75);
    text("A - Move Left", 30, 100);
    text("D - Move Right", 30, 125);
    text("Space - Shoot", 30, 150);
}