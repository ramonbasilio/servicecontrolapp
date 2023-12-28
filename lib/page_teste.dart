import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PageTeste extends StatefulWidget {
  const PageTeste({super.key});

  @override
  State<PageTeste> createState() => _PageTesteState();
}

class _PageTesteState extends State<PageTeste> {
  SignatureController controller =
      SignatureController(penStrokeWidth: 2, penColor: Colors.white);
  Uint8List? fileContent;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<String> getFilePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/assintura.pgn';
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina de teste'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Signature(
            controller: controller,
            width: 350,
            height: 200,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.clear();
                },
                child: const Text('Limpar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final path = await File(await getFilePath()).create();
                    Uint8List? bytes = await controller.toPngBytes();
                    await path
                        .writeAsBytes(bytes!)
                        .then((value) => print('salvou...'));
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Salvar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  File file = File(await getFilePath());
                  fileContent = await file.readAsBytes();
                  setState(() {}); // <<<<<<<< PRECISO CORRIGIR ISSO
                },
                child: const Text('Ler'),
              ),
            ],
          ),
          Container(
            color: Colors.grey,
            width: 350,
            height: 200,
            child: fileContent == null
                ? const Text('Sem imagem')
                : Image.memory(fileContent!),
          )
        ],
      ),
    );
  }
}
