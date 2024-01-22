import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetMenuTypeService2 extends StatefulWidget {
  String? dropdownvalue;
  final String? Function(String?)? validator;
  final void Function(String?) returnDropDownValue;
  WidgetMenuTypeService2(
    this.dropdownvalue, {
    this.validator,
    required this.returnDropDownValue,
    super.key,
  });

  @override
  State<WidgetMenuTypeService2> createState() => _WidgetMenuTypeServiceState();
}

class _WidgetMenuTypeServiceState extends State<WidgetMenuTypeService2> {
  // String? dropdownvalue;

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
            value: widget.dropdownvalue,
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
                widget.dropdownvalue = newValue ?? "";
                widget.returnDropDownValue.call(widget.dropdownvalue);
              });
            }),
      ),
    );
  }
}
