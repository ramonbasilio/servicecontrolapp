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

class GeneratePdf extends StatelessWidget {
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
    doc.addPage(pw.Page(margin: pw.EdgeInsets.zero,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 30, left: 25, right: 25),
          child: (pw.Container(
            color: PdfColors.yellow500,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
                pw.Container(
                  height: 200,
                  color: PdfColors.white,
                  child: pw.Image(logo),
                ),
                pw.Text(
                    'Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
                pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
                pw.Text('Valor: R\$ ${ordemServico.descricao}'),
              ],
            ),
          )),
        );
      },
    ));
    writeCounter(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
    );
  }

  // pw.Widget _headerContent(pw.Context context) {
  //   return pw.Container(
  //     height: 200,
  //     color: PdfColors.blue300,
  //     child: pw.Column(
  //       children: [
  //         pw.Image(logo),
  //       ],
  //     ),
  //   );
  // }

  // final logo = pw.MemoryImage(
  //   File('assets/logo.png').readAsBytesSync(),
  // );

  //body
  // List<pw.Widget> _buildContent(pw.Context context) {
  //   return [
  //     pw.Padding(
  //       padding: const pw.EdgeInsets.only(top: 30, left: 25, right: 25),
  //       child: (pw.Column(
  //         children: [
  //           pw.Text('Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
  //           pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
  //           pw.Text('Valor: R\$ ${ordemServico.descricao}'),
  //         ],
  //       )),
  //     ),
  //   ];
  // }
}
