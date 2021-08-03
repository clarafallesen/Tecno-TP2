float anguloVel = 2;
float diamBala = 5;
float velocidad = 1000;

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

  void dibujar() {
    
    pushMatrix();
    translate( x, y );
    rotate( angulo );
  //noFill();
  //noStroke();
    rect( -ancho/2, -ancho/2, largo, ancho );
    popMatrix();
  }
  
  void responderATeclasEstado() {
    if ( keyPressed ) {
      if ( keyCode == UP ) {
        angulo += radians(anguloVel);
      } else if ( keyCode == DOWN) {
        angulo -= radians(anguloVel);
      }
      angulo = constrain( angulo , 
      radians(-170) , radians(-10) );
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
}
