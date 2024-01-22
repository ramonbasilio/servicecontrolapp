import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

class Conversor {
  static List<Point> convertUint8ListToOffsetList(Uint8List uint8List) {
    // Implemente a lógica para converter Uint8List para List<Offset> aqui
    // Exemplo simplificado: converter bytes para pontos
    List<Point> pontos = [];
    for (int i = 0; i < uint8List.length; i += 2) {
      double x = uint8List[i].toDouble();
      double y = uint8List[i + 1].toDouble();
      pontos.add(Point(x, y));
    }
    return pontos;
  }
}
