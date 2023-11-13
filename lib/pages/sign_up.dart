import 'dart:io';

import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/pessoa_model.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/navigator_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:path/path.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key});

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerIdade = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  final TextEditingController _controllerPeso = TextEditingController();
  final TextEditingController _controllerSexo = TextEditingController();

  cropImage(XFile imageFile) async {
    // ignore: unused_local_variable
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Recortar Imagem',
            toolbarColor: backGroundColor,
            toolbarWidgetColor: cardColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    setState(() {});
  }

  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Cadastro',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.values[8],
                            color: backGroundColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: cardColor,
                              builder: (context) {
                                return Container(
                                  margin: const EdgeInsets.all(0),
                                  height: 170,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ListTile(
                                        leading: const FaIcon(
                                          FontAwesomeIcons.camera,
                                          color: backGroundColor,
                                          size: 30,
                                        ),
                                        title: const Text(
                                          'Câmera',
                                          style: TextStyle(
                                            color: backGroundColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () async {
                                          _image = await _picker.pickImage(
                                              source: ImageSource.camera);
                                          if (_image != null) {
                                            String path = (await path_provider
                                                    .getApplicationDocumentsDirectory())
                                                .path;
                                            String name =
                                                basename(_image!.path);
                                            await _image!.saveTo("$path/$name");
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);

                                            cropImage(_image!);
                                            if (kDebugMode) {
                                              print(
                                                  'Camera---------- ${_image.toString()}');
                                            }
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: const FaIcon(
                                          FontAwesomeIcons.images,
                                          color: backGroundColor,
                                          size: 30,
                                        ),
                                        title: const Text(
                                          'Galeria',
                                          style: TextStyle(
                                            color: backGroundColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () async {
                                          _image = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          if (_image != null) {
                                            String path = (await path_provider
                                                    .getApplicationDocumentsDirectory())
                                                .path;
                                            String name =
                                                basename(_image!.path);
                                            await _image!.saveTo("$path/$name");
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                            cropImage(_image!);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: _image == null
                              ? const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: backGroundColor,
                                  child: FaIcon(
                                    FontAwesomeIcons.images,
                                    color: cardColor,
                                    size: 50,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(_image!.path),
                                  ),
                                  radius: 50,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: _controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              color: fontColorCard,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: fontColorCard,
                                width: 3,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backGroundColor,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: _controllerNome,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: const TextStyle(
                              color: fontColorCard,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: fontColorCard,
                                width: 3,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backGroundColor,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: _controllerIdade,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Idade',
                            labelStyle: const TextStyle(
                              color: fontColorCard,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: fontColorCard,
                                width: 3,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backGroundColor,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _controllerAltura,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Altura',
                            labelStyle: const TextStyle(
                              color: fontColorCard,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: fontColorCard,
                                width: 3,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backGroundColor,
                            wordSpacing: 5,
                          ),
                          // inputFormatters: [],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 20),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _controllerPeso,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Peso',
                            labelStyle: const TextStyle(
                              color: fontColorCard,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: fontColorCard,
                                width: 3,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: backGroundColor,
                            wordSpacing: 5,
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          //   AlturaInputFormatter(),
                          // ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 1.7,
                            child: Radio(
                              activeColor: backGroundColor,
                              value: 'Masculino',
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                  _controllerSexo.text = _value;
                                  if (kDebugMode) {
                                    print(_controllerSexo.text);
                                  }
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Masculino',
                            style: TextStyle(
                                color: backGroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Transform.scale(
                            scale: 1.7,
                            child: Radio(
                              activeColor: backGroundColor,
                              value: 'Feminino',
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                  _controllerSexo.text = _value;
                                  if (kDebugMode) {
                                    print(_controllerSexo.text);
                                  }
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Feminino',
                            style: TextStyle(
                                color: backGroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_controllerEmail.text.trim().isEmpty) {
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
                            } else if (_controllerNome.text.trim().isEmpty) {
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
                            } else if (_controllerIdade.text.trim().isEmpty) {
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
                            } else if (_controllerAltura.text.trim().isEmpty) {
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
                            } else if (_controllerPeso.text.trim().isEmpty) {
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
                            } else if (_controllerSexo.text.trim().isEmpty) {
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
                              PessoaModel pessoaModelLogin = PessoaModel(
                                email: _controllerEmail.text.toLowerCase(),
                                nome: _controllerNome.text,
                                idade: int.parse(_controllerIdade.text),
                                altura: double.parse(_controllerAltura.text),
                                peso: double.parse(_controllerPeso.text),
                                sexo: _controllerSexo.text,
                                foto: _image?.path ?? '',
                              );

                              await DB.instance
                                  .openTablePessoa(pessoaModelLogin);

                              await Future.delayed(
                                const Duration(seconds: 2),
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NavigatorPage(),
                                  ),
                                  (route) => false);
                            }
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(20),
                            backgroundColor: MaterialStateProperty.all(
                              fontColorCard,
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 74,
                                vertical: 15,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
