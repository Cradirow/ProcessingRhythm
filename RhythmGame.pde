//library settings
import ddf.minim.*;

//extends class
ArrayList<Note> notes = new ArrayList<Note>();
GameController gameController = new GameController();

//resources
PImage musicImg;
AudioPlayer player;
Minim minim;

//game manage
boolean isStart = true; //change to false
boolean mouseOver = false;
boolean isMusicOn = false;

//game settings
float speed = 0.1; // speed x0.8, x1.0, x1.2 support
int combo = 0;
int melody = 0;

//score
int score = 0;
int perfectScore = 20;
int goodScore = 10;

//HP
int hp = 100;

//hitbox scale;
int hitboxTop = 550;
int hitboxBottom = 560;

void setup(){
  size(550,700);
  background(0);
  
  musicImg = loadImage("unity.jpg");
  minim = new Minim(this);
  //Delay();
  player = minim.loadFile("unity.mp3", 2048);
  
  Note newNote = new Note(0,2,speed);
  notes.add(newNote);
  newNote = new Note(1,2,speed);
  notes.add(newNote);
  newNote = new Note(2,2,speed);
  notes.add(newNote);
  newNote = new Note(3,2,speed);
  notes.add(newNote);
}

void draw(){
    
  if(isStart){
    background(255);
    backgroundDraw();
    
    update();
    gameController.update();
    
    if(!isMusicOn){
      //player.play();
      isMusicOn = true;
    }
    
  }else{
    update();
    textSize(30);
    fill(200);
    text("TheFatRat - Unity", 130,150);
    image(musicImg, 150, 200, 200, 200);
    fill(255);
    rect(150,450,200,50,10);
    fill(50);
    textSize(30);
    text("START", 200, 485);
    
    if(mouseOver){
      fill(0,100,150);
      rect(150,450,200,50,10);
      fill(50);
      textSize(30);
      text("START", 200, 485);
    }
  }
}

void update(){
  
  if(isStart){
    //note moving
    for(int i=0; i<notes.size(); i++){
      moveNote(i);
    }
    
    //cheke note hitting
    chkNote();
    
  }else{
    if(mouseX >= 200 && mouseX <= 400 
    && mouseY >= 450 && mouseY <= 500){
      mouseOver = true;
    }else{
      mouseOver = false;
    }
  }
}

void backgroundDraw()
{
    //out box rect
    strokeWeight(1.5);
    line(20,0,420,0);
    line(20,0,20,690);
    line(420,0,420,690);
    line(20,690,420,690);
    
    //lane backgrounds
    fill(255);
    rect(20,0,105,690);
    
    //hit box
    strokeWeight(2);
    fill(255,255,0);
    rect(10,550,420,30);  
    
    //lane lines
    strokeWeight(0.5);
    line(125,0,125,690);
    line(220,0,220,690);
    line(315,0,315,690);
    
    //keyboard rect 'S'
    strokeWeight(1.5);
    fill(100);
    rect(30,600,95,80);
    fill(255);
    textSize(50);
    text("S",65,660);
    
    //keyboard rect 'D'
    fill(100);
    rect(125,600,95,80);
    fill(255);
    textSize(50);
    text("D",155,660);
    
    //keyboard rect 'J'
    fill(100);
    rect(220,600,95,80);
    fill(255);
    textSize(50);
    text("J",260,660);
    
    //keyboard rect 'K'
    fill(100);
    rect(315,600,95,80);
    fill(255);
    textSize(50);
    text("K",350,660);
    
    
}

void mousePressed(){
  if(mouseOver) btnStart();
}

void gameStart(){ 
  //moveNote(0);
  //moveNote(1);
  //moveNote(2);
  //moveNote(3);
}

void moveNote(int index){
  notes.get(index).update();
  notes.get(index).display();
}

//score in here.
void chkNote(){
  
  //hitbox note
  int lane;
  for(int i=0; i<notes.size(); i++){
    lane = notes.get(i).getLane();
    
    //perfect
    if(notes.get(i).getY() >= hitboxTop && notes.get(i).getY() <= hitboxBottom){
      notes.get(i).hitBox();
      switch(lane){
        case 1:
          if(gameController.keyS){
            score += 20;
            combo++;
          }
          break;
        case 2:
          if(gameController.keyD){
            score += 20;
            combo++;
          }
          break;
        case 3:
          if(gameController.keyJ){
            score += 20;
            combo++;
          }
          break;
        case 4:
          if(gameController.keyK){
            score += 20;
            combo++;
          }
          break;
      }
    }
    //good
    else if(notes.get(i).getY() >= hitboxTop-20 && notes.get(i).getY() <= hitboxBottom+20){
      notes.get(i).closeBox();
      switch(lane){
        case 1:
          if(gameController.keyS){
            score += 10;
            combo++;
          }
          break;
        case 2:
          if(gameController.keyD){
            score += 10;
            combo++;
          }
          break;
        case 3:
          if(gameController.keyJ){
            score += 10;
            combo++;
          }
          break;
        case 4:
          if(gameController.keyK){
            score += 10;
            combo++;
          }
          break;
      }
    }
    //bad
    else if(notes.get(i).getY() > 580){
      notes.get(i).outBox();
      switch(lane){
        case 1:
          if(gameController.keyS){
            score += 10;
            combo = 0;
          }
          break;
        case 2:
          if(gameController.keyD){
            score += 10;
            combo = 0;
          }
          break;
        case 3:
          if(gameController.keyJ){
            score += 10;
            combo = 0;
          }
          break;
        case 4:
          if(gameController.keyK){
            score += 10;
            combo = 0;
          }
          break;
      }
    }
  }
  
  //out boundary note
  for(int i=0; i<notes.size(); i++){
    if(notes.get(i).getY() > 590){
      //reset combo
      combo = 0;
      //delete note
      deleteNote(i);
    }
  }
  
  
  
}

void deleteNote(int index){
    notes.remove(index);
}

void btnStart(){
  gameStart();
  isStart = true;
}
