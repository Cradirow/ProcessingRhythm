//library settings
import ddf.minim.*;

//extends class
int maxNote = 1000;
Note[] notes = new Note[maxNote];
GameController gameController = new GameController();

//resources
PImage musicImg;
AudioPlayer player;
Minim minim;

//game settings
int score;
int speed;
boolean isStart = true; //change to false
boolean mouseOver = false;
boolean isMusicOn = false;
int melodyLength = 0;

void setup(){
  size(550,700);
  background(0);
  
  musicImg = loadImage("unity.jpg");
  minim = new Minim(this);
  //Delay();
  player = minim.loadFile("unity.mp3", 2048);
  
  notes[0] = new Note(0,2,1);
  notes[1] = new Note(1,2,1);
  notes[2] = new Note(2,2,1);
  notes[3] = new Note(3,2,1);
}

void draw(){
    
  if(isStart){
    background(255);
    backgroundDraw();
    
    update();
    
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
    moveNote(0);
    moveNote(1);
    moveNote(2);
    moveNote(3);
    
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
    //hit box
    strokeWeight(2);
    fill(255,255,0);
    rect(10,500,420,30);  
    
    //out box rect
    strokeWeight(1.5);
    line(20,0,420,0);
    line(20,0,20,690);
    line(420,0,420,690);
    line(20,690,420,690);
    
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
  notes[index].update();
  notes[index].display();
}

//score in here.
void chkNote(){
}

void btnStart(){
  gameStart();
  isStart = true;
}
