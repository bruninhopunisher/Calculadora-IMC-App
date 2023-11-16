import 'dart:io';

import 'package:calculadora_imc/repository/image_picker.dart';
import 'package:calculadora_imc/repository/sign_up_repository.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key});

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  ImagePickerRepository imagePickerRepository = ImagePickerRepository();
  SignUpRepository signUpRepository = SignUpRepository();
  String _value = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerIdade = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  final TextEditingController _controllerPeso = TextEditingController();
  final TextEditingController _controllerSexo = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() {
    imagePickerRepository;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
      body: SizedBox(
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
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
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
                                      imagePickerRepository.image =
                                          await imagePickerRepository.picker
                                              .pickImage(
                                                  source: ImageSource.camera);
                                      if (imagePickerRepository.image != null) {
                                        String path = (await path_provider
                                                .getApplicationDocumentsDirectory())
                                            .path;
                                        String name = basename(
                                            imagePickerRepository.image!.path);
                                        await imagePickerRepository.image!
                                            .saveTo("$path/$name");
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);

                                        imagePickerRepository.cropImage(
                                            imagePickerRepository.image!);
                                        if (kDebugMode) {
                                          print(
                                              'Camera---------- ${imagePickerRepository.image.toString()}');
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
                                      imagePickerRepository.image =
                                          await imagePickerRepository.picker
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                      if (imagePickerRepository.image != null) {
                                        String path = (await path_provider
                                                .getApplicationDocumentsDirectory())
                                            .path;
                                        String name = basename(
                                            imagePickerRepository.image!.path);
                                        await imagePickerRepository.image!
                                            .saveTo("$path/$name");
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        imagePickerRepository.cropImage(
                                            imagePickerRepository.image!);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: imagePickerRepository.image == null
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
                                File(imagePickerRepository.image!.path),
                              ),
                              radius: 50,
                            ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
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
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
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
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
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
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
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
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
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
                        signUpRepository.fieldCheck(
                          context,
                          _controllerEmail,
                          _controllerNome,
                          _controllerIdade,
                          _controllerAltura,
                          _controllerPeso,
                          _controllerSexo,
                        );
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
    );
  }
}
