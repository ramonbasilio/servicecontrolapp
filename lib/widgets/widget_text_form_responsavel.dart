// ignore_for_file: must_be_immutable
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class WidgetTextFormResponsavel extends StatefulWidget {
  bool? isNumberType;
  String? mask;
  String hintText;
  TextEditingController controler;
  final String? Function(String?)? validator;

  WidgetTextFormResponsavel(
      {required this.hintText,
      this.isNumberType,
      this.mask,
      this.validator,
      required this.controler,
      super.key});

  @override
  State<WidgetTextFormResponsavel> createState() => _WidgetTextFormResponsavelState();
}

class _WidgetTextFormResponsavelState extends State<WidgetTextFormResponsavel> {
  Map<String, dynamic> mapFormatter = {
    'CNPJ': MaskTextInputFormatter(mask: '##.###.###/####-##'),
    'Telefone': MaskTextInputFormatter(mask: '(##) #####-####'),
    'CEP':MaskTextInputFormatter(mask: '#####-###'),
  };

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        
        keyboardType: widget.isNumberType != null && widget.isNumberType == true ?  TextInputType.number : null,
        validator: widget.validator,
        inputFormatters: widget.mask != null ? [mapFormatter[widget.mask]] : [],
        controller: widget.controler,
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.only(left: 10), 
            hintStyle: const TextStyle(fontWeight: FontWeight.w100),
            enabledBorder: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: widget.hintText),
      ),
    );
  }
}
