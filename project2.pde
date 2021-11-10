import processing.video.*;

PImage img;
float offsetX = 0,offsetY=0;
float easing = 0.2;
float eyeX=0,eyeY=0;
int num=4;
int imgHeight=500;
int imgWidth=500;
float interval;
int state=0,stateMax=3;
int mode=9;
int count=0,lastCount=0;
int cameraZ=1100;
int calonum=1;

GelatinSilver gelatinSilver;
Digital digital;
Cyano cyano;
Calo calo;
Daguerreo daguerreo;
Movie m;


void setup() {
  frameRate(30);
  size(1200, 900,P3D);
    gelatinSilver= new GelatinSilver();
    digital = new Digital();
    cyano = new Cyano();
    calo = new Calo();
    daguerreo = new Daguerreo();
    m = new Movie (this, "cyano_video.mov");
    img=loadImage("gelatinsilver_negative.jpg");   
       

    
    
}

void draw(){
  background(0);
  
  float dx = eyeX*500 - offsetX;
  offsetX += dx * easing;
  
  float dy =  eyeY*500- offsetY;
  offsetY += dy * easing;
  
  camera(offsetX, offsetY, cameraZ, // eyeX, eyeY, eyeZ
         0, 0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
                  
  interval=map(mouseX,0,width,0,200);
  
  switch(mode){
    case 1:
    cameraZ=1200;daguerreoMode();daguerreo.setWidth_Height(700);break;
    case 2:
    cameraZ=1400;caloMode();calo.setWidth_Height(700);break;
    case 3:
    cameraZ=800;cyanoMode();cyano.setWidth_Height(700);break;
    case 4:
    cameraZ=1400;gelatinsilverMode();gelatinSilver.setWidth_Height(700);break;
    case 5:
    cameraZ=800;digitalMode();digital.setWidth_Height(700);break;
    case 0:
    cameraZ=2000;lastPage();break;
    case 9:
    cameraZ=1600;firstPage();break;
  }  
}




void keyPressed() {
  if (keyCode == UP) {
    eyeY+=1;
  } else if(keyCode == DOWN) {
    eyeY-=1;    
  } else if(keyCode == LEFT) {
    eyeX+=1;
  } else if(keyCode == RIGHT) {
    eyeX-=1;
  }
  if(key==32){
    if(mode!=0&&mode!=9){
      changeState();
    }
     
  }
  
  if(key=='1' ){
    mode=1;state=0;
  }
  if(key=='2' ){
    mode=2;state=0;
  }
  if(key=='3' ){
    mode=3;state=0;count=0;
  }
  if(key=='4' ){
    mode=4;state=0;
  }
  if(key=='5' ){
    mode=5;state=0;
  }
  if(key=='0' ){
    mode=0;state=0;
  }
}


void lastPage(){
  
  

  
 //daguerreo
    daguerreo.setWidth_Height(450);
    if(lastCount!=-1){lastCount+=1;}
    if(lastCount>=100){count=-1;}
    pushMatrix();
    translate(-500,-500,2*interval);
    translate(-daguerreo.getWidth()/2,-daguerreo.getHeight()/2,0);
    if(lastCount==-1){
    daguerreo.displayDague(255);
  }
    else{daguerreo.displayDague(int(map(lastCount,0,100,0,255)));daguerreo.displayMetal(255-int(map(lastCount,0,100,0,255)));}
    
    popMatrix();
    
 //calo
    for(int i=0;i<5;i+=1){
    pushMatrix();
    calo.setWidth_Height(450);
    translate(500,-500,1*interval);
    translate(-imgWidth/2,-imgHeight/2,interval*(i-int(num/2)));  
    
    if(i==0){calo.displayCalo(255);}  
    if(i==1){calo.displayCalo(255);}
    if(i==2){calo.displayCalo(255);}            
    if(i==3){calo.displayCalo(255);}          
    if(i==4){calo.displayNegative();}     
    popMatrix();
  }


 //cyano
 pushMatrix();
 cyano.setWidth_Height(450);
 translate(0,0,-0.3*interval);
   for(int i=0;i<num;i+=1){
    pushMatrix();
    translate(-imgWidth/2,-imgHeight/2,interval*(i-int(num/2)+1));      
    if(i==0){cyano.displayCyano();} 
    if(i==1){cyano.displayExposed();}            
    if(i==2){cyano.displayPaper();}          
    if(i==3){cyano.displayNegative();}               
    popMatrix();
  }
  popMatrix();
    


  //gelatinSilver
 
  gelatinSilver.setWidth_Height(450);
  for(int i=0;i<num;i+=1){
    pushMatrix();
    translate(-500,500,-1*interval);
    translate(-imgWidth/2,-imgHeight/2,interval*1.5*(i-int(num/2)+1));  
    
    if(i==0){gelatinSilver.displayEnlarge(int(map(mouseX,0,width,400,800)));}            
    if(i==1){gelatinSilver.displayNegative(200);}          
    if(i==2){gelatinSilver.displayFilm();}      
    if(i==3){gelatinSilver.displayExpose();}      
    popMatrix();
  }
  
   //digital
  digital.setWidth_Height(450);
  for(int i=0;i<5;i+=1){
    pushMatrix();    
    translate(500,500,-2*interval);
    translate(-imgWidth/2,-imgHeight/2,interval*(i-int(num/2)));  
    digital.processImg();
   
    if(i==1){digital.layerBrightness();}
    if(i==2){digital.layerBlue();}            
    if(i==3){digital.layerGreen();}          
    if(i==4){digital.layerRed();} 
    if(i==0){digital.displayImg();}      
    popMatrix();
  }
}




void gelatinsilverMode(){
  gelatinSilver.setWidth_Height(700);
  num=4;
  if(state==0){
    count=0;
    pushMatrix();
    translate(-gelatinSilver.getWidth()/2,-gelatinSilver.getHeight()/2,0);
    gelatinSilver.displayFilm();
    popMatrix();
  }  
  
  if(state==1){
    count+=1;    
    if(count>=50){
      count=0; 
      state=2;
    }
    background(sin(map(count,0,50,1,0))*255);  
    pushMatrix();
    translate(-gelatinSilver.getWidth()/2,-gelatinSilver.getHeight()/2,0);
    int de=int(map(count,0,40,0,100));
    gelatinSilver.displayNegative(de);
    popMatrix();
    
    
  }
  
  if(state==2){   
    num=3; //asdjhashdo a
  for(int i=0;i<num;i+=1){
    pushMatrix();   
    gelatinSilver.setZRange(int(interval*3*(0-int(num/2)+1)),int(interval*3*(2-int(num/2)+1)));
    popMatrix();
    
    pushMatrix();
    translate(-gelatinSilver.getWidth()/2,-gelatinSilver.getHeight()/2,0);
    translate(0,0,interval*3*(i-int(num/2)+1));      
    if(i==0){gelatinSilver.displayEnlarge(int(map(mouseX,0,width,700,2100)));}            
    if(i==2){gelatinSilver.displayNegative(200);}          
    //if(i==3){gelatinSilver.displayFilm();}           
    popMatrix();
  }
  }
}



void digitalMode(){
  digital.setWidth_Height(700);
  if(state==0){
    pushMatrix();
    translate(-digital.getWidth()/2,-digital.getHeight()/2,0);
    digital.displayImg();
    popMatrix();
  }
  if(state==1){
    for(int i=0;i<5;i+=1){
    pushMatrix();
    translate(-digital.getWidth()/2,-digital.getHeight()/2,0);
    translate(0,0,interval*(i-int(num/2)));  
    digital.processImg();
    
    if(i==1){digital.layerBrightness();}
    if(i==2){digital.layerBlue();}            
    if(i==3){digital.layerGreen();}          
    if(i==4){digital.layerRed();} 
    if(i==0){digital.displayImg();}      
    popMatrix();
  }
  }
  if(state==2){
    state=0;  
  }
}

void daguerreoMode(){
  
  if(state==0){
    pushMatrix();
    translate(-daguerreo.getWidth()/2,-daguerreo.getHeight()/2,0);
    daguerreo.displayMetal(255);
    popMatrix();
    
}
  
  if(state==1){ 
    if(count!=-1){count+=1;}
    if(count>=100){count=-1;}
    pushMatrix();
    translate(-daguerreo.getWidth()/2,-daguerreo.getHeight()/2,0);
    if(count==-1){daguerreo.displayDague(255);}
    else{daguerreo.displayDague(int(map(count,0,100,0,255)));daguerreo.displayMetal(255-int(map(count,0,100,0,255)));}
    
    popMatrix();
  }
  
  if(state==2){
    count=0;
    state=1;       
  }
  

}

void caloMode(){
    
  if(state==0){
      pushMatrix();
      translate(-calo.getWidth()/2,-calo.getHeight()/2,0);
      calo.displayNegative();
      popMatrix();
  }
  if(state==1){
      if(count!=-1){
        count+=1;
        background(255-map(count,0,100,0,255));
        }  
      if(count>=150){
        count=-1;
        background(0);
        }     
      for(int i=0;i<calonum-1;i++){
        pushMatrix();
        int x= (i-calonum/2)*(calo.getWidth()+80);
        translate(x,-calo.getHeight()/2,0);
        calo.displayCalo(200);
        popMatrix();
      }

      int x= (calonum-1-calonum/2)*(calo.getWidth()+80);      
      pushMatrix();              
        translate(x,-calo.getHeight()/2,0);
        calo.displayPaper(255-map(count,0,100,0,255));
      popMatrix();
      
      pushMatrix();              
        translate(x,-calo.getHeight()/2,0);   
        if(count==-1){
        calo.displayCalo(255);}else{
        calo.displayCalo(map(count,0,100,0,255));}
        
      popMatrix();
            
      pushMatrix();             
         
        if(count!=-1&&count<150){
          translate(x,-calo.getHeight()/2,count*2+100); 
        }else{
         translate(x,-calo.getHeight()/2,400); 
        }
        calo.displayNegative();
      popMatrix();


  }
  if(state==2){
    calonum+=1;  
    count=0;
    state=1;    
    
  }  
}

void cyanoMode(){  
  if(state==0){
    pushMatrix();
    translate(-cyano.getWidth()/2,-cyano.getHeight()/2,0);
    cyano.displayExposed();
    popMatrix();
  }
  if(state==1){
    count+=1;    
    /*
    if(count>=650){
      count=0;       
    }
    */
    
    background(map(count,0,500,0,255));
    pushMatrix();
    translate(-cyano.getWidth()/2,-cyano.getHeight()/2,0);
    image(m, 0, 0,700,700); 
    m.play();
    m.noLoop();  
    popMatrix();
    
  }
  if(state==2){ 
    background(255);
  for(int i=0;i<num;i+=1){
    pushMatrix();
    textSize(32);textAlign(CENTER);fill(37,66,105);
    translate(-cyano.getWidth()/2,-cyano.getHeight()/2+20,0);
    translate(0,0,1.5*interval*(i-int(num/2)+1));      
    if(i==0){cyano.displayCyano();text("Cyano-photograph",cyano.getWidth()/2,-20);} 
    if(i==1){cyano.displayExposed();text("Exposed-paper",cyano.getWidth()/2,-20);}            
    if(i==2){cyano.displayPaper();text("Photosensitive-paper",cyano.getWidth()/2,-20);}          
    if(i==3){cyano.displayNegative();text("Negative-film",cyano.getWidth()/2,-20);}               
    popMatrix();
  } 
  }
}

void changeState(){
  state+=1;
  if(state>stateMax){
    state=0;  
  } 
}

void firstPage(){ 
  //daguerreo
  pushMatrix();
    translate(-500,-500,0);
    translate(-daguerreo.getWidth()/2,-daguerreo.getHeight()/2,4*interval);
    daguerreo.setWidth_Height(450);
    daguerreo.displayDague(255);   
  popMatrix();
  
  
  //calo
  
  pushMatrix();
    translate(500,-500,0);
    translate(-250,-250,2*interval);
    calo.setWidth_Height(450);
    calo.displayCalo(255);    
  popMatrix();
  
  //cyano
 
  pushMatrix();
    translate(0,0,0);
    translate(-250,-250,-0.3*interval);
    cyano.setWidth_Height(450);
    cyano.displayCyano();    
  popMatrix();
  
  //gelatinSilver
  
  pushMatrix();
    translate(-500,500,0);
    translate(-250,-250,-2*interval);
    gelatinSilver.setWidth_Height(450);
    gelatinSilver.displayEnlarge(450);    
  popMatrix();
  
  //digital
  
  pushMatrix();
    translate(500,500,0);
    translate(-digital.getWidth()/2,-digital.getHeight()/2,-4*interval);
    digital.setWidth_Height(450);
    digital.displayImg(); 
  popMatrix();
  
} 

void movieEvent(Movie m) {
  m.read();
}
