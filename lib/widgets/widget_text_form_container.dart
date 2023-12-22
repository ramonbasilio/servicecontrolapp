// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WidgetTextFormContainer extends StatelessWidget {
  TextEditingController nomeContatoController;
  TextEditingController telefoneController;
  TextEditingController emailController;
  Color? color;
  WidgetTextFormContainer(
      {required this.nomeContatoController,
      required this.telefoneController,
      required this.emailController,
      required this.color,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: color,
      child: Column(
        children: [
          TextFormField(
            controller: nomeContatoController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: 'Nome'),
          ),
          TextFormField(
            controller: telefoneController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: 'Telefone'),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: 'E-mail'),
          ),
        ],
      ),
    );
  }
}
