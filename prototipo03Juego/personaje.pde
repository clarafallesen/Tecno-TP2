class Personaje extends FCircle {

   Boolean izq, der, arr, _arr;
   float vel;

   Boolean vivo;

  Personaje(float tam) {

    super( tam );
  }

  void inicializar(float _x, float _y) {

    vivo = true;

    attachImage(loadImage("bola de lava.png"));

    setName("personaje");
    setPosition(_x, _y);
    setDamping(-1);
    setRestitution(1);
    setFriction(0.7);
    setRotatable(true);
    
    izq=false;
    der=false;
    arr=false;
    _arr=false;
  }

  void actualizar() {
    
    vel = 90;
    if(vivo){
      if (izq){
        setVelocity(-vel,  getVelocityY());
    }
      if (der) {
        setVelocity(vel,  getVelocityY());
    }
   }
  }
    
  
  void matar(){
    
    vivo=false;
  }
}
