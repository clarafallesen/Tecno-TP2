import ddf.minim.*;

import processing.sound.*;

import fisica.*;

FWorld mundo;

Canion c1, c2;

SoundFile fondo,salto, splash, crack, llamas;

ArrayList <Plataforma> plataformas, bordeDer, bordeIzq;

Personaje bolaLava;
Bola bolaPiedra;

Obstaculo hielo, agua, lava;

String pantallas;

PImage portada, perder, imgVidas;

int vidas;

void setup(){
  
  size(600,800);
  
  pantallas = "portada";
  portada = loadImage("portada.jpg");
  perder = loadImage("perdiste.jpg");
  imgVidas = loadImage("bola de lava.png");
  
  fondo = new SoundFile (this, "cancion.mp3");
  salto = new SoundFile( this, "salto.mp3");
  splash=new SoundFile (this, "agua.mp3");
  crack = new SoundFile (this, "hielo.mp3");
  llamas = new SoundFile ( this, "llamas.mp3");
  
  Fisica.init(this);
  mundo = new FWorld();
  
  c1= new Canion( 5,height*0.75,180);
  c2= new Canion( 595, height*0.75,-180);
  
  vidas = 3;
  
  //------------------------------Plataformas de metal----------------------------------------
  
  plataformas = new ArrayList <Plataforma>();
  for (int i = 0; i < 6; i++){
    
    Plataforma p = new Plataforma(115,50);
    float _x = (i * random(0,200) - 50);
    float _y = (i * height/5 - 50);
    p.inicializar(_x, _y);
    mundo.add(p);
    plataformas.add(p);
  }
  //------------------------------Plataformas de piso-------------------------------------
  
  bordeDer = new ArrayList <Plataforma>();
  Plataforma bordeDer = new Plataforma(5,height);
  bordeDer.inicializar(width,0);
  mundo.add(bordeDer);
  plataformas.add(bordeDer);
  
  bordeIzq = new ArrayList <Plataforma>();
  Plataforma bordeIzq = new Plataforma(5,height);
  bordeIzq.inicializar(0,0);
  mundo.add(bordeIzq);
  plataformas.add(bordeIzq);
  
  //----------------------Parte del personaje (bola) (por ahora de lava)----------------------
  
  bolaLava = new Personaje (50);
  bolaLava.inicializar(width/2, height*0.60);
  mundo.add(bolaLava);
 
  
  //----------------------Plataformas que sacan vidas------------------------------
  
  hielo = new Obstaculo(115,50,"hielo");
  agua = new Obstaculo(115,50,"agua");
  lava = new Obstaculo(115,50,"lava");
  mundo.add(hielo);
  mundo.add(agua);
  mundo.add(lava);
  float _x = (1.5 * random(0,200) - 50);
  float _y = (3.5 * height/5 - 50);
  hielo.inicializar(_x,_y);//(4 * width/4 - 50, 4 * height/4 - 50);
  agua.inicializar(_y,_x);//(width/2,height/2);
  lava.inicializar(_y*2.5, _x);
}

void draw(){
  
  if(pantallas.equals("portada")){
    
    image(portada,0,0);
    fondo.pause();
  }
  else if(pantallas.equals("juego")){
    
    background(#6AC7FF);
    mundo.step();
    mundo.draw();
    bolaLava.actualizar();
  //fondo.play();
  //fondo.loop();
    c1.responderATeclasEstado();
    c1.dibujar();
    c2.responderATeclasEstado();
    c2.dibujar();
    
      if(vidas==3){
    
        image(imgVidas,100,10);
        image(imgVidas,150,10);
        image(imgVidas,200,10);
        textSize(35);
        fill(0);
        text("X3",50,45);
    }
    else if(vidas == 2){
      image(imgVidas,100,10);
      image(imgVidas,150,10);
      textSize(35);
      fill(0);
      text("X2",50,45);
  }
  else if(vidas == 1){
      image(imgVidas,100,10);
      textSize(35);
      fill(0);
      text("X1",50,45);
  }
 }
  
  if (vidas <=0){
    bolaLava.matar();
    mundo.remove(bolaLava);
    bolaPiedra.matar();
    mundo.remove(bolaPiedra);
    pantallas = "perdiste";
  }
  println(vidas);
  
   if(pantallas.equals("perdiste")){
    
    image(perder,width,height);
    fondo.pause();
  }
}

void keyPressed(){
  
  if (key=='d'){
     c2.disparar( mundo );
  }
  if (key=='a'){
    c1.disparar( mundo );
  }
  
  pantallas = "juego";
  
  if(key==ENTER && pantallas.equals("perdiste")){
    pantallas = "portada";
  }
} 

void contactStarted(FContact contacto){
  
  //todo esto para saber si los dos objetos colisionaron
  //body1 y body 2 los obtenemos del contacto
  FBody _body1 = contacto.getBody1();
  FBody _body2 = contacto.getBody2();
  
  if((_body1.getName() == "personaje" && (_body2.getName() == "plataforma")) 
  ||(_body2.getName()=="personaje"&&(_body1.getName() == "plataforma"))){
    
    salto.play();
  }
  
  if((_body1.getName() == "personaje2" && (_body2.getName() == "plataforma")) 
  ||(_body2.getName()=="personaje2" &&(_body1.getName() == "plataforma"))){
    
    salto.play();
  }
  //condicion para cambie algo en el personaje cuando toca ciertas plataformas
  if ((_body1.getName() == "personaje" && _body2.getName() == "hielo")
  || (_body2.getName() == "personaje" && _body1.getName() == "hielo")){
    
    mundo.remove( hielo);
    
    if (bolaLava.vivo){
      
      crack.play();
   // bolaLava.matar();
    //mundo.remove(bolaLava);
    //pantallas = "perdiste";
      
    }
  }
  if ((_body1.getName() == "personaje" && _body2.getName() == "agua")
  || (_body2.getName() == "personaje" && _body1.getName() == "agua")){
    
    if(bolaLava.vivo){
      
      splash.play();
    //bolaLava.matar();
      mundo.remove(bolaLava);
      bolaPiedra = new Bola(50);
      bolaPiedra.inicializar(width/2, height*0.60);
      mundo.add(bolaPiedra);
      bolaPiedra.actualizar();
      vidas--;
    /*
      mundo.remove(bolaLava);
      pantallas = "perdiste";*/
    }
  }
  if ((_body1.getName() == "personaje2"  && _body2.getName() == "hielo")
  || (_body2.getName() == "personaje2" && _body1.getName() == "hielo")){
    
    mundo.remove( hielo);
    
    if (bolaLava.vivo){
      
      crack.play();
    //bolaLava.matar();
    //mundo.remove(bolaLava);
      
      
    }
  }
  if ((_body1.getName() == "personaje2" && _body2.getName() == "agua")
  || (_body2.getName() == "personaje2" && _body1.getName() == "agua")){
    
    if(bolaLava.vivo){
      
      splash.play();
      vidas--;
    }
  }
    if ((_body1.getName() == "personaje2" && _body2.getName() == "lava")
  || (_body2.getName() == "personaje2" && _body1.getName() == "lava")){
    
    if(bolaLava.vivo){
      
      llamas.play();
    //bolaLava.matar();
      mundo.remove(bolaPiedra);
      bolaLava = new Personaje(50);
      bolaLava.inicializar(width/2, height*0.60);
      mundo.add(bolaLava);
      bolaLava.actualizar();
    /*
      mundo.remove(bolaLava);
      pantallas = "perdiste";*/
    }
  }
/*if ((_body1.getName() == "personaje" && _body2.getName() == "bala")
  || (_body2.getName() == "personaje" && _body1.getName() == "bala")){
   
    c1.sacarBalas ( mundo );
    c2.sacarBalas ( mundo );
  }*/
}
