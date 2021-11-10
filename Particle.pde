class Particle{
  float xPos;
  float yPos;  
  float zPos;
  float size;  
  float speedZ;
  int pCol;
  int z1,z2;
  int pixSize=20;
  
  Particle(){    
    speedZ=random(-1,1);
    size=2.0;
    pCol=0;
  }
  
  void setColor(int pixColor){
    pCol=pixColor;  
  }
  
  void setRange(int z3,int z4){
    z1=z3;
    z2=z4;
    zPos=random(z1,z2);    
  }
  
  void setPos(int i, int j){
    xPos=i;
    yPos=j;
  }
  
  float getZ(){
    return zPos;
  }
  void draw(){       
    pushMatrix();
    fill(pCol);
    noStroke();
    float alpha=map(mouseX,0,width,0,3);
    translate(alpha*xPos,alpha*yPos,zPos);
    //println();
    box(size);
    popMatrix();
    
    if(zPos<z1){
      speedZ=-1.0*speedZ;
    }
    if(zPos>z2){
      speedZ=-1.0*speedZ;
    }
  }
}
