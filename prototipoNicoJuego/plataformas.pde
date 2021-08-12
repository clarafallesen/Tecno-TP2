//Se crea un objeto que extiende a un objeto de la libreria de processing (FBox)
//O sea que "Plataforma" es un "hijo" de FBox
//La misma plataforma va a ser el cuerpo, por eso no hay que declararlo aca
class Plataforma extends FBox {

  //---------------------------------------PROPIEDADES > variables------------------------------------

  float x, y;
  String tipo;


  //-----------------------------------CONSTRUCTOR > el "setup de la clase"---------------------------
  Plataforma(float _w, float _h) {

    super(_w, _h); //super llama al new FBox (su constructor)
  }

  void inicializar(float _x, float _y, String _tipo) { //antiguo método dibujar

    //caracteristicas de mi objeto FBox

    tipo = _tipo;

    if (tipo.equals("hielo")) {
      setName("hielo");
      setStatic(true);
      attachImage(loadImage("plataforma hielo.png"));
    } else if (tipo.equals("hierro")) {
      setName("hierro");
      setStatic(true);
      setRestitution(0.5);
      attachImage(loadImage("plataforma hierro.png"));
      setGrabbable(false);
    } else if (tipo.equals("agua")) {
      setName("agua");
      setStatic(true);
      setRestitution(0.5);
      attachImage(loadImage("plataforma agua.png"));
    } else if (tipo.equals("lava")) {
      setName("lava");
      setStatic(true);
      setRestitution(0.5);
      attachImage(loadImage("plataforma lava.png"));
    }
    x=_x;
    y=_y;
    setPosition(x, y);
    setRotatable(false);
    setFill(255, 0, 0);
  }

  void mover() { //cambia la posicion en Y de las plataformas manteniendo la X

    setPosition(getX(), getY()+1);  //llamo a las posiciones y aumento 1 en Y por cada frame
    println(getY());

    if ( getY() > height + 100 ) {
      reciclar();
    }
  }

  void reciclar() { //reinicia a las plataformas que se pasaron del borde inferior 

    setPosition(random(width), -100);
  }
}
