// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class WidgetCardPageInicial extends StatelessWidget {
  Widget? rota;
  String nome;
  WidgetCardPageInicial({
    Key? key,
    this.rota,
    required this.nome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (rota != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => rota!,
            ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        color: Colors.grey.shade800,
        child: SizedBox(
          height: 50,
          child: Center(child: Text(nome, style: const TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}
