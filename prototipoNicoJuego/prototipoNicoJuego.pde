import processing.sound.*;

import fisica.*;

FWorld mundo;

Canion c1, c2;

SoundFile fondo, salto, splash, crack, llamas, viento;

Plataforma [] plataformas;
Plataforma hielo, agua, lavaPiso;

Personaje bolaLava, bolaPiedra;

String pantallas;

PImage portada, perder, imgVidas;

int vidas;

Boolean removerBala = false;

void setup() {

  size(600, 800);

  pantallas = "portada";
  portada = loadImage("portada.jpg");
  perder = loadImage("perdiste.jpg");
  imgVidas = loadImage("bola de lava.png");

  fondo = new SoundFile (this, "cancion.mp3");
  salto = new SoundFile( this, "salto.mp3");
  splash=new SoundFile (this, "agua.mp3");
  crack = new SoundFile (this, "hielo.mp3");
  llamas = new SoundFile ( this, "llamas.mp3");
  viento = new SoundFile (this, "viento.mp3");
  fondo.loop();

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges(0, -200, width, height+200);
  //mundo.setGravity(0,1);

  c1= new Canion( 5, height*0.75, 0);
  c2= new Canion( 595, height*0.75, 180);

  vidas = 3;

  //------------------------------Plataformas de metal----------------------------------------
  int p=6;
  plataformas = new Plataforma[p];
  for (int i = 0; i < p; i++) {

    plataformas [i] = new Plataforma(115, 50);
    float _x = (random(50, width-50));
    float _y = (i * (height+100)/5 - 50);
    plataformas[i].inicializar(_x, _y, "hierro");
    mundo.add(plataformas[i]);
  }

  //----------------------Parte del personaje (bola) (por ahora de lava)----------------------

  bolaLava = new Personaje (50, "bola de lava");
  bolaLava.inicializar(width/2, height*0.60);
  //mundo.add(bolaLava);

  //----------------------Plataformas que sacan vidas------------------------------

  hielo = new Plataforma(115, 50);
  agua = new Plataforma(115, 50);
  lavaPiso = new Plataforma(115, 50);
  mundo.add(hielo);
  mundo.add(agua);
  mundo.add(lavaPiso);
  float _x = (random(150, width));
  float _y = (random(100, height));
  hielo.inicializar(_x, _y, "hielo");//
  agua.inicializar(_x, _y, "agua");//
  lavaPiso.inicializar(width/2, height*0.70, "lava");

  fondo.pause();
}

void draw() {

  background(#6AC7FF);
  mundo.step();
  mundo.draw();
  c2.disparar( mundo );
  c1.disparar( mundo );

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

    //   pushMatrix();
    //con este translate supuestamente la camara seguiria a la pelota
    //pero a mi no me anduvo, solo lo dejo porque en el video lo muestra asi
    //  translate(0,height*0.60-bolaLava.getY());
    //   popMatrix();
    pushStyle();
    imageMode(CENTER);
    c1.responderATeclasEstado(1);
    c1.dibujar("ventiladorc2.png");
    c2.responderATeclasEstado(2);
    c2.dibujar("ventiladorc2.png");
    popStyle();

    if (vidas==3) {

      image(imgVidas, 100, 10);
      image(imgVidas, 150, 10);
      image(imgVidas, 200, 10);
      textSize(35);
      fill(0);
      text("X3", 50, 45);
    } else if (vidas == 2) {

      image(imgVidas, 100, 10);
      image(imgVidas, 150, 10);
      textSize(35);
      fill(0);
      text("X2", 50, 45);
    } else if (vidas == 1) {

      image(imgVidas, 100, 10);
      textSize(35);
      fill(0);
      text("X1", 50, 45);
    }
  }
  if (vidas <=0) {

    bolaLava.matar();
    mundo.remove(bolaLava);
    bolaPiedra.matar();
    mundo.remove(bolaPiedra);
    pantallas = "perdiste";
  }
  if (pantallas.equals("perdiste")) {

    image(perder, 0, 0);
    fondo.pause();
    viento.pause();
  }

  if (bolaLava.getY()>height+50) {

    bolaLava.matar();
    mundo.remove(bolaLava);
    pantallas = "perdiste";
  }
}

void keyPressed() {

  if (key==ENTER && pantallas.equals("perdiste")) {
    pantallas = "portada";
  }
}

void mousePressed() {

  if (pantallas.equals("portada")) {
    pantallas = "juego";
    viento.play();
    viento.loop();
    fondo.play();
    fondo.loop();
    mundo.add(bolaLava);
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

  if ((_body1.getName() == "bola de piedra" && (_body2.getName() == "hierro"))
    ||(_body2.getName()=="bola de piedra" &&(_body1.getName() == "hierro"))) {

    salto.play();
  }
  //condicion para cambie algo en el personaje cuando toca ciertas plataformas
  if ((_body1.getName() == "bola de lava" && _body2.getName() == "hielo")
    || (_body2.getName() == "bola de lava" && _body1.getName() == "hielo")) {

    mundo.remove( hielo);

    if (bolaLava.vivo) {

      crack.play();
    }
  }
  if ((_body1.getName() == "bola de lava" && _body2.getName() == "agua")
    || (_body2.getName() == "bola de lava" && _body1.getName() == "agua")) {

    if (bolaLava.vivo) {

      splash.play();
      bolaPiedra = new Personaje(50, "bola de piedra");
      bolaPiedra.inicializar(bolaLava.getX(), bolaLava.getY());
      mundo.remove(bolaLava);
      mundo.add(bolaPiedra);
      vidas--;
    }
  }
  if ((_body1.getName() == "bola de piedra"  && _body2.getName() == "hielo")
    || (_body2.getName() == "bola de piedra" && _body1.getName() == "hielo")) {

    mundo.remove( hielo);

    if (bolaLava.vivo) {
      crack.play();
    }
  }
  if ((_body1.getName() == "bola de piedra" && _body2.getName() == "agua")
    || (_body2.getName() == "bola de piedra" && _body1.getName() == "agua")) {

    if (bolaLava.vivo) {

      splash.play();
      vidas--;
    }
  }
  if ((_body1.getName() == "bola de piedra" && _body2.getName() == "lava")
    || (_body2.getName() == "bola de piedra" && _body1.getName() == "lava")) {

    if (bolaLava.vivo) {

      llamas.play();
      bolaLava = new Personaje(50, "bola de lava");
      bolaLava.inicializar(bolaPiedra.getX(), bolaPiedra.getY());
      mundo.remove(bolaPiedra);
      mundo.add(bolaLava);
    }
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "hierro"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "hierro"))) {

    removerBala = true;
  }


  if ((_body1.getName() == "bala" && (_body2.getName() == "hielo"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "hielo"))) {

    removerBala = true;
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "lava"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "lava"))) {

    removerBala = true;
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "agua"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "agua"))) {

    removerBala = true;
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "bola de lava"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "bola de lava"))) {

    removerBala = true;
  }

  if ((_body1.getName() == "bala" && (_body2.getName() == "bola de piedra"))
    ||(_body2.getName()== "bala" &&(_body1.getName() == "bola de piedra"))) {

    removerBala = true;
  }
}
