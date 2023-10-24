import 'package:brasil_fields/brasil_fields.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key});

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerIdade = TextEditingController();
  TextEditingController _controllerAltura = TextEditingController();
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerSexo = TextEditingController();

  String _value = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Column(
          children: [
            Expanded(
              child: Image(
                image: const AssetImage('assets/logo_imc.png'),
                width: MediaQuery.of(context).size.width * 0.45,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: cardColor,
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: InkWell(
                                  child: const FaIcon(
                                    FontAwesomeIcons.arrowLeftLong,
                                    color: backGroundColor,
                                  ),
                                  onTap: () => Navigator.pop(context),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 60),
                                child: Text(
                                  'Cadastro',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.values[8],
                                    color: backGroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 20),
                          child: InkWell(
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
                                          onTap: () {},
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
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundColor: backGroundColor,
                              child: FaIcon(
                                FontAwesomeIcons.image,
                                color: fontColorCard,
                                size: 50,
                              ),
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
                            controller: _controllerNome,
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              AlturaInputFormatter(),
                            ],
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              AlturaInputFormatter(),
                            ],
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
                                    print(_value);
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
                                    print(_value);
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
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_controllerNome.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Digite um valor válido para o nome!',
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
                              }
                              if (_controllerIdade.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'O campo idade não pode ser vazio!',
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
                              }
                              if (_controllerAltura.text.trim().isEmpty) {
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
                              }
                              if (_controllerPeso.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'O campo peso não pode ser vazio!',
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
      ),
    );
  }
}
