import 'dart:io';

import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/pessoa_model.dart';
import 'package:calculadora_imc/repository/image_picker.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpRepository {
  ImagePickerRepository imagePickerRepository = ImagePickerRepository();

  Future<void> fieldCheck(
    BuildContext context,
    TextEditingController controllerEmail,
    TextEditingController controllerNome,
    TextEditingController controllerIdade,
    TextEditingController controllerAltura,
    TextEditingController controllerPeso,
    TextEditingController controllerSexo,
  ) async {
    if (controllerEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Digite um valor válido para o email!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      return;
    } else if (controllerNome.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'O campo nome não pode ser vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      return;
    } else if (controllerIdade.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'O campo idade não pode ser vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      return;
    } else if (controllerAltura.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'O campo altura não pode ser vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      return;
    } else if (controllerPeso.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'O campo peso não pode ser vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      return;
    } else if (controllerSexo.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'O campo sexo não pode ser vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      return;
    } else {
      if (imagePickerRepository.image == null ||
          imagePickerRepository.image!.path.isEmpty) {
        File imagePath =
            await imagePickerRepository.getImageFileFromAssets('exercise.png');
        PessoaModel pessoaModelLogin = PessoaModel(
          email: controllerEmail.text.toLowerCase(),
          nome: controllerNome.text,
          idade: int.parse(controllerIdade.text),
          altura: double.parse(controllerAltura.text),
          peso: double.parse(controllerPeso.text),
          sexo: controllerSexo.text,
          foto: imagePath.path,
        );

        await DB.instance.openTablePessoa(pessoaModelLogin);

        await Future.delayed(
          const Duration(seconds: 2),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const NavigatorPage(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 750),
            ),
            (route) => false);
      } else {
        PessoaModel pessoaModelLogin = PessoaModel(
          email: controllerEmail.text.toLowerCase(),
          nome: controllerNome.text,
          idade: int.parse(controllerIdade.text),
          altura: double.parse(controllerAltura.text),
          peso: double.parse(controllerPeso.text),
          sexo: controllerSexo.text,
          foto: imagePickerRepository.image!.path,
        );

        await DB.instance.openTablePessoa(pessoaModelLogin);

        await Future.delayed(
          const Duration(seconds: 2),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const NavigatorPage(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 750),
            ),
            (route) => false);
      }
    }
    return;
  }
}
