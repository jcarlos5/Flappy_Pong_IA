class Raqueta{
  // racket settings
  float x;
  float y;
  float racketX = 300;
  float racketY = height;
  color racketColor = color(0);
  float racketWidth = 100;
  float racketHeight = 10;
  
  Raqueta(){
    
  }
  
  void drawRacket(PGraphics screen) {
    screen.fill(racketColor);
    screen.rectMode(CENTER);
    if (screen == user){
      if(mouseX < 600){
        screen.rect(mouseX, mouseY, racketWidth, racketHeight, 5);
      }else{
        screen.rect(600, mouseY, racketWidth, racketHeight, 5);
      }
    }else{
      screen.rect(racketX, racketY, racketWidth, racketHeight, 5);
    }
  }
  
  void watchRacketBounce(Pelota ball) {
    float overhead;
    if(ball == pltuser){
      overhead = mouseY - pmouseY;
      x = mouseX;
      y = mouseY;
    }else{
      overhead = racketY - (racketY+2);
      x=racketX;
      y=racketY;
    }
    
    if ((ball.ballX+(ball.ballSize/2) > x-(racketWidth/2)) && (ball.ballX-(ball.ballSize/2) < x+(racketWidth/2))) {
      if (dist(ball.ballX, ball.ballY, ball.ballX, y)<=(ball.ballSize/2)+abs(overhead)) {
        ball.makeBounceBottom(y);
        ball.ballSpeedHorizon = (ball.ballX - x)/10;
        // racket moving up
        if (overhead<0) {
          ball.ballY+=(overhead/2);
          ball.ballSpeedVert+=(overhead/2);
        }
      }
    }
  }
  
  void ia(Pelota ball, Escenario esc){
    int x=0, y=0, i=0;
    
    while(racketX<ball.ballX+ball.ballSize/2){
      racketX += 10;
    }
    while(racketX>ball.ballX+ball.ballSize/2){
      racketX -= 10;
    }
    
    //esc.get[];
    //while(racketY<ball.ballY+ball.ballSize/2+20 && racketY<height/2){
    //  racketY += 10;
    //}
    //while(racketY>ball.ballY+ball.ballSize/2-20){
    //  racketY -= 10;
    //}
  }
  
  void moverY(){
    
  }
}
