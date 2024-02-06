// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_local_variable

import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Firebase/firebase_service.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import '../../model/model_client.dart';
import '../../model/model_os.dart';

class Repository extends ChangeNotifier {
  List<ClienteModel> _listClients = [];
  List<ClienteModel> get listClients => _listClients;

  List<OrdemServicoModel> _listOrdemService = [];
  List<OrdemServicoModel> get listOrdemService => _listOrdemService;

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

    String _response = await FirebaseService().registerFirestore(
      'Clientes',
      _clienteModel.toMap(),
      'id',
    );

    final snackBar = SnackBar(
      content: Text(_response),
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  void registerOrdemService(
      {required BuildContext? context,
      required OrdemServicoModel ordemServicoModel}) async {
    String _response = await FirebaseService().registerFirestore(
      'Ordem_de_servico',
      ordemServicoModel.toMap(),
      'idOrdemServico',
    );

    final snackBar = SnackBar(
      content: Text(_response),
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  Future<void> getAllClients() async {
    _loading = true;
    _listClients = [];
    List<Map<String, dynamic>> _resultFirestore =
        await FirebaseService().getDataFromFirebase('Clientes');
    _resultFirestore.forEach((element) {
      _listClients.add(ClienteModel.fromMap(element));
    });
    _loading = false;
    notifyListeners();
  }

  Future<void> getAllOrdemServico() async {
    _loading = true;
    _listOrdemService = [];
    List<Map<String, dynamic>> _resultFirestore =
        await FirebaseService().getDataFromFirebase('Ordem_de_servico');
    _resultFirestore.forEach((element) {
      _listOrdemService.add(OrdemServicoModel.fromMap(element));
    });
    _loading = false;
    notifyListeners();
  }

  loadFirebase() async {
    await getAllOrdemServico();
    await getAllClients();
  }

  Repository repositoryClientProvider(BuildContext context) =>
      Provider.of<Repository>(context, listen: false);

  Future<void> deleteData(String colletion, String id) async {
    await FirebaseService().deleteClientFirestore(colletion, id);
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
    notifyListeners();
    return _listClients;
  }
}
