import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetMenuTypeService extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String?) returnDropDownValue;
   const WidgetMenuTypeService(
      {this.validator, required this.returnDropDownValue, super.key});

  @override
  State<WidgetMenuTypeService> createState() => _WidgetMenuTypeServiceState();
}

class _WidgetMenuTypeServiceState extends State<WidgetMenuTypeService> {
  String? dropdownvalue;

  List<String> tipoAtendimento = [
    "Corretiva",
    "Preventiva",
    "Instalação",
    "Deinstalação",
    "Visita técnica",
    "Outro",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1)),
        child: DropdownButtonFormField(
            alignment: Alignment.centerLeft,
            menuMaxHeight: 300,
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'Selecione o tipo de atendimento';
              }
              return null;
            },
            hint: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Tipo de atendimento',
              ),
            ),
            focusColor: Colors.white,
            dropdownColor: Colors.white,
            isExpanded: true,
            value: dropdownvalue,
            items: tipoAtendimento.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(items),
                  ));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue ?? "";
                widget.returnDropDownValue.call(dropdownvalue);
              });
            }),
      ),
    );
  }
}
