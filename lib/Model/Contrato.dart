class Contrato {
  int idContrato;
  int contratanteFK;
  int contratadoFk;
  int condicoesFk;
  int statusFK;
  int tipoContratoFK;
  int dataCriacao;

  Contrato(
      {int idContrato,
      int contratanteFK,
      int contratadoFK,
      int condicoesFK,
      int statusFK,
      int tipoContratoFK,
      int dataCriacao}) {
    this.idContrato = idContrato;
    this.contratanteFK = contratanteFK;
    this.contratadoFk = contratadoFK;
    this.condicoesFk = condicoesFK;
    this.statusFK = statusFK;
    this.tipoContratoFK = tipoContratoFK;
    this.dataCriacao = dataCriacao;
  }

  toMap() {
    Map<String, dynamic> map = {
      'contratante_idContratante': this.contratanteFK,
      'contratado_idContratado': this.contratadoFk,
      'condicoesFinanceiras_idCondicoesFinanceiras': this.condicoesFk,
      'status_idStatus': this.statusFK,
      'tipoContrato_idTipoContrato': this.tipoContratoFK,
      'data_criacao': this.dataCriacao
    };

    return map;
  }
}
