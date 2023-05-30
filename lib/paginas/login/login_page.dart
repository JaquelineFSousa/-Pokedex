// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pokedex/paginas/home/widgets/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/paginas/pokemon_list/pokemon_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//uma classe que controla o campo de texto.
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _saveLogin = true;

  @override
  void initState() {
    super.initState(); //chama a implementação do método na classe pai, garantindo que o estado seja inicializado corretamente.
    loadSavedLogin(); //ele é responsável por carregar o login salvo anteriormente.
    checkLoginStatus(); //determinar se o usuário já está logado ou se precisa fazer login novamente.
  }

  //exibir uma mensagem na tela se os dados não estiver certo.
void exibirAlarm(BuildContext context, String mensagem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Erro de Login'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}

  //flutter não usa localhost ele usa um IP especial.
  void loginUser() async {
    String url = 'http://10.0.2.2:3000/auth/login';
    String email = _nameController.text;
    String password = _passwordController.text;
    //validador de email 
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
   //se o email não estiver validado mostre a mensagem 
    bool isValidEmail = emailRegex.hasMatch(email);
  if (!isValidEmail) {
    exibirAlarm(context, "Ops, ocorreu um erro, tente novamente mais tarde!");
    return;
  }


    // mapa será usado para enviar os dados do login para o servidor.
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    String bodyJson = jsonEncode(body); // Converte o mapa para uma string JSON

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Define o cabeçalho para indicar o tipo de conteúdo JSON
        body: bodyJson, // Envia a string JSON como corpo da solicitação
      );

      if (response.statusCode == 201) {
        // Sucesso na chamada de API
        saveLogin();
        navigateToLoggedInScreen(
            context); //responsável por navegar para a tela principal ou tela de usuário logado após o login ser bem-sucedido.
      } else {
        // Erro na chamada de API
        print('Ops, ocorreu um erro, tente novamente mais tarde!');
      }
    } catch (error) {
      //Captura qualquer exceção
      print('Ops, ocorreu um erro, tente novamente mais tarde!');
    }
  }

  // essas linhas estão usando o SharedPreferences para obter os detalhes de login salvos, como o nome, senha e o valor da opção de salvar login.
  Future<void> loadSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('name');
    String? savedPassword = prefs.getString('password');
    bool? saveLogin = prefs.getBool('saveLogin');

    //verificam se a opção de salvar login está habilitada
    //preenchem os campos de texto com os dados salvos anteriormente
    if (saveLogin != null && saveLogin) {
      if (savedName != null) {
        _nameController.text = savedName;
      }
      if (savedPassword != null) {
        _passwordController.text = savedPassword;
      }
      setState(() {
        _saveLogin = true;
      });
    //navigateToLoggedInScreen(context); //é chamada para navegar para a próxima tela após o login ser realizado com sucesso.
    }
  }

  //para salvar ou remover os detalhes do login, dependendo da opção de salvar login estar habilitada ou não.
  Future<void> saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_saveLogin) {
      await prefs.setString('name', _nameController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('name');
      await prefs.remove('password');
    }
    await prefs.setBool('saveLogin', _saveLogin);
  }

  // redirecionando o usuário para a próxima tela.
  void navigateToLoggedInScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PokemonState(
          name: _nameController.text,
        ),
      ),
    );
  }

  // Verifique o status do login
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('name');
    String? savedPassword = prefs.getString('password');
    if (savedName == null || savedPassword == null) {
      Navigator.of(context).pushReplacement(
        //navegando para a página inicial e substituindo a rota atual.
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      await prefs.setString('name', 'teste');
      await prefs.setString('password', 'teste');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('loginPage'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
         elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Let`s sign you in.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    'Welcome back.',
                    style: TextStyle(fontSize: 34, color: Colors.white),
                  ),
                  const Text(
                    'You`ve been missed!',
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextField(
                        controller:
                            _nameController, //quando digitar no campo nome, pegar o dado e passar para salvar e retornar o login
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'name',
                          labelStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller:
                        _passwordController, //quando digitar no campo senha, pegar o dado e passar para salvar e retornar o login
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'password',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.grey),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.grey),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      suffixIcon: const Icon(
                        IconData(0xf0293, fontFamily: 'MaterialIcons'),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _saveLogin,
                        onChanged: (bool? value) {
                          setState(() {
                            _saveLogin = value ?? false;
                          });
                        },
                        activeColor: Colors
                            .blue, // Define a cor quando o CheckBox está marcado
                        checkColor: Colors.white,
                        fillColor: MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .blue; // Cor quando o CheckBox está marcado
                          } else {
                            return Colors
                                .white; // Cor quando o CheckBox está desmarcado
                          }
                        }),
                      ),
                      const Text(
                        'Salvar login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(18, 130, 0, 0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont´s have on account? ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Registor',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 116, vertical: 20),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        loginUser();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
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
