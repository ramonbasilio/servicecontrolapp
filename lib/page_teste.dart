// // ignore_for_file: use_build_context_synchronously

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:servicecontrolapp/page_viwer_pdf.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:signature/signature.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// import 'helper/helper_pdf.dart';
// import 'model/model_test.dart';

// class PageTeste extends StatefulWidget {
//   const PageTeste({super.key});

//   @override
//   State<PageTeste> createState() => _PageTesteState();
// }

// class _PageTesteState extends State<PageTeste> {
//   Future<String> localPath() async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<File> localFile() async {
//     final path = await localPath();
//     return File('$path/exemplo.pdf');
//   }

//   @override
//   Widget build(BuildContext context) {
//     Orcamento orcamento = OrcamentoMoc().meuOrcamento;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pagina de teste'),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Center(
//                 child: ElevatedButton(
//               onPressed: () async {
//                 final RenderBox box = context.findRenderObject() as RenderBox;
//                 GeneratePdf generatePdf = GeneratePdf(orcamento: orcamento);
//                 generatePdf.generatePdf();
//                 File file = await localFile();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ViwerPdf(path: file.path,),
//                     ));

//                 // Share.shareXFiles([XFile(file.path)]);
//               },
//               child: const Text('Gerar pdf'),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
