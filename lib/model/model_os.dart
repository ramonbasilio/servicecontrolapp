// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:servicecontrolapp/model/model_client.dart';

class OrdemServicoModel {
  final String idOrdemServico;
  final ClienteModel cliente;
  final String nomeCliente;
  final String emailCliente;
  final String equipamento;
  final String marca;
  final String modelo;
  final String ns;
  final String tipoAtendimento;
  final String resumoAtendimento;
  final String dataAtendimento;
  final String horaInicioAtendimento;
  final String horaFinalAtendimento;
  final Uint8List assinatura;

  OrdemServicoModel({
    required this.idOrdemServico,
    required this.nomeCliente,
    required this.emailCliente,
    required this.tipoAtendimento,
    required this.dataAtendimento,
    required this.horaInicioAtendimento,
    required this.horaFinalAtendimento,
    required this.cliente,
    required this.equipamento,
    required this.modelo,
    required this.marca,
    required this.ns,
    required this.resumoAtendimento,
    required this.assinatura,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cliente': {
        'id': cliente.id,
        'razaoSocial': cliente.razaoSocial,
        'cnpj': cliente.cnpj,
        'endereco': cliente.endereco,
        'numero': cliente.numero,
        'complemente': cliente.complemente,
        'bairro': cliente.bairro,
        'cidade': cliente.cidade,
        'estado': cliente.estado,
        'cep': cliente.cep,
        'responsavel': cliente.responsavel,
      },
      'idOrdemServico': idOrdemServico,
      'nomeCliente': nomeCliente,
      'emailCliente': emailCliente,
      'equipamento': equipamento,
      'marca': marca,
      'modelo': modelo,
      'ns': ns,
      'tipoAtendimento': tipoAtendimento,
      'resumoAtendimento': resumoAtendimento,
      'dataAtendimento': dataAtendimento,
      'horaInicioAtendimento': horaInicioAtendimento,
      'horaFinalAtendimento': horaFinalAtendimento,
      'assinatura': base64Encode(assinatura),
    };
  }

  factory OrdemServicoModel.fromMap(Map<String, dynamic> map) {
    return OrdemServicoModel(
      idOrdemServico: map['idOrdemServico'],
      cliente: ClienteModel.fromMap(map['cliente'] as Map<String, dynamic>),
      nomeCliente: map['nomeCliente'] as String,
      emailCliente: map['emailCliente'] as String,
      equipamento: map['equipamento'] as String,
      marca: map['marca'] as String,
      modelo: map['modelo'] as String,
      ns: map['ns'] as String,
      tipoAtendimento: map['tipoAtendimento'] as String,
      resumoAtendimento: map['resumoAtendimento'] as String,
      dataAtendimento: map['dataAtendimento'] as String,
      horaInicioAtendimento: map['horaInicioAtendimento'] as String,
      horaFinalAtendimento: map['horaFinalAtendimento'] as String,
      assinatura: base64Decode(map['assinatura']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoModel.fromJson(String source) =>
      OrdemServicoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
