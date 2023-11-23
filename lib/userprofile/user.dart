import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/setting/setting1.dart';

class UserInputPage extends StatefulWidget {
  const UserInputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInputPageState createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    int age = prefs.getInt('age') ?? 0;
    String phoneNumber = prefs.getString('phoneNumber') ?? '';
    String place = prefs.getString('place') ?? '';

    _nameController.text = name;
    _ageController.text = age.toString();
    _phoneNumberController.text = phoneNumber;
    _placeController.text = place;
  }

  void _saveDataAndNavigate() async {
    String name = _nameController.text;
    String ageText = _ageController.text;
    String phoneNumber = _phoneNumberController.text;
    String place = _placeController.text;

    int? age;
    if (ageText.isNotEmpty && int.tryParse(ageText) != null) {
      age = int.parse(ageText);
    } else {
      age = 0;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setInt('age', age);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setString('place', place);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UserDataDisplayPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx2) => const UserDataDisplayPage(),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                maxLength: 3,
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: _placeController,
                decoration: const InputDecoration(labelText: 'Place'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDataAndNavigate,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataDisplayPage extends StatefulWidget {
  const UserDataDisplayPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDataDisplayPageState createState() => _UserDataDisplayPageState();
}

class _UserDataDisplayPageState extends State<UserDataDisplayPage> {
  late String _name = '';
  late int _age = 0;
  late String _phoneNumber = '';
  late String _place = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'N/A';
      _age = prefs.getInt('age') ?? 0;
      _phoneNumber = prefs.getString('phoneNumber') ?? 'N/A';
      _place = prefs.getString('place') ?? 'N/A';
    });
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UserInputPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx2) => const Settings(),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back, // Back icon
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'User Data Display',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            color: Colors.white,
            onPressed: _navigateToHomeScreen,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Name: $_name',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Age: $_age',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Phone Number: $_phoneNumber',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Place: $_place',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _navigateToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
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
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }
}
