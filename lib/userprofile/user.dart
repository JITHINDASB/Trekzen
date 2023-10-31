import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/home/home.dart';
import 'package:trekzen/setting/setting1.dart';

class UserInputPage extends StatefulWidget {
  @override
  _UserInputPageState createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when the page initializes
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    int age = prefs.getInt('age') ?? 0;
    String phoneNumber = prefs.getString('phoneNumber') ?? '';
    String place = prefs.getString('place') ?? '';

    // Set the text controllers with the loaded data
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

    // Validate age input
    int? age;
    if (ageText.isNotEmpty && int.tryParse(ageText) != null) {
      age = int.parse(ageText);
    } else {
      // Handle invalid age input (you can show an error message or set a default value)
      // For now, let's set it to a default value of 0
      age = 0;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setInt('age', age);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setString('place', place);

    // Navigate to the next page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserDataDisplayPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx2) => UserDataDisplayPage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back, // Back icon
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                maxLength: 3,
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: _placeController,
                decoration: InputDecoration(labelText: 'Place'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDataAndNavigate,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Set button background color to black
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Set text color to white
                ),
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataDisplayPage extends StatefulWidget {
  @override
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
        builder: (context) => UserInputPage(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx2) => Settings(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back, // Back icon
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'User Data Display',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
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
                  style: TextStyle(fontSize: 24), // Increase text size
                ),
                Text(
                  'Age: $_age',
                  style: TextStyle(fontSize: 24), // Increase text size
                ),
                Text(
                  'Phone Number: $_phoneNumber',
                  style: TextStyle(fontSize: 24), // Increase text size
                ),
                Text(
                  'Place: $_place',
                  style: TextStyle(fontSize: 24), // Increase text size
                ),
                SizedBox(
                  height:
                      40, // Increased space between user data and the button
                ),
                ElevatedButton(
                  onPressed: _navigateToHome,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          name: _name,
        ),
      ),
    );
  }
}
