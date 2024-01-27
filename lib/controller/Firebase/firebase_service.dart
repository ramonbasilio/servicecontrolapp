// ignore_for_file: unused_field
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> registerFirestore(
      String collectionPath, Map<String, dynamic> data, String document) async {
    try {
      await db.collection(collectionPath).doc(data[document]).set(data);
      return 'Salvo com sucesso';
    } catch (e) {
      throw 'Falha ao salvar. Erro: $e';
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase(
      String collectionPath) async {
    List<Map<String, dynamic>> result = [];
    final QuerySnapshot querySnapshot =
        await db.collection(collectionPath).get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      result.add(documentSnapshot.data() as Map<String, dynamic>);
    }
    return result;
  }

  Future<String> deleteClientFirestore(String collectionPath, String id) async {
    try {
      await db.collection(collectionPath).doc(id).delete();
      return 'Apagado com sucesso';
    } catch (e) {
      throw 'Falha ao apagar. Erro: $e';
    }
  }

  Future<void> savePdfFirestore(Uint8List pdf) async {
    String base64Pdf = base64Encode(pdf);
    try {
      await db
          .collection('PDFs')
          .doc(DateTime.now().toString())
          .set({'pdf': base64Pdf});
      print('Salvo pdf com sucesso');
    } catch (e) {
      print('Falha ao salvar pdf');
    }
  }

  Future<String> getLastSequence(String ano) async {
    QuerySnapshot querySnapshot = await db
        .collection('Numero_ordem_de_servico')
        .where(ano)
        .orderBy('controle')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      int controle = querySnapshot.docs.first['controle'];
      await db
          .collection('Numero_ordem_de_servico')
          .doc('2024')
          .set({'controle': controle + 1});
      return '${controle.toString().padLeft(4, '0')}$ano';
    } else {
      await db
          .collection('Numero_ordem_de_servico')
          .doc('2024')
          .set({'controle': 1});
      return '${'1'.padLeft(4, '0')}$ano';
    }
  }
}
