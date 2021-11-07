import processing.video.*;

class Calo{
   PImage calo,paper,negative;
   int imgHeight=700;
   int imgWidth=700;
   
   Calo(){
     calo=loadImage("calo.png");
     paper=loadImage("calo_paper.png");
     negative=loadImage("calo_negative.png");   
     
   }
   
   void displayNegative(){
     tint(255,200);
     image(negative, 0, 0,imgWidth,imgHeight);      
   }
   
   void displayPaper(float degree){
     tint(255,degree);
     image(paper, 0, 0,imgWidth,imgHeight);      
   }
   
   void displayCalo(float degree){
     tint(255,degree);
     image(calo, 0, 0,imgWidth,imgHeight);     
   }
   
   int getWidth(){
     return imgWidth;
   }
   
   int getHeight(){
     return imgHeight;
   }
   
   void setWidth_Height(int x){
     imgHeight=x;
     imgWidth=x;
   }
   

}
