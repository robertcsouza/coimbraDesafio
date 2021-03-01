class Endereco {
  int idEndereco;
  String cidade;
  String bairro;
  String rua;
  int numero;

  Endereco(
      {int idEndereco, String cidade, String bairro, String rua, int numero}) {
    this.idEndereco = idEndereco;
    this.cidade = cidade;
    this.bairro = bairro;
    this.rua = rua;
    this.numero = numero;
  }

  int get id {
    return idEndereco;
  }

  toMap() {
    Map<String, dynamic> map = {
      'cidade': this.cidade,
      'bairro': this.bairro,
      'rua': this.rua,
      'numero': this.numero
    };

    return map;
  }
}
