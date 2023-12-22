// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:servicecontrolapp/controller/Repository/repository_client.dart';
import '../../main.dart';
import '../../widgets/widget_text_form_responsavel.dart';

class PageRegisterClient extends StatefulWidget {
  const PageRegisterClient({super.key});

  @override
  State<PageRegisterClient> createState() => _PageRegisterClientState();
}

class _PageRegisterClientState extends State<PageRegisterClient> {
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _nomeContatoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? dropdownvalue;

  List<String> items = [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Cadastro Novo Cliente'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'DADOS HOSPITAL / CLÍNICA',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    WidgetTextFormResponsavel(
                        // Razão Social
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite o nome do Hospital ou Clínica';
                          }
                          return null;
                        },
                        hintText: 'Razão Social',
                        controler: _razaoSocialController),
                    WidgetTextFormResponsavel(
                        // CNPJ
                        isNumberType: true,
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite um CNPJ';
                          }
                          return null;
                        },
                        mask: 'CNPJ',
                        hintText: 'CNPJ',
                        controler: _cnpjController),
                    WidgetTextFormResponsavel(
                        //Endereço
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite um endereço completo';
                          }
                          return null;
                        },
                        hintText: 'Endereço',
                        controler: _enderecoController),
                    WidgetTextFormResponsavel(
                        isNumberType: true,
                        // Numero
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite o número';
                          }
                          return null;
                        },
                        hintText: 'Numero',
                        controler: _numeroController),
                    WidgetTextFormResponsavel(
                        hintText: 'Complemento',
                        controler: _complementoController),
                    WidgetTextFormResponsavel(
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite o bairro';
                          }
                          return null;
                        },
                        hintText: 'Bairro',
                        controler: _bairroController),
                    WidgetTextFormResponsavel(
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite a cidade';
                          }
                          return null;
                        },
                        hintText: 'Cidade',
                        controler: _cidadeController),
                    WidgetTextFormResponsavel(
                        mask: 'CEP',
                        isNumberType: true,
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite o CEP';
                          }
                          return null;
                        },
                        hintText: 'CEP',
                        controler: _cepController),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: DropdownButtonFormField(
                            alignment: Alignment.centerLeft,
                            menuMaxHeight: 300,
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'Selecione um estado';
                              }
                              return null;
                            },
                            hint: const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Estado',
                                style: TextStyle(fontWeight: FontWeight.w100),
                              ),
                            ),
                            focusColor: Colors.white,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: dropdownvalue,
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(items),
                                  ));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue ?? "";
                              });
                            }),
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'INFORMAÇÕES DO CONTATO',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    WidgetTextFormResponsavel(
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite o nome do contato';
                          }
                          return null;
                        },
                        hintText: 'Nome',
                        controler: _nomeContatoController),
                    WidgetTextFormResponsavel(
                        isNumberType: true,
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite um telefone valido';
                          }
                          return null;
                        },
                        mask: 'Telefone',
                        hintText: 'Telefone',
                        controler: _telefoneController),
                    WidgetTextFormResponsavel(
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Digite um email valido';
                          }
                          return null;
                        },
                        hintText: 'E-mail',
                        controler: _emailController),
                    const Divider(),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade800),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final BuildContext? _context = MyApp.navKey.currentContext;
                if (_context != null) {
                  RepositoryClient().registerClient(
                    context: _context,
                    cnpj: _cnpjController.text.trim(),
                    razaoSocial: _razaoSocialController.text.trim(),
                    endereco: _enderecoController.text.trim(),
                    numero: _numeroController.text.trim(),
                    complemento: _complementoController.text.trim(),
                    bairro: _bairroController.text.trim(),
                    cidade: _cidadeController.text.trim(),
                    cep: _cepController.text.trim(),
                    estado: dropdownvalue!.trim(),
                    responsaveis: {
                      'Nome': _nomeContatoController.text.trim(),
                      'Telefone': _telefoneController.text.trim(),
                      'E-mail': _emailController.text.trim(),
                    },
                  );
                }
                RepositoryClient()
                    .repositoryClientProvider(context)
                    .loadClients();
                Navigator.pop(context);
              }
            },
            child: const Text(
              'SALVAR CONTATO',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
