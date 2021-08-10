class Personaje extends FCircle {

   Boolean izq, der, arr, _arr;
   float vel;

   Boolean vivo;
   String tipo;

  Personaje(float tam, String tipo_) {

    super( tam );
    tipo = tipo_;
  }

  void inicializar(float _x, float _y) {
    
    if(tipo.equals("bola de lava")){

      vivo = true;
  
      attachImage(loadImage("bola de lava.png"));
  
      setName("bola de lava");
      setPosition(_x, _y);
      setDamping(-1);
      setRestitution(1);
      setFriction(0.7);
      setRotatable(true);
    
    }
    if(tipo.equals("bola de piedra")){
      
      vivo = true;
  
      attachImage(loadImage("bola de piedra.png"));
  
      setName("bola de piedra");
      setPosition(_x, _y);
      setDamping(-5);
      setRestitution(1);
      setFriction(1);
      setDensity(10);
      setRotatable(true);
    }
  }
  
  void matar(){
    
    vivo=false;
  }
}
