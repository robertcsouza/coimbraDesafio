class Contratado {
  int idContratado;
  String razaoSocial;
  int cnpj;
  int telefone;
  int enderecoFK;

  Contratado(
      {int idContratado,
      String razaoSocial,
      int cnpj,
      int telefone,
      int enderecoFK}) {
    this.idContratado = idContratado;
    this.razaoSocial = razaoSocial;
    this.cnpj = cnpj;
    this.telefone = telefone;
    this.enderecoFK = enderecoFK;
  }

  int get id {
    return idContratado;
  }

  asString() {
    return this.razaoSocial;
  }

  toMap() {
    Map<String, dynamic> map = {
      'razaoSocial': this.razaoSocial,
      'cnpj': this.cnpj,
      'telefone': this.telefone,
      'endereco_idendereco': this.enderecoFK
    };

    return map;
  }
}
