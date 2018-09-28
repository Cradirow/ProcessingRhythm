class GameController{
  public boolean keyS;
  public boolean keyD;
  public boolean keyJ;
  public boolean keyK;
  
  GameController(){}
  
  public void update(){
    if(key == 's') keyS = true;
    else keyS = false;
    
    if(key =='d') keyD = true;
    else keyD = false;
    
    if(key == 'j') keyJ = true;
    else keyJ = false;
    
    if(key == 'k') keyK = true;
    else keyK = false;
  }
  
}
