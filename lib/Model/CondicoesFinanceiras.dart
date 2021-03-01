class CondicoesFinanceiras {
  int id;
  int carencia;
  int vigencia;
  int valor;
  int prazoInicial;
  int prazoFinal;

  CondicoesFinanceiras(
      {int id,
      int carencia,
      int vigencia,
      int valor,
      int prazoInicial,
      int prazoFinal}) {
    this.id = id;
    this.carencia = carencia;
    this.vigencia = vigencia;
    this.valor = valor;
    this.prazoInicial = prazoInicial;
    this.prazoFinal = prazoFinal;
  }

  toMap() {
    Map<String, dynamic> map = {
      'carencia': this.carencia,
      'vigencia': this.vigencia,
      'valor': this.valor,
      'prazo_inicial': this.prazoInicial,
      'prazo_final': this.prazoFinal
    };

    return map;
  }
}
