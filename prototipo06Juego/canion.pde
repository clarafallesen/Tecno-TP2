float anguloVel = 2;
float diamBala = 5;
float velocidad = 2000;

PImage ventilador;
String img;
int canion;

class Canion {

  float x, y;
  float angulo;
  float largo = 90;
  float ancho = 40;

  Canion( float x_, float y_ , float angulo_){
    x = x_;
    y = y_;
    angulo = radians( angulo_);
    
  }

  void dibujar(String _img){
    
    img = _img;
    ventilador = loadImage(img);
    pushMatrix();
    translate( x, y );
    rotate( angulo );
    image(ventilador,0,0);
    popMatrix();
  }
  
  void responderATeclasEstado(int num){
    
    canion = num;
    if(num==1){
    if ( keyPressed ) {
      if ( keyCode == RIGHT ) {
        angulo += radians(anguloVel);
      } else if ( keyCode == LEFT) {
        angulo -= radians(anguloVel);
      }
     angulo = constrain( angulo , radians(160) , radians(400) );
      }
    }
    else if(num==2){
    if ( keyPressed ) {
      if ( key == 'a' || key == 'A'){
        angulo += radians(anguloVel);
      } else if ( key == 'd' ||key ==  'D') {
        angulo -= radians(anguloVel);
      }
     angulo = constrain( angulo , radians(160) , radians(400) );
      }
    }
  }
  
  void disparar( FWorld mundo ) {

    FCircle bala = new FCircle( diamBala );
    bala.setPosition( x, y );
    bala.setNoStroke();
    bala.setFill( 255 , 50 );
    bala.setName( "bala" );
    
    float vx = velocidad * cos( angulo );
    float vy = velocidad * sin( angulo );
    
    bala.setVelocity( vx , vy );
    mundo.add( bala );
  }


/*void sacarBalas(FWorld mundo ) {
  
    FCircle bala = new FCircle( diamBala );
    mundo.remove(bala);
  }*/
}
