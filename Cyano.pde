class Cyano{
   PImage cyano,exposed,paper,negative,waterPic;
   int imgHeight=700;
   int imgWidth=700;
   
   Cyano(){
     cyano=loadImage("cyano.jpg");
     paper=loadImage("cyano_paper.png");
     exposed=loadImage("cyano_exposed.jpg");
     negative=loadImage("cyano_negative.jpg");
   }
   
   void displayExposed(int de){
     tint(255,de);     
     image(exposed, 0, 0,imgWidth,imgHeight); 

   }
   
   void displayNegative(){
     tint(255,200);
     image(negative, 0, 0,imgWidth,imgHeight);      
   }
   
   void displayPaper(int de){
     tint(255,de);
     image(paper, 0, 0,imgWidth,imgHeight);      
   }
   
   void displayCyano(){
     tint(255,255);
     image(cyano, 0, 0,imgWidth,imgHeight);     
   }
   
   void displayMovie(Movie m){     
     tint(255, 255);
     image(m, 0, 0);     
   }
   
   void movieEvent(Movie m) {
    m.read();
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
