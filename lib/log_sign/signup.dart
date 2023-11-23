import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/db_model/database/db.dart';
import 'package:trekzen/home/home.dart';
import 'package:trekzen/log_sign/login.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => const Register()},
    ));

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  // Define TextEditingController for each TextFormField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use email as part of the key to store data separately for each user
    prefs.setString('email_$email', email);
    prefs.setString('password_$email', password);

    await deleteAllUsers();
  }

  @override
  void initState() {
    super.initState();
    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            // Navigate to the next page when the BackButton is pressed
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signin()));
          },
          color: Colors.black,
        ),
        title: const Text(
          'SignUp',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/z.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController, // Assign the controller
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'leo@gmail.com',
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true, // Hide the password text
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: '******',
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.lightBlue,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            // Save email and password to SharedPreferences
                            _saveCredentials(email, password);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Or Sign Up Using',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 90),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            'assets/k.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.asset(
                            "assets/m.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ),
                        );
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    deleteAllUsers();
  }
}
