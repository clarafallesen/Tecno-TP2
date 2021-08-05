//esta clase sirve para las plataformas que sacan vidas o que generan 
//un cambio en el personaje
class Obstaculo extends FBox{
  
  String tipo;
  
  Obstaculo(float _w, float _h, String _tipo){
    
    super(_w,_h);
    
    tipo = _tipo;
  }
  
  void inicializar(float _x, float _y){
    
    if(tipo.equals("hielo")){
      setName("hielo");
      setStatic(true);
      attachImage(loadImage("plataforma hielo.png"));
    }
    else if (tipo.equals("agua")){
      setName("agua");
      setStatic(true);
      setRestitution(0.5);
      attachImage(loadImage("plataforma agua.png"));
    }
     else if (tipo.equals("lava")){
      setName("lava");
      setStatic(true);
      setRestitution(0.5);
      attachImage(loadImage("plataforma lava.png"));
    }
    setPosition(_x,_y);
    setRotatable(false);
    setFill(255,0,0);
  }
}
