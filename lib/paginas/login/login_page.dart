import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pokemon_list/pokemon_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//uma classe que controla o campo de texto
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _saveLogin = false;

  @override
  void initState() {
    //é um método de ciclo de vida do estado que é chamado quando o estado é inicializado.
    super
        .initState(); //chama a implementação do método na classe pai, garantindo que o estado seja inicializado corretamente.
    loadSavedLogin(); //ele é responsável por carregar o login salvo anteriormente.
  }

  // essas linhas estão usando o SharedPreferences para obter os detalhes de login salvos, como o nome, senha e o valor da opção de salvar login.
  Future<void> loadSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('name');
    String? savedPassword = prefs.getString('password');
    bool? saveLogin = prefs.getBool('saveLogin');
    print('Dados salvos:');
    print('Nome: $savedName');
    print('Senha: $savedPassword');

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
      // navigateToLoggedInScreen();  //é chamada para navegar para a próxima tela após o login ser realizado com sucesso.
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
  void navigateToLoggedInScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const PokemonList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                         controller: _nameController, //associando o controlador ao TextField
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
                     controller: _passwordController, //associando o controlador ao TextField
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
                            .green, // Define a cor quando o CheckBox está marcado
                        checkColor: Colors.white,
                        fillColor: MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .green; // Cor quando o CheckBox está marcado
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
                        saveLogin();
                        navigateToLoggedInScreen();
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
