// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClienteModel {
  final String id;
  final String razaoSocial;
  final String cnpj;
  final String endereco;
  final String numero;
  final String complemente; 
  final String bairro;
  final String cidade;
  final String estado;
  final String cep;
  final Map<String, dynamic> responsavel;
  // final List<dynamic> responsaveis;
  // final String tipo;

  ClienteModel({
    required this.id,
    required this.razaoSocial,
    required this.cnpj,
    required this.endereco,
    required this.numero,
    required this.complemente,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep,
    required this.responsavel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'razaoSocial': razaoSocial,
      'cnpj': cnpj,
      'endereco': endereco,
      'numero': numero,
      'complemente': complemente,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
      'responsavel': responsavel,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
        id: map['id'] as String,
        razaoSocial: map['razaoSocial'] as String,
        cnpj: map['cnpj'] as String,
        endereco: map['endereco'] as String,
        numero: map['numero'] as String,
        complemente: map['complemente'] as String,
        bairro: map['bairro'] as String,
        cidade: map['cidade'] as String,
        estado: map['estado'] as String,
        cep: map['cep'] as String,
        responsavel: Map<String, dynamic>.from(
          (map['responsavel'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
