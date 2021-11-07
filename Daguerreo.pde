class Daguerreo{
   
  PImage dague,metal;
  PShader shader;
  int imgHeight=700;
  int imgWidth=700;
   
   Daguerreo(){
     dague=loadImage("daguerreo.png");    
     metal=loadImage("daguerreo_metal.png");     
   }
   
   void displayDague(int degree){
     tint(255,degree);
     //shader(shader);
     image(dague, 0, 0,imgWidth,imgHeight); 

   }
   
   void displayMetal(int degree){
     tint(255,degree);
     image(metal, 0, 0,imgWidth,imgHeight);      
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
