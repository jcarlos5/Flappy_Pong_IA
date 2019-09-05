class Escenario{
  // wall settings
  int wallSpeed = 5;
  int wallInterval = 1000;
  float lastAddTime = 0;
  int minGapHeight = 200;
  int maxGapHeight = 300;
  int wallH;
  int gapWallX;
  int wallWidth = 80;
  color wallColors = color(44, 62, 80);
  // This arraylist stores data of the gaps between the walls. Actuals walls are drawn accordingly.
  // [gapWallX, gapWallY, gapWallWidth, gapWallHeight, scored]
  ArrayList<int[]> walls = new ArrayList<int[]>();
  
  Escenario(color col){
    wallColors = col;
  }
  
  void wallAdder(PGraphics screen) {
    if (millis()-lastAddTime > wallInterval) {
      int randHeight = round(random(minGapHeight, maxGapHeight));
      int randY = round(random(0, height-randHeight));
      // {gapWallX, gapWallY, gapWallWidth, gapWallHeight, scored}
      if(screen == user){
        int[] randWall = {width/2 -5 , randY, wallWidth, randHeight, 0};
        walls.add(randWall);
      }else{
        int[] randWall = {width/2, randY, wallWidth, randHeight, 0};
        walls.add(randWall);
      }    
      lastAddTime = millis();
    }
  }
  
  void wallHandler(PGraphics screen, Pelota ball, Raqueta rck) {
    for (int i = 0; i < walls.size(); i++) {
      wallRemover(i);
      wallMover(i);
      wallDrawer(i, screen, ball, rck);
      watchWallCollision(i, ball);
    }
  }
  
  void wallRemover(int index) {
    int[] wall = walls.get(index);
    if (wall[0]+wall[2] <= 0) {
      walls.remove(index);
    }
  }
  
  void wallMover(int index) {
    int[] wall = walls.get(index);
    wall[0] -= wallSpeed;
  }
  
  void wallDrawer(int index, PGraphics screen, Pelota plt, Raqueta rck) {
    int[] wall = walls.get(index);
    // get gap wall settings 
    int gapWallX = wall[0];
    int gapWallY = wall[1];
    int gapWallWidth = wall[2];
    int gapWallHeight = wall[3];
    
    // draw actual walls
    screen.rectMode(CORNER);
    screen.noStroke();
    screen.strokeCap(ROUND);
    screen.fill(wallColors);
    //Obstaculo superior
    screen.rect(gapWallX, 0, gapWallWidth, gapWallY, 0, 0, 15, 15);
    
    //Obstaculo inferior 
    screen.rect(gapWallX, gapWallY+gapWallHeight, gapWallWidth, height-(gapWallY+gapWallHeight), 15, 15, 0, 0);
    // gapWallX = coordenada x del obstaculo inferior 
    // gapWallY+gapWallHeight = coordenada y del inferior
    // gapWallWidth = ancho 
    //height-(gapWallY+gapWallHeight) = altura del obstaculo inferior
    if (screen == jr){
      rck.ia(plt,gapWallY+gapWallHeight,gapWallX);
    }
    

  }
  
  void watchWallCollision(int index, Pelota ball) {
    int[] wall = walls.get(index);
    // get gap wall settings 
    gapWallX = wall[0];
    int gapWallY = wall[1];
    int gapWallWidth = wall[2];
    int gapWallHeight = wall[3];
    int wallScored = wall[4];
    int wallTopX = gapWallX;
    int wallTopY = 0;
    int wallTopWidth = gapWallWidth;
    int wallTopHeight = gapWallY;
    int wallBottomX = gapWallX;
    int wallBottomY = gapWallY+gapWallHeight;
    int wallBottomWidth = gapWallWidth;
    int wallBottomHeight = height-(gapWallY+gapWallHeight);
  
    if (
      (ball.ballX+(ball.ballSize/2)>wallTopX) &&
      (ball.ballX-(ball.ballSize/2)<wallTopX+wallTopWidth) &&
      (ball.ballY+(ball.ballSize/2)>wallTopY) &&
      (ball.ballY-(ball.ballSize/2)<wallTopY+wallTopHeight)
      ) {
      ball.decreaseHealth();
    }
    if (
      (ball.ballX+(ball.ballSize/2)>wallBottomX) &&
      (ball.ballX-(ball.ballSize/2)<wallBottomX+wallBottomWidth) &&
      (ball.ballY+(ball.ballSize/2)>wallBottomY) &&
      (ball.ballY-(ball.ballSize/2)<wallBottomY+wallBottomHeight)
      ) {
      ball.decreaseHealth();
    }
  
    if (ball.ballX > gapWallX+(gapWallWidth/2) && wallScored==0) {
      wallScored=1;
      wall[4]=1;
      ball.score++;
    }
  }
}
