//Se crea un objeto que extiende a un objeto de la libreria de processing (FBox)
//O sea que "Plataforma" es un "hijo" de FBox
//La misma plataforma va a ser el cuerpo, por eso no hay que declararlo aca
class Plataforma extends FBox {
  
  Plataforma(float _w, float _h){
    
    //super llama al new FBox (su constructor)
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y, String tipo){
    
    //caracteristicas de mi objeto FBox
    //Este mismo objeto de esta clase es un FBox (no se necesita el FBox.)
  
    setName(tipo);
  
    
    if(tipo.equals("hielo")){
      setName("hielo");
      setStatic(true);
      attachImage(loadImage("plataforma hielo.png"));
    }
    else if (tipo.equals("hierro")){
      setName("hierro");
      attachImage(loadImage("plataforma hierro.png"));
      setStatic(true);
      setRestitution(0.5);
      setGrabbable(false);
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
  }
 }
