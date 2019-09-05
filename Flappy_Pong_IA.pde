/********* FLAPPY PONG WITH ARTIFICIAL INTELLIGENCE *********/

// 0: PANTALLA INICIAL
// 1: PANTALLA DE JUEGO(IZQUIERDA USUARIO, DERECHA JR)
// 2: PANTALLA PUNTUACIÓN
// 3: PANTALLA RESUMEN

// VARIABLES DEL JUEGO
int gameScreen = 0;
Pelota pltuser = new Pelota();
Raqueta rckuser = new Raqueta();
Escenario escuser = new Escenario(color(153, 54, 54));
boolean gameOverUser = false;

Pelota pltjr = new Pelota();
Raqueta rckjr = new Raqueta();
Escenario escjr = new Escenario(color(44, 62, 80));
boolean gameOverJr = false;

// gameplay settings
float gravity = .3;
float airfriction = 0.00001;
float friction = 0.1;

// DIVISIÓN DE LAS PANTALLAS
PGraphics user, jr, div;

/********* SETUP BLOCK *********/

void setup() {
  size(1210, 500);
  user = createGraphics(width/2 -5, height);
  jr = createGraphics(width/2 -5, height);
  div = createGraphics(10, height);
  smooth();
}

/********* DRAW BLOCK *********/

void draw() {
  image(user, 0, 0);
  image(jr, width/2 +5, 0);
  image(div, width/2 -5, 0);
  // Display the contents of the current screen
  if (gameScreen == 0) { 
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    if(pltuser.health == 0){
      gameOverScreen(user, pltuser);
    }
    if(pltjr.health == 0){
      gameOverScreen(jr, pltjr);
    }
  } else if (gameScreen == 3) {
    resumeScreen();
  }
}

/********* SCREEN CONTENTS *********/

void initScreen() {
  background(177, 240, 190);
  textAlign(CENTER);
  fill(52, 73, 94);
  textSize(70);
  text("Flappy Pong", width/2, height/2);
  textSize(15); 
  text("Click para iniciar", width/2, height-30);
}

void gameScreen() {
  // DIBUJAR PANTALLA DEL USUARIO
  gameUser();
  // DIBUJAR PANTALLA DE IA
  gameIA();
  
  //Dividir Pantalla
  drawDiv();
}

void gameOverScreen(PGraphics screen, Pelota ball) {
  screen.beginDraw();
  screen.textAlign(CENTER);
  screen.fill(236, 240, 241);
  screen.textSize(12);
  if(screen==user){
    screen.background(44, 62, 80);
    screen.text("Tu puntuación:", width/4, height/2 - 120);
    gameOverUser = true;
  }else{
    screen.background(153, 54, 54);
    screen.text("Puntuación con IA:", width/4, height/2 - 120);
    gameOverJr = true;
  }
  screen.textSize(130);
  screen.text(ball.score, width/4, height/2);
  screen.textSize(15);
  screen.text("Click para finalizar partida", width/4, height-30);
  screen.endDraw();
  
  if (!gameOverUser){
    gameUser();
  }
  
  if (!gameOverJr){
    gameIA();
  }
  
  drawDiv();
}

void resumeScreen(){
  background(44, 62, 80);
  textAlign(CENTER);
  fill(236, 240, 241);
  textSize(100);
  text("GAME OVER", width/2, height/4);
  textSize(25);
  text("Tu puntuación", width/4, height/2.2);
  text("Puntuación con IA", width-width/4, height/2.2);
  textSize(50);
  text(pltuser.score, width/4, height/1.6);
  text(pltjr.score, width-width/4, height/1.6);
  textSize(20);
  text("Click para reiniciar", width/2, height-30);
}

/******** JUEGO ************/

void gameIA(){
  jr.beginDraw();
  jr.background(222, 193, 193);
  rckjr.drawRacket(jr);
  rckjr.watchRacketBounce(pltjr);
  pltjr.drawBall(jr);
  pltjr.applyGravity();
  pltjr.applyHorizontalSpeed();
  pltjr.keepInScreen();
  pltjr.drawHealthBar(jr);
  printScore(pltjr, jr);
  escjr.wallAdder(jr);
  escjr.wallHandler(jr, pltjr);
  rckjr.ia(pltjr, escjr);
  jr.endDraw();
}

void gameUser(){
  user.beginDraw();
  user.background(211, 217, 227);
  rckuser.drawRacket(user);
  rckuser.watchRacketBounce(pltuser);
  pltuser.drawBall(user);
  pltuser.applyGravity();
  pltuser.applyHorizontalSpeed();
  pltuser.keepInScreen();
  pltuser.drawHealthBar(user);
  printScore(pltuser, user);
  escuser.wallAdder(user);
  escuser.wallHandler(user, pltuser);
  user.endDraw();
}

void drawDiv(){
  div.beginDraw();
  div.background(158, 101, 32);
  div.endDraw();
}

/********* INPUTS *********/

public void mousePressed() {
  // if we are on the initial screen when clicked, start the game 
  if (gameScreen==0) { 
    startGame();
  }else if (gameScreen==2) {
    resumeGame();
  }else if (gameScreen==3) {
    restart();
  }
}

/********* OTHER FUNCTIONS *********/

void startGame() {
  gameScreen=1;
}

void gameOver() {
  gameScreen=2;
}

void resumeGame(){
  gameScreen=3;
}

void restart() {
  pltuser = new Pelota();
  pltjr = new Pelota();
  escuser.lastAddTime = 0;
  escjr.lastAddTime = 0;
  escuser.walls.clear();
  escjr.walls.clear();
  gameScreen = 1;
  gameOverUser = false;
  gameOverJr = false;
}

/*********   CONTROL FUNCTIONS *************/

void printScore(Pelota ball, PGraphics screen) {
  screen.textAlign(CENTER);
  screen.fill(0);
  screen.textSize(30); 
  screen.text(ball.score, height/2, 50);
}
