import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/model_os.dart';
import '../model/model_test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
    pw.Document doc = pw.Document();
    doc.addPage(pw.MultiPage(
      build: (context) => _buildContent(context),
    ));
    writeCounter(await doc.save());
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat formart) async => doc.save());
  }

  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 30, left: 25, right: 25),
        child: (pw.Column(
          children: [
            pw.Text('Nome do cliente: ${ordemServico.cliente!.razaoSocial}'),
            pw.Text('Nome da peça: ${ordemServico.cliente!.cnpj}'),
            pw.Text('Valor: R\$ ${ordemServico.descricao}'),
          ],
        )),
      ),
    ];
  }
}
