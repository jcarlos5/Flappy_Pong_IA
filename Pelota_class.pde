public class Pelota{
  // ball settings
  private float ballX = width/2;
  float ballY = 0;
  float ballSpeedVert = 0;
  float ballSpeedHorizon = 0;
  float ballSize = 20;
  color ballColor = color(0);
  
  // scoring
  int score = 0;
  int maxHealth = 100;
  float health = maxHealth;
  float healthDecrease = 1;
  int healthBarWidth = 60;
  
  void drawBall(PGraphics screen) {
    screen.fill(ballColor);
    screen.ellipse(ballX, ballY, ballSize, ballSize);
  }
  
  void applyGravity() {
    ballSpeedVert += gravity;
    ballY += ballSpeedVert;
    ballSpeedVert -= (ballSpeedVert * airfriction);
  }
  
  void applyHorizontalSpeed() {
    ballX += ballSpeedHorizon;
    ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
  }
  
  // keep ball in the screen
  void keepInScreen() {
    // ball hits floor
    if (ballY+(ballSize/2) > height) { 
      makeBounceBottom(height);
    }
    // ball hits ceiling
    if (ballY-(ballSize/2) < 0) {
      makeBounceTop(0);
    }
    // ball hits left of the screen
    if (ballX-(ballSize/2) < 0) {
      makeBounceLeft(0);
    }
    // ball hits right of the screen
    if (ballX+(ballSize/2) > width/2) {
      makeBounceRight(width/2);
    }
  }
  
  // ball falls and hits the floor (or other surface) 
  void makeBounceBottom(float surface) {
    ballY = surface-(ballSize/2);
    ballSpeedVert*=-1;
    ballSpeedVert -= (ballSpeedVert * friction);
  }
  
  // ball rises and hits the ceiling (or other surface)
  void makeBounceTop(float surface) {
    ballY = surface+(ballSize/2);
    ballSpeedVert*=-1;
    ballSpeedVert -= (ballSpeedVert * friction);
  }
  
  // ball hits object from left side
  void makeBounceLeft(float surface) {
    ballX = surface+(ballSize/2);
    ballSpeedHorizon*=-1;
    ballSpeedHorizon -= (ballSpeedHorizon * friction);
  }
  
  // ball hits object from right side
  void makeBounceRight(float surface) {
    ballX = surface-(ballSize/2);
    ballSpeedHorizon*=-1;
    ballSpeedHorizon -= (ballSpeedHorizon * friction);
  }
  
  void drawHealthBar(PGraphics screen) {
    screen.noStroke();
    screen.fill(189, 195, 199);
    screen.rectMode(CORNER);
    screen.rect(this.ballX-(healthBarWidth/2), ballY - 30, healthBarWidth, 5);
    if (health > 60) {
      screen.fill(46, 204, 113);
    } else if (health > 30) {
      screen.fill(230, 126, 34);
    } else {
      screen.fill(231, 76, 60);
    }
    screen.rect(this.ballX-(healthBarWidth/2), ballY - 30, healthBarWidth*(health/maxHealth), 5);
  }
  
  void decreaseHealth() {
    health -= healthDecrease;
    if (health <= 0) {
      gameOver(); //Llamar al método en la clase principal
    }
  }
}
