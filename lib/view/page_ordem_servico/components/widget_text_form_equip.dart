import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetTextFormEquip extends StatefulWidget {
  String label;
  String hintText;
  TextEditingController equipamentoNomeController;
  bool? isMaxLine;
  final String? Function(String?)? validator;

  WidgetTextFormEquip(
      {this.validator,
      this.isMaxLine,
      required this.equipamentoNomeController,
      required this.hintText,
      required this.label,
      super.key});

  @override
  State<WidgetTextFormEquip> createState() => _WidgetTextFormEquipState();
}

class _WidgetTextFormEquipState extends State<WidgetTextFormEquip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onChanged: (value) {
          widget.equipamentoNomeController.text = value;
        },
        maxLines: widget.isMaxLine == null ? 1 : 15,
        validator: widget.validator!,
        controller: widget.equipamentoNomeController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            label: Text(widget.label),
            hintText: widget.hintText),
      ),
    );
  }
}
