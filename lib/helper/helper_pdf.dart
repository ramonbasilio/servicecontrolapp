import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../model/model_os.dart';
import '../model/model_test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GeneratePdf {
  OrdemServicoModel ordemServico;
  GeneratePdf({required this.ordemServico});

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/exemplo.pdf');
  }

  Future<File> writeCounter(Uint8List pdf) async {
    final file = await localFile;
    // Write the file
    return file.writeAsBytes(pdf);
  }

  generatePdf() async {
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );

    pw.Document doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        header: (pw.Context context) {
          return pw.Container(
              height: 100,
              width: double.infinity,
              color: PdfColor.fromHex('#f2f2f2'),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Image(logo, height: 25),
                    pw.Text('ORDEM DE SERVIÇO',
                        style: const pw.TextStyle(fontSize: 25)),
                  ],
                ),
              ));
        },
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Divider(thickness: 0.09),
            pw.Container(
              width: double.infinity,
              color: PdfColor.fromHex('#f2f2f2'),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('DADOS DO CLIENTE',
                        style: pw.TextStyle(
                            fontSize: 21, fontWeight: pw.FontWeight.bold)),
                    pw.Text('CLIENTE: ${ordemServico.cliente.razaoSocial}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('CNPJ: ${ordemServico.cliente.cnpj}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(
                      '${ordemServico.cliente.endereco} nº ${ordemServico.cliente.numero} \nBairro: ${ordemServico.cliente.bairro} \nCidade: ${ordemServico.cliente.cidade} \nEstado: ${ordemServico.cliente.estado} \nCEP: ${ordemServico.cliente.cep}',
                      style: const pw.TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            pw.Divider(thickness: 0.05),
            pw.Container(
              width: double.infinity,
              color: PdfColor.fromHex('#f2f2f2'),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('DADOS DO EQUIPAMENTO',
                        style: pw.TextStyle(
                            fontSize: 21, fontWeight: pw.FontWeight.bold)),
                    pw.Text('EQUIPAMENTO: ${ordemServico.equipamento}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('MARCA: ${ordemServico.marca}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('MODELO: ${ordemServico.modelo}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('NS: ${ordemServico.ns}',
                        style: const pw.TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
            pw.Divider(thickness: 0.05),
            pw.Container(
              width: double.infinity,
              color: PdfColor.fromHex('#f2f2f2'),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('RESUMO DO ATENDIMENTO',
                        style: pw.TextStyle(
                            fontSize: 21, fontWeight: pw.FontWeight.bold)),
                    pw.Text('TIPO ATENDIMENTO: CORRETIVO',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('DATA ATENDIMENTO: 03/01/2024 ',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('HORA INICIO: 16:00',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('HORA FINAL: 17:00',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('DESCRIÇÃO: Realizada corretiva em módulo de ECG. Testado e liberado para uso.',
                        style: const pw.TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
    writeCounter(await doc.save());
  }
}
