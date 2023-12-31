// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_local_variable

import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Firebase/firebase_service.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import '../../model/model_client.dart';
import '../../model/model_os.dart';

class RepositoryClient extends ChangeNotifier {
  List<ClienteModel> _listClients = [];
  List<ClienteModel> get listClients => _listClients;

  bool _loading = false;
  bool get loading => _loading;

  void registerClient({
    required BuildContext? context,
    required final String razaoSocial,
    required final String cnpj,
    required final String endereco,
    required final String numero,
    required final String complemento,
    required final String bairro,
    required final String cidade,
    required final String estado,
    required final String cep,
    required final Map<String, dynamic> responsaveis,
  }) async {
    String id = const Uuid().v4();
    ClienteModel _clienteModel = ClienteModel(
        id: id,
        razaoSocial: razaoSocial,
        cnpj: cnpj,
        endereco: endereco,
        numero: numero,
        complemente: complemento,
        bairro: bairro,
        cidade: cidade,
        estado: estado,
        cep: cep,
        responsavel: responsaveis);

    String _response = await FirebaseService()
        .registerFirestore('Clientes', _clienteModel.toMap());

    final snackBar = SnackBar(
      content: Text(_response),
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  // void registerOrdemServico({
  //   required BuildContext? context,
  //   required final String id,
  //   required final String numOrdemServico,
  //   required final ClienteModel cliente,
  //   required final String equipamento,
  //   required final String modelo,
  //   required final String marca,
  //   required final String data,
  //   required final String horaInicial,
  //   required final String horaFinal,
  //   required final String descrSimples,
  //   required final String tipoAtendimento,
  //   required final String descrCompleta,
  //   required final String nomeResponsavel,
  //   required final String assinatura,
  // }) async {
  //   String id = const Uuid().v4();
  //   OrdemServicoModel _ordemDeServicoModel = OrdemServicoModel(
  //     id: id,
  //     numOrdemServico: numOrdemServico,
  //     cliente: cliente,
  //     equipamento: equipamento,
  //     modelo: modelo,
  //     marca: marca,
  //     data: data,
  //     horaInicial: horaInicial,
  //     horaFinal: horaFinal,
  //     descrSimples: descrSimples,
  //     tipoAtendimento: tipoAtendimento,
  //     descrCompleta: descrCompleta,
  //     nomeResponsavel: nomeResponsavel,
  //     assinatura: assinatura,
  //   );

  //   String _response = await FirebaseService()
  //       .registerFirestore('Ordem_de_Servico', _ordemDeServicoModel.toMap());

  //   final snackBar = SnackBar(
  //     content: Text(_response),
  //   );
  //   ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  // }

  Future<void> getAllClients() async {
    _loading = true;
    _listClients = [];
    List<Map<String, dynamic>> _resultFirestore =
        await FirebaseService().getAllClientesFirestore('Clientes');
    _resultFirestore.forEach((element) {
      _listClients.add(ClienteModel.fromMap(element));
    });
    _loading = false;
    notifyListeners();
  }

  loadClients() async {
    await getAllClients();
  }

  RepositoryClient repositoryClientProvider(BuildContext context) =>
      Provider.of<RepositoryClient>(context, listen: false);

  Future<void> deleteClient(String id) async {
    await FirebaseService().deleteClientFirestore('Clientes', id);
    notifyListeners();
  }

  List<ClienteModel> fitraClient(
      String query, List<ClienteModel> listaClientes) {
    _listClients = [];
    _listClients = listaClientes
        .where(
          (element) => element.razaoSocial.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    // print('tamanho: ${_listClients.length}');
    // _listClients.forEach(
    //   (element) {
    //     print('Razao Social: ${element.razaoSocial}');
    //   },
    // );
    notifyListeners();
    return _listClients;
  }
}
