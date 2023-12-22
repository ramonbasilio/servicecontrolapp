// ignore_for_file: unused_field
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> registerFirestore(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      await db.collection(collectionPath).doc(data['id']).set(data);
      return 'Salvo com sucesso';
    } catch (e) {
      throw 'Falha ao salvar. Erro: $e';
    }
  }

  Future<List<Map<String, dynamic>>> getAllClientesFirestore(
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
}
