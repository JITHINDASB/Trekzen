import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/home/home.dart';
import 'package:trekzen/log_sign/signup.dart';
import 'package:trekzen/splash/splash.dart';

// ignore: constant_identifier_names
const Save_Key = 'isLoggedIn';
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Signin(),
        '/register': (context) => const Register(),
      },
    ));

class Signin extends StatelessWidget {
  Signin({super.key});

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email_${_emailController.text}');
    String? storedPassword =
        prefs.getString('password_${_emailController.text}');

    if (storedEmail == _emailController.text &&
        storedPassword == _passwordController.text) {
      // Successfully logged in
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Create an account')));
    }

    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(SAVE_KEY_NAME, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/e.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            color: const Color.fromARGB(255, 23, 15, 15).withOpacity(0.2),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Username';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () => _login(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text(
                          'Don\'t have an account? Create Account',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
