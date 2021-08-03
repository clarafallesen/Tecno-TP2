//Se crea un objeto que extiende a un objeto de la libreria de processing (FBox)
//O sea que "Plataforma" es un "hijo" de FBox
//La misma plataforma va a ser el cuerpo, por eso no hay que declararlo aca
class Plataforma extends FBox {
  
  Plataforma(float _w, float _h){
    
    //super llama al new FBox (su constructor)
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y){
    
    //caracteristicas de mi objeto FBox
    //Este mismo objeto de esta clase es un FBox (no se necesita el FBox.)
    attachImage(loadImage("plataforma hierro.png"));
    setPosition(_x,_y);
    setName("plataforma");//metal
    setStatic(true);
    setGrabbable(false);
  }
}
