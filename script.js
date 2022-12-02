/* Assignment: Assignment 5 - Atari Game (River Raid)
Purpose: The classic game of River Raid in the proccessing language
Start Date: November 7th, 2022 */

// Define width and height of the screen
let height = 600;
let width = 800;

// Define livesVar and scoreVar
let livesVar = 3;
let scoreVar = 0;

// define plane variables
let planeX = 400;
let planeY = height/1.75;
let planeLeft = 400;
let planeRight = 430;
let planeTop = planeY;
let planeBottom = planeY + 30;
let direction = 0; // 0 = straight, 1 = left, 2 = right

// define bullet variables
let shoot = false;
let bulletX = 0;
let bulletY = 0;
let bulletRight = 0;
let bulletLeft = 0;
let bulletSpeed = 10;

// define fuel variables
let fuelX;
let fuelY = height + 100;
let fuelRight = 31;
let fuelLeft;
let fuelTop;
let fuelBottom;
let remainingFuel = 200;

// define helicoptor variables
let helicoptorX;
let helicoptorY = height + 150;
let helicoptorRight = 30;
let helicoptorLeft;
let helicoptorTop;
let helicoptorBottom;

// define ship variables
let shipX;
let shipY = height + 150;
let shipRight = 65;
let shipLeft;
let shipTop;
let shipBottom;

// define game variables
let isGameStarted = false;
let isGameOver = false;
let framesPassed = 90;
let causeOfDeath = "";
let waitTime;
let plane;
let planeTurnLeft;
let planeTurnRight;
let helicoptor;
let ship;
let fuel;
let startscreen
let gameoverscreen;

// Setup Function
function setup() {
    frameRate(60); // set frame rate to 60
    // Create the window
    createCanvas(800, 600);
    // Load the images
    plane = loadImage("plane.png");
    planeTurnLeft = loadImage("planeLeft.png");
    planeTurnRight = loadImage("planeRight.png");
    helicoptor = loadImage("helicoptor.png");
    ship = loadImage("ship.png");
    fuel = loadImage("fuel.png");
    startscreen = loadImage("startscreen.png"); // ai generated start screen (DALLE 2)
    gameoverscreen = loadImage("gameoverscreen.png"); // ai generated game over screen (DALLE 2)
}

// Draw Function
function draw() {
    // If the game is not started, display the start screen
    if (!isGameStarted) {
        image(startscreen, 0, 0); // Display the start screen
        if (keyPressed) { // If a key is pressed...
            if (key == ' ') { // If the space bar is pressed...
                isGameOver = false;
                isGameStarted = true;
                livesVar = 3;
                scoreVar = 0;
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
                framesPassed = 90;
            }
        }
        // If game is over display the game over screen
    } else if (isGameOver) { // If the game is over...
        image(gameoverscreen, 0, 0); // Display the game over screen
        fill(255, 0, 0); // Set the text color to red
        textSize(20); // Set the text size to 50
        text("score: " + scoreVar, 10, 50); // Display the scoreVar
        text("Cause of Death: " + causeOfDeath, 10, 25); // Display the cause of death
        if (framesPassed > 0) { // If the frames passed is 0...
            framesPassed--; // Decrement framesPassed, the reason why I do this is because I want the game over screen to be displayed for a few seconds before the player can restart the game
        }
        // wait to allow user to read game over screen
        if (keyPressed  && framesPassed <= 0) { // If a key is pressed...
            if (key == ' ') { // If the space bar is pressed, reset the game
                isGameOver = false;
                isGameStarted = true;
                livesVar = 3;
                scoreVar = 0;
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
                framesPassed = 90;
            }
        }
    } else { // If the game is started...
        background(57, 76, 180); // Set the background color
        fill(104, 145, 49); // Set the color of the grass
        rect(0, 0, width/4, height); // Draw the grass on the left side
        rect(width/4*3, 0, width/4, height); // Draw the grass on the right side
        drawEnemiesFuel(); // Draw the enemies and fuel
        if (direction == 0) { // If the plane is going straight...
            image(plane, planeX, planeY); // Draw the plane
        } else if (direction == 1) { // If the plane is turning left...
            planeX = planeX - 5; // Move the plane left
            planeLeft = planeLeft - 5; // Move the left side of the plane left
            planeRight = planeRight - 5; // Move the right side of the plane left
            image(planeTurnLeft, planeX, planeY); // Draw the plane turning left
            if (planeX < width/4) { // If the plane is off the screen...
                planeX = width/4; // Move the plane back on the screen
                planeLeft = planeX; // Move the left side of the plane back on the screen
                planeRight = planeX + 30; // Move the right side of the plane back on the screen
            }
        } else if (direction == 2) { // If the plane is turning right...
            planeX = planeX + 5; // Move the plane right
            planeLeft = planeLeft + 5; // Move the left side of the plane right
            planeRight = planeRight + 5; // Move the right side of the plane right
            if (planeRight >= width/4*3) { // If the plane is off the screen...
                planeRight = width/4*3; // Move the plane back on the screen
                planeX = planeRight - 30; // Move the plane back on the screen
                planeLeft = planeX; // Move the left side of the plane back on the screen
            }
            image(planeTurnRight, planeX, planeY); // Draw the plane turning right
        }
        if (bulletY > 0) { // If the bullet is on the screen...
            fill(225, 255, 0); // Set the color of the bullet
            ellipse(bulletX, bulletY, 5, 5); // Draw the bullet as an ellipse
            bulletY = bulletY - bulletSpeed; // Move the bullet up
            bulletRight = bulletX + 2.5; // Move the right side of the bullet up
            bulletLeft = bulletX - 2.5; // Move the left side of the bullet up
        } else if (bulletY <= 0) { // If the bullet is off the screen...
            shoot = false; // Set shoot to false
        } else if (bulletY > height) { // If the bullet is off the screen...
            shoot = false; // Set shoot to false
        }
        // collision detection
        if (bulletY < helicoptorBottom && bulletY > helicoptorTop && bulletRight > helicoptorLeft && bulletLeft < helicoptorRight) { // If the bullet hits the helicoptor...
            scoreVar = scoreVar + 100; // Add 100 to the scoreVar
            shoot = false; // Set shoot to false
            bulletY = -1000; // Move the bullet off the screen
            helicoptorY = -50; // Move the helicoptor off the screen
            helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight)); // Move the helicoptor to a random location
            helicoptorRight = helicoptorX + 30; // Move the right side of the helicoptor to a random location
            helicoptorLeft = helicoptorX; // Move the left side of the helicoptor to a random location
            helicoptorTop = helicoptorY - 2; // Move the top of the helicoptor to a random location
            helicoptorBottom = helicoptorY + 22; // Move the bottom of the helicoptor to a random location
            // do not allow helicopter to overlap with fuel and/or ship
            while (helicoptorX > fuelX - 30 && helicoptorX < fuelX + 30 || helicoptorX > shipX - 30 && helicoptorX < shipX + 30) {
                helicoptorX = random(width/4, width/4*3 + (helicoptorX - helicoptorRight));
                helicoptorRight = helicoptorX + 30;
                helicoptorLeft = helicoptorX;
            }
        }
        // if bullet hits ship, give player 100 polets and move ship off screen
        if (bulletY < shipBottom && bulletY > shipTop && bulletRight > shipLeft && bulletLeft < shipRight) {
            scoreVar = scoreVar + 100;
            shoot = false;
            bulletY = -1000;
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
        // if bullet hits fuel, remove fuel from screen
        if (bulletY < fuelBottom && bulletY > fuelTop && bulletRight > fuelLeft && bulletLeft < fuelRight) {
            shoot = false;
            bulletY = -1000;
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
        // if plane hits helicopter, remove life
        if (planeRight > helicoptorLeft && planeLeft < helicoptorRight && planeBottom > helicoptorTop && planeTop < helicoptorBottom) {
            // make helicopter disappear
            livesVar = livesVar - 1;
            causeOfDeath = "Helicopter";
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
        // if plane hits ship, remove life
        if (planeRight > shipLeft && planeLeft < shipRight && planeBottom > shipTop && planeTop < shipBottom) {
            // make ship disappear
            livesVar = livesVar - 1;
            causeOfDeath = "Ship";
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
        // if plane hits fuel, add 100 to remaining fuel (out of 200) unless fuel is already at 200
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
        fill(119, 119, 119); // grey
        // this is the bar at the bottom of the screen
        rect(0, height-height/5, width, height/5);
        fuelbar(); // display the fuel bar
        score(); // display the scoreVar
        lives(); // display the livesVar
        controls(); // display the controls
    }
}

// draw the enemies (helicopter and ship) and the fuel
function drawEnemiesFuel() {
    // randomize location of fuel
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
    // display fuel
    } else {
        image(fuel, fuelX, fuelY);
        fuelY = fuelY + 3;
        fuelRight = fuelX + 31;
        fuelLeft = fuelX;
        fuelTop = fuelY - 5;
        fuelBottom = fuelY + 51;
    }
    // randomize location of helicopter
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
    // display helicopter
    } else {
        image(helicoptor, helicoptorX, helicoptorY);
        helicoptorY = helicoptorY + 3;
        helicoptorRight = helicoptorX + 30;
        helicoptorLeft = helicoptorX;
        helicoptorTop = helicoptorY - 2;
        helicoptorBottom = helicoptorY + 22;
    }
    // randomize location of ship
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
    // display ship
    } else {
        image(ship, shipX, shipY);
        shipY = shipY + 3;
        shipRight = shipX + 65;
        shipLeft = shipX;
        shipTop = shipY;
        shipBottom = shipY + 22;
    }
}

// if a key is pressed...
function keyPressed() {
    // if the w key is pressed...
    if (key == 'w') {
        direction = 0; // set direction to 0 (straight)
    // if the a key is pressed...
    } else if (key == 'a') {
        direction = 1; // set direction to 1 (left)
    // if the d key is pressed...
    } else if (key == 'd') {
        direction = 2; // set direction to 2 (right)
    } else if (key == ' ' && isGameOver == false && isGameStarted == true && shoot == false) { // if the space bar is pressed, shoot a bullet
        shoot = true;
        bulletX = planeX + 15;
        bulletY = planeY;
        bulletRight = bulletX + 5;
        bulletLeft = bulletX;
    }
}

// this function displays the fuel bar at the bottom of the screen
function fuelbar() {
    textSize(20);
    fill(255, 255, 255);
    text("Fuel: " + remainingFuel/2, 550, 525);
    remainingFuel = remainingFuel - 0.25;
    fill(255, 0, 0);
    rect(550, 525, 200, 50);
    fill(0, 255, 0);
    rect(550, 525, remainingFuel, 50);
    if (remainingFuel <= 0) {
        causeOfDeath = "Fuel!";
        isGameOver = true;
    }
}

// display scoreVar at bottom of screen
function score() {
    textSize(20);
    fill(255, 255, 255);
    text("score: " + scoreVar, 50, 525);
}

// display livesVar at bottom of screen
function lives() {
    textSize(20);
    fill(255, 255, 255);
    text("lives: " + livesVar, 300, 525);
    if (livesVar <= 0) {
        isGameOver = true;
    }
}

// display controls on the left side of the screen
function controls() {
    textSize(20);
    fill(255, 255, 255);
    text("Controls:", 30, 50);
    text("W - Move Forward", 30, 75);
    text("A - Move Left", 30, 100);
    text("D - Move Right", 30, 125);
    text("Space - Shoot", 30, 150);
}