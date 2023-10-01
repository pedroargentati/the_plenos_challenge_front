class CarData {
  final String enderecoFormatado;
  final String abastecimentoDate;
  final String nomeTipoCombustivel;

  CarData(
      this.enderecoFormatado, this.abastecimentoDate, this.nomeTipoCombustivel);

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(json['enderecoFormatado'], json['abastecimentoDate'],
        json['nomeTipoCombustivel']);
  }
}