class Bola extends FCircle {

   Boolean izq, der, arr, _arr;
   float vel;

   Boolean vivo;


  Bola(float tam) {

    super( tam );
  }

  void inicializar(float _x, float _y) {

    vivo = true;

    attachImage(loadImage("bola de piedra.png"));
   

    setName("personaje2");
    setPosition(_x, _y);
    setDamping(-2);
    setRestitution(0.05);
    setFriction(0.5);
    setRotatable(true);
    
    izq=false;
    der=false;
    arr=false;
    _arr=false;
  }

  void actualizar() {
    
    vel = 50;
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
