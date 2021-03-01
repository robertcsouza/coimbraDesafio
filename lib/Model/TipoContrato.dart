class TipoContrato {
  int idTipoContrato;
  String tipo;

  TipoContrato({int idTipoContrato, String tipo}) {
    this.idTipoContrato = idTipoContrato;
    this.tipo = tipo;
  }

  asString() {
    return this.tipo;
  }

  toMap() {
    Map<String, dynamic> map = {'tipo': this.tipo};
    return map;
  }
}
