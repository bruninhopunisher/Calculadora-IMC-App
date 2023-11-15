import 'dart:io';

import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/pessoa_model.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/navigator_login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerIdade = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  final TextEditingController _controllerPeso = TextEditingController();
  String _controllerSexo = '';

  XFile? _image;

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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
    _refresh();
  }

  void carregarDados() async {
    Database database = await DB.instance.database;
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM PESSOA');
    PessoaModel pessoaModel = PessoaModel(
      email: list[0]['email'],
      nome: list[0]['nome'],
      idade: list[0]['idade'],
      altura: list[0]['altura'],
      peso: list[0]['peso'],
      sexo: list[0]['sexo'],
      foto: list[0]['foto'],
    );

    _controllerEmail.text = pessoaModel.email;
    _controllerNome.text = pessoaModel.nome;
    _controllerIdade.text = pessoaModel.idade.toString();
    _controllerAltura.text = pessoaModel.altura.toString();
    _controllerPeso.text = pessoaModel.peso.toString();
    _controllerSexo = pessoaModel.sexo;
    _image = XFile(pessoaModel.foto);

    if (kDebugMode) {
      print(
          '----------------Pessoa------------------------ ${pessoaModel.toMap()}');
    }
    setState(() {});
  }

  Future _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    carregarDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
      body: RefreshIndicator(
        onRefresh: () => _refresh(),
        strokeWidth: 3,
        displacement: 95,
        edgeOffset: 50,
        color: backGroundColor,
        child: SizedBox(
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
                        'Meu Perfil',
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
                                      ListTile(
                                        leading: const FaIcon(
                                          FontAwesomeIcons.trash,
                                          color: backGroundColor,
                                          size: 30,
                                        ),
                                        title: const Text(
                                          'Excluir Foto',
                                          style: TextStyle(
                                            color: backGroundColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () async {
                                          File imagePath =
                                              await getImageFileFromAssets(
                                                  'exercise.png');

                                          PessoaModel pessoaModel = PessoaModel(
                                            email: _controllerEmail.text.trim(),
                                            nome: _controllerNome.text.trim(),
                                            idade: int.parse(
                                                _controllerIdade.text),
                                            altura: double.parse(
                                                _controllerAltura.text),
                                            peso: double.parse(
                                                _controllerPeso.text),
                                            sexo: _controllerSexo.trim(),
                                            foto: imagePath.path,
                                          );

                                          await DB.instance
                                              .updatePessoa(pessoaModel);
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Foto excluída com sucesso!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: cardColor,
                                                ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 2000),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: _image != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(_image!.path),
                                  ),
                                  radius: 50,
                                )
                              : const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/12631/12631691.png'),
                                  backgroundColor: Color(0xFFE0E0E0),
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 20),
                      child: TextField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          enabled: false,
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
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly,
                        //   AlturaInputFormatter(),
                        // ],
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
                            groupValue: _controllerSexo,
                            onChanged: (value) {
                              setState(() {
                                _controllerSexo = 'Masculino';
                                if (kDebugMode) {
                                  print(
                                      '---------RADIO------------------------ ${_controllerSexo.toString()}');
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
                            groupValue: _controllerSexo,
                            onChanged: (value) {
                              setState(
                                () {
                                  _controllerSexo = 'Feminino';
                                  if (kDebugMode) {
                                    print(
                                        '---------RADIO------------------------ $_controllerSexo');
                                  }
                                },
                              );
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
                          if (_controllerNome.text.trim().isEmpty) {
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
                          } else if (_controllerSexo.trim().isEmpty) {
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
                              email: _controllerEmail.text.trim(),
                              nome: _controllerNome.text.trim(),
                              idade: int.parse(_controllerIdade.text),
                              altura: double.parse(_controllerAltura.text),
                              peso: double.parse(_controllerPeso.text),
                              sexo: _controllerSexo.trim(),
                              foto: _image!.path,
                            );

                            await DB.instance.updatePessoa(pessoaModel);
                            if (kDebugMode) {
                              print(
                                  '----------------------------updated: ${pessoaModel.toMap()}');
                            }
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
                          'Alterar e Salvar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: cardColor,
                                title: const Text(
                                  'Excluir Conta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: backGroundColor,
                                  ),
                                ),
                                content: const Text(
                                  'Deseja realmente excluir sua conta? Isso implicara em perder todos os dados salvos!',
                                  style: TextStyle(
                                    color: backGroundColor,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Não',
                                      style: TextStyle(
                                        color: backGroundColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await DB.instance.deletePessoa(
                                        _controllerEmail.text.trim(),
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
                                    },
                                    child: const Text(
                                      'Sim',
                                      style: TextStyle(
                                        color: backGroundColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(20),
                          backgroundColor: MaterialStateProperty.all(
                            fontColorCard,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 82,
                              vertical: 15,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Excluir Conta',
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
      ),
    );
  }
}
