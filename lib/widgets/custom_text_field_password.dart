import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFormTextFieldPassword extends StatelessWidget {
  CustomFormTextFieldPassword({this.hintText, this.onChanged , this.obscureText =false, });
  Function(String)? onChanged;
  String? hintText;


  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:  TextStyle(color: Colors.white),
       keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.password],
      obscureText:obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        
        
        

        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),

      ),
    );
  }
}