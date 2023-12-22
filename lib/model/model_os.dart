// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:servicecontrolapp/model/model_client.dart';

class OrdemServicoModel {

  final String id;
  final String numOrdemServico;
  final ClienteModel cliente;
  final String equipamento;
  final String modelo;
  final String marca;
  final String data;
  final String horaInicial;
  final String horaFinal;
  final String descrSimples;
  final String tipoAtendimento;
  final String descrCompleta;
  final String nomeResponsavel;
  final String assinatura;

  OrdemServicoModel({
    required this.id,
    required this.numOrdemServico,
    required this.cliente,
    required this.equipamento,
    required this.modelo,
    required this.marca,
    required this.data,
    required this.horaInicial,
    required this.horaFinal,
    required this.descrSimples,
    required this.tipoAtendimento,
    required this.descrCompleta,
    required this.nomeResponsavel,
    required this.assinatura,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numOrdemServico': numOrdemServico,
      'cliente': cliente.toMap(),
      'equipamento': equipamento,
      'modelo': modelo,
      'marca': marca,
      'data': data,
      'horaInicial': horaInicial,
      'horaFinal': horaFinal,
      'descrSimples': descrSimples,
      'tipoAtendimento': tipoAtendimento,
      'descrCompleta': descrCompleta,
      'nomeResponsavel': nomeResponsavel,
      'assinatura': assinatura,
    };
  }

  factory OrdemServicoModel.fromMap(Map<String, dynamic> map) {
    return OrdemServicoModel(
      id: map['id'] as String,
      numOrdemServico: map['numOrdemServico'] as String,
      cliente: ClienteModel.fromMap(map['cliente'] as Map<String, dynamic>),
      equipamento: map['equipamento'] as String,
      modelo: map['modelo'] as String,
      marca: map['marca'] as String,
      data: map['data'] as String,
      horaInicial: map['horaInicial'] as String,
      horaFinal: map['horaFinal'] as String,
      descrSimples: map['descrSimples'] as String,
      tipoAtendimento: map['tipoAtendimento'] as String,
      descrCompleta: map['descrCompleta'] as String,
      nomeResponsavel: map['nomeResponsavel'] as String,
      assinatura: map['assinatura'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoModel.fromJson(String source) =>
      OrdemServicoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
