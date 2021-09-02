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
