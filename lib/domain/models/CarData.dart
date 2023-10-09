class CarData {
  final String enderecoFormatado;
  final String abastecimentoDate;
  final String nomeTipoCombustivel;
  final String nomePosto;
  final String cep;
  final String bairro;
  final String latitude;
  final String longitude;
  final String rua;
  final String qualidade;

  CarData(
      this.enderecoFormatado, this.abastecimentoDate, this.nomeTipoCombustivel, this.nomePosto, this.cep,this.bairro, this.latitude, this.longitude, this.rua,this.qualidade);

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(json['Cidade'], json['DataHora'],
        json['NomeCombustivel'],json['NomePosto'],json['CEP'],json['Bairro'],json['Latitude'],json['Longitude'],json['Rua'],json['NomeQualidade']);
  }
}
