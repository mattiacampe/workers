
import 'package:flutter/material.dart';
import 'package:workers_campe/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_campe/screens/RegisterPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
} //LoginPage

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter a valid email as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  // : controlla che i campi non siano vuoti
                  if (userController.text.isEmpty || passwordController.text.isEmpty) {ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.orange));
                  return;
                  } //if

                  // legge le credenziali salvate da RegisterPage
                  final sharedPreferences = await SharedPreferences.getInstance();
                  final savedEmail = sharedPreferences.getString('userEmail') ?? '';
                  final savedPassword = sharedPreferences.getString('userPassword') ?? '';

                  // Check user's credentials against saved ones
                  if (userController.text == savedEmail &&
                      passwordController.text == savedPassword) {
                    // ...if they are correct, set the isUserLogged flag
                    await sharedPreferences.setBool('isUserLogged', true);
                    // Finally, navigate to HomePage
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  } //if
                  else {
                    // If the credentials are not correct, say it!
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(content: Text('Wrong email/password'),backgroundColor: Colors.red));
                  } //else
                },
                child: Text('Login'),
              ),
            ),
            // tasto per la registrazione
            // Navigator.push (non pushReplacement) per permettere il back
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Text('Nuovo utente? Crea un account!'),
            ), //TextButton

            SizedBox(height: 130),
          ],
        ),
      ),
    );
  } //build
} //_LoginPageState