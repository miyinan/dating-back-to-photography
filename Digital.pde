class Digital{
  PImage img;
  int pixSize=20;
  int redList[][],blueList[][],greenList[][];
  float brightnessList[][];
  int imgHeight=700;
  int imgWidth=700;
  PFont mono;
  
  
  Digital(){
    
    img=loadImage("digital.jpg");    
    redList = new int[img.width/pixSize][img.height/pixSize];
    greenList = new int[img.width/pixSize][img.height/pixSize];
    blueList = new int[img.width/pixSize][img.height/pixSize];
    brightnessList = new float[img.width/pixSize][img.height/pixSize];
    
    mono=createFont("PPNeueMachina-Regular.otf",128);
  }
  
  void processImg(){
    for(int i=0;i<imgWidth/pixSize;i+=1){
      for(int j=0;j<imgHeight/pixSize;j+=1){
      
        int x0=int(map(i,0,imgWidth/pixSize,0,img.width));
        int y0=int(map(j,0,imgHeight/pixSize,0,img.height));
        color pixCol=img.get(x0,y0);
      
        redList[i][j] = pixCol >> 16 & 0xFF;
        greenList[i][j] = pixCol >> 8 & 0xFF;
        blueList[i][j] = pixCol & 0xFF;
        brightnessList[i][j] = brightness(pixCol);
      }
    }
    
  }
  
  void layerRed(){
    for(int i=0;i<imgWidth/pixSize;i+=1){
      for(int j=0;j<imgHeight/pixSize;j+=1){
        pushMatrix();
        int value=redList[i][j];
        translate(i*pixSize,j*pixSize,0);
        textFont(mono);
        fill(value,0,0,map(value,0,255,150,255));        
        textSize(map(value,0,255,10,10));
        
        text(value,0,0,0);        
        popMatrix();
      }
    }
  }
  
  void layerGreen(){
    for(int i=0;i<imgWidth/pixSize;i+=1){
      for(int j=0;j<imgHeight/pixSize;j+=1){
        pushMatrix();
        int value=greenList[i][j];
        fill(0,value,0,map(value,0,255,150,255));
        translate(i*pixSize,j*pixSize,0);
        textFont(mono);
        textSize(map(value,0,255,10,20));
        text(value,0,0,0);        
        popMatrix();
      }
    }
  }
  
  void layerBlue(){
    for(int i=0;i<imgWidth/pixSize;i+=1){
      for(int j=0;j<imgHeight/pixSize;j+=1){
        pushMatrix();
        int value=blueList[i][j];
        fill(0,0,value,map(value,0,255,150,255));
        translate(i*pixSize,j*pixSize,0);
        textFont(mono);
        textSize(map(value,0,255,10,20));
        text(value,0,0,0);        
        popMatrix();
      }
    }
  }
  
  void layerBrightness(){
    for(int i=0;i<imgWidth/pixSize;i+=1){
      for(int j=0;j<imgHeight/pixSize;j+=1){
        pushMatrix();
        float value=brightnessList[i][j];
        fill(value);
        translate(i*pixSize,j*pixSize,0);
        textFont(mono);
        textSize(map(value,0,255,10,20));
        text(value,0,0,0);        
        popMatrix();
      }
    }
  }
    
  void displayImg(){
    tint(255,255);
    image(img, 0, 0,imgWidth,imgHeight);
  }
  
  void setWidth_Height(int x){
     imgHeight=x;
     imgWidth=x;
   }  
  
  int getWidth(){
     return imgWidth;
   }
   
   int getHeight(){
     return imgHeight;
   }
}
