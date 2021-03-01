class Contratante {
  int idContratante;
  String razaoSocial;
  int cnpj;
  int telefone;
  int enderecoFK;

  Contratante(
      {int idContratante,
      String razaoSocial,
      int cnpj,
      int telefone,
      int enderecoFK}) {
    this.idContratante = idContratante;
    this.razaoSocial = razaoSocial;
    this.cnpj = cnpj;
    this.telefone = telefone;
    this.enderecoFK = enderecoFK;
  }

  int get id {
    return idContratante;
  }

  asString() {
    return this.razaoSocial;
  }

  toMap() {
    Map<String, dynamic> map = {
      'c_razaoSocial': this.razaoSocial,
      'c_cnpj': this.cnpj,
      'c_telefone': this.telefone,
      'c_endereco_idendereco': this.enderecoFK
    };

    return map;
  }
}
