class GelatinSilver{
   PImage enlarge,expose,film,negative,img;
   int imgHeight=700;
   int imgWidth=700;
   Particle pList[][];
   int pixSize=20;  
   float pixSize2;

   
   GelatinSilver(){
     film=loadImage("gelatinsilver_film.jpg");
     enlarge=loadImage("gelatinsilver_enlarge.jpg");
     expose=loadImage("gelatinsilver.jpg");
     negative=loadImage("gelatinsilver_negative.jpg");
     img=loadImage("gelatinsilver_negative.jpg");
     
     pList= new Particle[imgWidth/pixSize][imgHeight/pixSize];     
     for(int i=0;i<imgWidth/pixSize;i++){
      for(int j=0;j<imgHeight/pixSize;j++){
      pList[i][j] = new Particle();
      }
     }     
     this.processImg();
    
   }
   
   void displayExpose(){
     tint(255,200);
     image(enlarge, 0, 0,imgWidth,imgHeight); 

   }
   
   void displayNegative(int de){
     tint(255,de);
     image(negative, 0, 0,imgWidth,imgHeight);      
   }
   
   void displayFilm(){
     tint(255,255);
     image(film, 0, 0,imgWidth,imgHeight);      
   }
   
   void displayEnlarge(int size){
     tint(255,255);
     image(enlarge, -size/2+imgWidth/2, -size/2+imgHeight/2,size,size);     
   }
   
   void setWidth_Height(int x){
     imgHeight=x;
     imgWidth=x;
   }  
   
   void processImg(){      
    for(int i=0;i<imgWidth/pixSize;i+=1){
      for(int j=0;j<imgHeight/pixSize;j+=1){      
        int x0=int(map(i,0,imgWidth/pixSize,0,img.width));
        int y0=int(map(j,0,imgHeight/pixSize,0,img.height));
        color pixCol=img.get(x0,y0);
        pList[i][j].setColor(int(brightness(pixCol)));        
        //pList[i][j].setColor(255);
      }
    }
    }
    
   void setZRange(int z1,int z2){
     for(int i=0;i<imgWidth/pixSize;i++){
      for(int j=0;j<imgHeight/pixSize;j++){
      pList[i][j].setRange(z1,z2);
      pixSize2=map(mouseX,0,width,pixSize,2*pixSize);
      pushMatrix();     
      float zpos=pList[i][j].getZ();
      translate(i*pixSize2-int(map(mouseX,0,width,700,1400))/2
      ,j*pixSize2-int(map(mouseX,0,width,700,1400))/2,0);
      pList[i][j].draw();
      popMatrix();
      }
     }        
   }
   

}
