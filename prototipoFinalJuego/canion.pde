float anguloVel = 2;
float diamBala = 20;
float velocidad = 800;

//PImage ventilador;
//String img;
int canion, ID;

TuioProcessing tuioClient;

class Canion {

  float x, y;
  float angulo;
  float largo = 90;
  float ancho = 40;
  PImage [] img;
  int cuantos;

  Canion( float x_, float y_ ) {
    x = x_;
    y = y_;
    cuantos = 3;
    img = new PImage [cuantos];
    for (int i=0; i < 3;i++){
      String esteNombre= "vent_der"+i+".png";
      img[i] = loadImage (esteNombre);
    }
    
  }

  void dibujar(int num) {

    //para saber que simbolo de reactivision es 
    ArrayList <TuioObject> listadoObjetosTuio = tuioClient.getTuioObjectList();
    for (int i = 0; i <listadoObjetosTuio.size(); i++) {
      TuioObject patronAux = listadoObjetosTuio.get(i);
      ID = patronAux.getSymbolID();

     int cualFoto = frameCount %(3);
      pushMatrix();
      translate( x, y );

      if ((ID==0)&&(num==2)) {
        rotate(patronAux.getAngle()*2);
        println("angulo"+patronAux.getAngle());
        image(img[cualFoto], 0, 0);
      } else if ((ID==1)&&(num==1)) {
        rotate(patronAux.getAngle()*2 );
        image(img[cualFoto], 0, 0);
      }
      popMatrix();
    }
  }

  void disparar( FWorld mundo, int num) {

    float disparo=0;

    ArrayList <TuioObject> listadoObjetosTuio = tuioClient.getTuioObjectList();
    for (int i = 0; i <listadoObjetosTuio.size(); i++) {
      TuioObject patronAux = listadoObjetosTuio.get(i);
      ID = patronAux.getSymbolID();
      if (num==1 && ID == 1) {
        
        FCircle bala = new FCircle( diamBala );
        bala.setPosition( x, y );
        bala.setDensity(300000);
        bala.setNoStroke();
        bala.setFill( 255, 50 );
        bala.setName( "bala" );

        float vx = velocidad * cos( patronAux.getAngle()*2 );
        float vy = velocidad * sin( patronAux.getAngle()*2);

        bala.setVelocity( vx, vy );
        mundo.add( bala );
        disparo++;


        if (bala.getY()>height|| disparo>1) {

          mundo.remove(bala);
          disparo=0;
        }
      } else if (num==2 && ID == 0) {
        FCircle bala = new FCircle( diamBala );
        bala.setPosition( x, y );
        bala.setDensity(200000);
        bala.setNoStroke();
        bala.setFill( 255, 50 );
        bala.setName( "bala" );

        float vx = velocidad * cos( patronAux.getAngle()*2 );
        float vy = velocidad * sin( patronAux.getAngle()*2 );

        bala.setVelocity( vx, vy );
        mundo.add( bala );
        disparo++;


        if (bala.getY()>height|| disparo>1) {

          mundo.remove(bala);
          disparo=0;
        }
      }
    }
  }
}
