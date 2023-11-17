import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/pessoa_model.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/navigator_login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class ProfileRepository {
  Future<void> fieldCheckProfile(
    BuildContext context,
    TextEditingController controllerEmail,
    TextEditingController controllerNome,
    TextEditingController controllerIdade,
    TextEditingController controllerAltura,
    TextEditingController controllerPeso,
    String controllerSexo,
    XFile? image,
  ) async {
    if (controllerNome.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Digite um valor válido para o nome!',
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
        const SnackBar(
          content: Text(
            'O campo altura não pode ser vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
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
    } else if (controllerSexo.trim().isEmpty) {
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
      PessoaModel pessoaModel = PessoaModel(
        email: controllerEmail.text.trim(),
        nome: controllerNome.text.trim(),
        idade: int.parse(controllerIdade.text),
        altura: double.parse(controllerAltura.text),
        peso: double.parse(controllerPeso.text),
        sexo: controllerSexo.trim(),
        foto: image!.path,
      );

      await DB.instance.updatePessoa(pessoaModel);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Dados alterados com sucesso!',
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
    }
  }

  Future<void> deletePessoa(
    BuildContext context,
    TextEditingController controllerEmail,
  ) async {
    await DB.instance.deletePessoa(
      controllerEmail.text.trim(),
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const NavigatorLoginPage(),
        type: PageTransitionType.leftToRight,
        isIos: true,
        duration: const Duration(
          milliseconds: 750,
        ),
      ),
    );
    return;
  }
}
