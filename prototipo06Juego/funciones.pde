void contactStarted2( FContact colision ) {

  if ( hayColisionEntre( colision, "bala", "personaje")){
    FBody uno = colision.getBody1();
//  FBody dos = colision.getBody2();
    mundo.remove( uno );
// mundo.remove( dos );
  }
}

boolean hayColisionEntre( FContact contact, String nombreUno, String nombreDos ) {
  boolean resultado = false;
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();

  if ( etiquetaUno != null && etiquetaDos != null ) {
    //println( etiquetaUno+" <-> "+etiquetaDos);

    if ( 
      ( nombreUno.equals( etiquetaUno ) && nombreDos.equals( etiquetaDos ) ) ||
      ( nombreDos.equals( etiquetaUno ) && nombreUno.equals( etiquetaDos ) )
      ) {
      resultado = true;
    }
  }
  return resultado;
}

void borrarBalasDelMundo() {

  ArrayList <FBody> cuerpos = mundo.getBodies();

  for ( FBody este : cuerpos ) {
    String nombre = este.getName();
    if ( nombre != null ) {
      if ( nombre.equals("bala") ) {
        if ( este.getY() > height+100 ) {
          mundo.remove( este );
        }
      }
    }
  }
}
