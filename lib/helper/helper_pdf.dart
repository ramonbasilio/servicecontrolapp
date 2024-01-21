import 'package:flutter/services.dart';
import 'package:servicecontrolapp/utils/save_data_local.dart';
import '../model/model_os.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GeneratePdf {
  OrdemServicoModel ordemServico;
  Uint8List? assinatura;
  GeneratePdf({this.assinatura, required this.ordemServico});

  generatePdf() async {
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );

    final assinaturaRamon = pw.MemoryImage(
      (await rootBundle.load('assets/assinatura_ramon.png'))
          .buffer
          .asUint8List(),
    );

    final sign = pw.MemoryImage(assinatura!);

    pw.Document doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        header: (pw.Context context) {
          return pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  borderRadius: pw.BorderRadius.circular(5)),
              height: 100,
              width: double.infinity,
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
            _dotWidget(context),
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  borderRadius: pw.BorderRadius.circular(5)),
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
            _dotWidget(context),
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  borderRadius: pw.BorderRadius.circular(5)),
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
            _dotWidget(context),
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  borderRadius: pw.BorderRadius.circular(5)),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('RESUMO DO ATENDIMENTO',
                        style: pw.TextStyle(
                            fontSize: 21, fontWeight: pw.FontWeight.bold)),
                    pw.Text('TIPO ATENDIMENTO: ${ordemServico.tipoAtendimento}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(
                        'DATA ATENDIMENTO: ${ordemServico.dataAtendimento} ',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(
                        'HORA INICIO: ${ordemServico.horaInicioAtendimento}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('HORA FINAL: ${ordemServico.horaFinalAtendimento}',
                        style: const pw.TextStyle(fontSize: 15)),
                    pw.Text('DESCRIÇÃO: ${ordemServico.resumoAtendimento}',
                        style: const pw.TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
            _dotWidget(context),
            pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  borderRadius: pw.BorderRadius.circular(5)),
              height: 150,
              width: double.infinity,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('ASSINATURAS',
                      style: pw.TextStyle(
                          fontSize: 21, fontWeight: pw.FontWeight.bold)),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(assinaturaRamon, height: 50, width: 90),
                          pw.SizedBox(width: 90, child: pw.Divider()),
                          pw.Text('Tecnico: Ramon Basilio'),
                        ],
                      ),
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(sign, height: 50, width: 90),
                          pw.SizedBox(width: 90, child: pw.Divider()),
                          pw.Text('Cliente: ${ordemServico.nomeCliente}'),
                        ],
                      ),
                    ],
                  ),
                  pw.Text('ENVIADO PARA O EMAIL: ${ordemServico.emailCliente}'),
                ],
              ),
            ),
          ];
        },
      ),
    );
    final pdf = await doc.save();
    DataLocal().saveFile(pdf, 'exemploOrdemDeServico.pdf');
  }

  pw.Center _dotWidget(pw.Context context) {
    return pw.Center(
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Container(
          alignment: pw.Alignment.center,
          height: 10,
          width: 10,
          decoration: const pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            color: PdfColors.black,
          ),
        ),
      ),
    );
  }
}
