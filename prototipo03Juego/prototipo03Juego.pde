import ddf.minim.*;

import processing.sound.*;

import fisica.*;

FWorld mundo;

Canion c1, c2;

SoundFile fondo,salto, splash, crack;

ArrayList <Plataforma> plataformas;

Personaje bolaLava;
Bola bolaPiedra;

Obstaculo hielo, agua;

String pantallas;

PImage portada, perder;

void setup(){
  
  size(600,800);
  
  pantallas = "portada";
  portada = loadImage("portada.jpg");
  perder = loadImage("perdiste.jpg");
  
  fondo = new SoundFile (this, "cancion.mp3");
  salto = new SoundFile( this, "salto.mp3");
  splash=new SoundFile (this, "agua.mp3");
  crack = new SoundFile (this, "hielo.mp3");
  
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges(); 
  
  c1= new Canion( 5,height/2 ,180);
  c2= new Canion( 595, height/2,-180);
  
  //------------------------------Plataformas de metal----------------------------------------
  
  plataformas = new ArrayList <Plataforma>();
  for (int i = 0; i < 6; i++){
    
    Plataforma p = new Plataforma(150,50);
    float _x = (i * random(0,200) - 50);
    float _y = (i * height/5 - 50);
    p.inicializar(_x, _y);
    mundo.add(p);
    plataformas.add(p);
  }
  
  //------------------------En esta parte esta la plataforma piso-----------------------
  
  //se carga la clase de las plataformas
  Plataforma piso = new Plataforma(width,10);
  
  //ubicacion de la plataforma de piso
  piso.inicializar(width/2,height - 8);
  
  //aniadimos el objeto FBox dentro de la clase Plataforma piso
  mundo.add(piso);
  
  //----------------------Parte del personaje (bola) (por ahora de lava)----------------------
  
  bolaLava = new Personaje (50);
  bolaLava.inicializar(40,height *0.75);
  mundo.add(bolaLava);
  
  //----------------------Parte del personaje (bola de piedra)-----------
  
  
  
  //----------------------Plataformas que sacan vidas------------------------------
  
  hielo = new Obstaculo(150,50,"hielo");
  agua = new Obstaculo(150,50,"agua");
  mundo.add(hielo);
  mundo.add(agua);
  float _x = (1.5 * random(0,200) - 50);
  float _y = (3.5 * height/5 - 50);
  hielo.inicializar(_x,_y);//(4 * width/4 - 50, 4 * height/4 - 50);
  agua.inicializar(_y,_x);//(width/2,height/2);
}

void draw(){
  
  if(pantallas.equals("portada")){
    
    image(portada,width,height);
    fondo.pause();
  }
  else if(pantallas.equals("juego")){
    
    background(#6AC7FF);
    mundo.step();
    mundo.draw();
    bolaLava.actualizar();
    //ndo.play();
    //ndo.loop();
    c1.responderATeclasEstado();
    c1.dibujar();
    c2.responderATeclasEstado();
    c2.dibujar();
  }
  else if(pantallas.equals("perdiste")){
    
    image(perder,width,height);
    fondo.pause();
  }
}

void keyPressed(){
  if (key=='d'){
    //atraer();
   repelerIzq();
   println("Repele desde la IZQ");
  }
  if (key=='a'){
   repelerDer(); 
   println("Repele desde la DER");
  }
  
  pantallas = "juego";
  
  if ( key==' ' ) {
   c1.disparar( mundo );
   c2.disparar( mundo );
  }
  
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
      bolaLava.matar();
    //mundo.remove(bolaLava);
      pantallas = "perdiste";
      
    }
  }
  if ((_body1.getName() == "personaje" && _body2.getName() == "agua")
  || (_body2.getName() == "personaje" && _body1.getName() == "agua")){
    
    if(bolaLava.vivo){
      
      splash.play();
      bolaLava.matar();
      mundo.remove(bolaLava);
      bolaPiedra = new Bola(50);
      bolaPiedra.inicializar(40,height *0.75);
      mundo.add(bolaPiedra);
      bolaPiedra.actualizar();
    /*
      mundo.remove(bolaLava);
      pantallas = "perdiste";*/
    }
  }
}
