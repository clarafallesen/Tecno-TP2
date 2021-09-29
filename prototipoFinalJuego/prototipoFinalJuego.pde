import processing.sound.*;

import fisica.*;

import TUIO.*;

FWorld mundo;

Canion c1, c2;

SoundFile fondo, salto, splash, crack, llamas, viento, perdiste;

Plataforma [] plataformas;
Plataforma hielo, agua, lavaPiso;

Personaje bolaLava, bolaPiedra;


String pantallas, tipoBola;

PImage portada, perder, imgVidas, pantallaFondo;

int vidas, texto;

float posy;

Boolean removerBala = false;

boolean yaPerdi = false;

PFont fuente;

void setup() {

  size(800, 1000);

  pantallas = "portada";
  portada = loadImage("portada.jpg");
  perder = loadImage("perdiste.jpg");
  imgVidas = loadImage("bola de lava.png");

  fondo = new SoundFile (this, "cancion3.mpeg");
  salto = new SoundFile( this, "salto.mp3");
  splash=new SoundFile (this, "agua.mp3");
  crack = new SoundFile (this, "hielo.mp3");
  llamas = new SoundFile ( this, "llamas.mp3");
  viento = new SoundFile (this, "viento.mp3");
  perdiste = new SoundFile (this, "perder.mp3");
  
  tuioClient = new TuioProcessing(this);

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges(0, -200, width, height+200);
  
  mundo.setGravity(0,700);

  c1= new Canion( 15, height*0.8);
  c2= new Canion( 770, height*0.8);

  vidas = 3;
  texto = 0;
  
  fuente = loadFont("ArialRoundedMTBold-57.vlw");
  
  pantallaFondo = loadImage("fondo.jpg");
  posy = 0;
  
  //------------------------------Plataformas de metal----------------------------------------
  int p=6;
  plataformas = new Plataforma[p];
  for (int i = 0; i < p; i++) {

    plataformas [i] = new Plataforma(175, 81);
    float _x = random(100, width-100);   //200*(i%4+1);
    float _y = ( i * (height+400)/6);
    plataformas[i].inicializar(_x, _y, "hierro");
    mundo.add(plataformas[i]);
  }

  //----------------------Parte del personaje (bola) (por ahora de lava)----------------------

  bolaLava = new Personaje (75, "bola de lava" );
  bolaLava.inicializar(width/2, height*0.4);

  //----------------------Plataformas que sacan vidas------------------------------

  hielo = new Plataforma(175, 81);
  agua = new Plataforma(175, 81);
  lavaPiso = new Plataforma(175, 81);
  mundo.add(hielo);
  mundo.add(agua);
  mundo.add(lavaPiso);
  float _x = (random(150, width-100));
  float _y = (height)/10;
  hielo.inicializar(_x/0.5, _y*int(random(1,3)), "hielo");
  agua.inicializar(_x, _y*int(random(3,7)), "agua");
  lavaPiso.inicializar(random(100,width), _y*int(random(1,5)), "lava");

  fondo.pause();
}

void draw() {

  image(pantallaFondo,0,posy--);
  image(pantallaFondo,0,2000 + posy--);
  if (posy == -2000){
  posy=0;
  
  }
  mundo.step();
  mundo.draw();
    
  if (frameCount%10==0) {
    c1.disparar( mundo,1 );
    c2.disparar( mundo,2 );
    
  }
  //--------------------------Mover plataformas------------------
  
  lavaPiso.mover();
  agua.mover();
  hielo.mover();

  for (int i = 0; i < 6; i++) {
    plataformas[i].mover();
  }

  if (pantallas.equals("portada")) {

    image(portada, 0, 0);
    fondo.pause();
  } else if (pantallas.equals("juego")) {
    
    pushStyle();
    imageMode(CENTER);
    c1.dibujar(1);
    c2.dibujar(2);
    texto++;
    println(texto);
    popStyle();

    if (vidas==3) {

      image(imgVidas, 50, 10);
      image(imgVidas, 125, 10);
      image(imgVidas, 203, 10);
    } else if (vidas == 2) {

      image(imgVidas, 50, 10);
      image(imgVidas, 125, 10);
    } else if (vidas == 1) {

      image(imgVidas, 50, 10);
    }
  }
  if (vidas <=0) {

    bolaLava.matar();
    mundo.remove(bolaLava);
    bolaPiedra.matar();
    mundo.remove(bolaPiedra);
    pantallas = "perdiste";
    
    if(!yaPerdi){
      perdiste.play();
      yaPerdi=true;
    }
  }
 if (pantallas.equals("perdiste")&&(yaPerdi = true)) {

    image(perder, 0, 0);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    fill(0);
    text("PUNTAJE   " + texto/50, width/2, height/2 - 100);
    fondo.pause();
    viento.pause();
  }

  if (bolaLava.getY()>height+50) {

    bolaLava.matar();
    mundo.remove(bolaLava);
    pantallas = "perdiste";
    if(!yaPerdi){
      perdiste.play();
    yaPerdi=true;
    }
  }
  
 if(bolaPiedra!=null){
  if (bolaPiedra.getY()>height+50) {

    if(!yaPerdi){
      perdiste.play();
      yaPerdi=true;
    }
    bolaPiedra.matar();
    mundo.remove(bolaPiedra);
    pantallas = "perdiste";
  }
 }
  
  if(posy>height*2){
    posy = 0;
  }
  ArrayList <TuioObject> listadoObjetosTuio = tuioClient.getTuioObjectList();
    for (int i = 0; i <listadoObjetosTuio.size(); i++) {
      TuioObject patronAux = listadoObjetosTuio.get(i);
      ID = patronAux.getSymbolID();
        if (pantallas.equals("portada") ){
          if (ID == 2){
          pantallas = "juego";
          viento.play();
          viento.loop();
          fondo.play();
          fondo.loop();
          mundo.add(bolaLava);
          bolaLava.setPosition(width/2, height*0.4);
        }
     }
    
    else if (pantallas.equals("perdiste")){
       if(ID == 3){
      pantallas = "portada";
      vidas = 3;
      yaPerdi= false;
      if(bolaLava!=null){
      if(!bolaLava.vivo){
      bolaLava.reiniciar();
      }
      }
      if(bolaPiedra!=null){
      if(!bolaPiedra.vivo){
      bolaPiedra.reiniciar();
      }
      }
      texto=0;
       }
    }
  }
}

void contactStarted(FContact contacto) {

  //todo esto para saber si los dos objetos colisionaron
  //body1 y body 2 los obtenemos del contacto
  FBody _body1 = contacto.getBody1();
  FBody _body2 = contacto.getBody2();

  if ((_body1.getName() == "bola de lava" && (_body2.getName() == "hierro"))
    ||(_body2.getName()=="bola de lava"&&(_body1.getName() == "hierro"))) {

    salto.play();
  }
  if ((_body1.getName() == "bola de lava" && (_body2.getName() == "lava"))
    ||(_body2.getName()=="bola de lava"&&(_body1.getName() == "lava"))) {

    salto.play();
  }

  if ((_body1.getName() == "bola de piedra" && (_body2.getName() == "hierro"))
    ||(_body2.getName()=="bola de piedra" &&(_body1.getName() == "hierro"))) {

    salto.play();
  }
  //condicion para cambie algo en el personaje cuando toca ciertas plataformas
  if ((_body1.getName() == "bola de lava" && _body2.getName() == "hielo")
    || (_body2.getName() == "bola de lava" && _body1.getName() == "hielo")) {

    mundo.remove(hielo);

    if (bolaLava.vivo) {

      crack.play();
    }
  }
  if ((_body1.getName() == "bola de lava" && _body2.getName() == "agua")
    || (_body2.getName() == "bola de lava" && _body1.getName() == "agua")) {

    if (bolaLava.vivo) {
      
      splash.play();
      bolaPiedra = new Personaje(75, "bola de piedra");
      bolaPiedra.inicializar(bolaLava.getX(), bolaLava.getY());
      mundo.remove(bolaLava);
      mundo.add(bolaPiedra);
      vidas--;
    }
  }
  if ((_body1.getName() == "bola de piedra"  && _body2.getName() == "hielo")
    || (_body2.getName() == "bola de piedra" && _body1.getName() == "hielo")) {

    mundo.remove( hielo);

    if (bolaPiedra.vivo) {
      crack.play();
    }
  }
  if ((_body1.getName() == "bola de piedra" && _body2.getName() == "agua")
    || (_body2.getName() == "bola de piedra" && _body1.getName() == "agua")) {

    if (bolaPiedra.vivo) {

      splash.play();
     
    }
  }
  if ((_body1.getName() == "bola de piedra" && _body2.getName() == "lava")
    || (_body2.getName() == "bola de piedra" && _body1.getName() == "lava")) {

    if (bolaPiedra.vivo) {

      llamas.play();
      bolaLava = new Personaje(75, "bola de lava");
      bolaLava.inicializar(bolaPiedra.getX(), bolaPiedra.getY());
      mundo.remove(bolaPiedra);
      mundo.add(bolaLava);
    }
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "hierro"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "hierro"))) {

    if (_body1.getName().equals("bala")) {
      mundo.remove( _body1 );
    } else if (_body2.getName().equals("bala")) {
      mundo.remove( _body2 );
    }
  }


  if ((_body1.getName() == "bala" && (_body2.getName() == "hielo"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "hielo"))) {

    if (_body1.getName().equals("bala")) {
      mundo.remove( _body1 );
    } else if (_body2.getName().equals("bala")) {
      mundo.remove( _body2 );
    }
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "lava"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "lava"))) {

    if (_body1.getName().equals("bala")) {
      mundo.remove( _body1 );
    } else if (_body2.getName().equals("bala")) {
      mundo.remove( _body2 );
    }
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "agua"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "agua"))) {

    if (_body1.getName().equals("bala")) {
      mundo.remove( _body1 );
    } else if (_body2.getName().equals("bala")) {
      mundo.remove( _body2 );
    }
  }
}
