class CarData {
  final String enderecoFormatado;
  final String abastecimentoDate;
  final String nomeTipoCombustivel;
  final String nomePosto;
  final String cep;
  final String bairro;

  CarData(
      this.enderecoFormatado, this.abastecimentoDate, this.nomeTipoCombustivel, this.nomePosto, this.cep,this.bairro);

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(json['Cidade'], json['DataHora'],
        json['NomeCombustivel'],json['NomePosto'],json['CEP'],json['Bairro']);
  }
}