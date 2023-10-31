import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekzen/db_model/database/db.dart';
import 'package:trekzen/db_model/dream_database/drm_db.dart';
import 'package:trekzen/db_model/model.dart';
import 'package:trekzen/home/home.dart';

class ScreenAdd extends StatefulWidget {
  ScreenAdd({super.key});
  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nametwoController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Transportation';
  TextEditingController amountController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  // List of items in our dropdown menu
  var items = [
    'Transportation',
    'Bike',
    'Car',
    'Train',
    'Flight',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create your trip',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx2) => const HomeScreen(),
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
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      _photo?.path == null
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 57,
                                backgroundImage:
                                    AssetImage('lib/assest/ani.jpg'),
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              child: CircleAvatar(
                                radius: 58,
                                backgroundImage: FileImage(
                                  File(
                                    _photo!.path,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                              icon: const Icon(Icons.camera),
                              tooltip: 'Camera',
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                getPhoto();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'From',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' starting place is Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nametwoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'To',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' destination is Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _startDateController,
                          decoration: const InputDecoration(
                            labelText: 'Starting Date',
                            hintText: 'Select starting date',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2024),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                // Format the date using intl package
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                _startDateController.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _endDateController,
                          decoration: InputDecoration(
                            labelText: 'Ending Date',
                            hintText: 'Select ending date',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2024),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                _endDateController.text = formattedDate;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              prefixText: '₹ ',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' amount is Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: expenseController,
                            decoration: InputDecoration(
                              labelText: 'Expense',
                              prefixText: '₹ ',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' expense is Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.deepPurple),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 11, 240, 160), fontSize: 16),
                    iconEnabledColor: Color.fromARGB(255, 16, 213, 101),
                    underline: Container(
                        height: 2, color: Colors.black // Underline color
                        ),
                    elevation: 8,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone number is required';
                      } else if (value.length < 10) {
                        return ' Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _photo != null) {
                        addUserToModel();
                      } else if (_photo == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please add image!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else {
                        print('Empty field found');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black), // Set button background color to black
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set text color to white
                    ),
                    child: const Text('Done'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Don't have much money? Add your dream trip!",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _photo != null) {
                          DreamModelWay();
                        } else if (_photo == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Please add image!',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )));
                        } else {
                          print('Empty field found');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .black), // Set button background color to black
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Set text color to white
                      ),
                      child: const Text('DreamTrip')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  popDialogueBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sucess"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (ctx) {
                      return const HomeScreen();
                    }));
                  },
                  child: const Text("Back")),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Set button background color to black
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Set text color to white
                ),
                child: const Text("Add New"),
              )
            ],
            content: const Text("Saved successfully"),
          );
        });
  }

  Future<void> addUserToModel() async {
    final _name = _nameController.text.trim();
    final _nametwo = _nametwoController.text.trim();
    final _phone = _phoneController.text.trim();
    final _address = _addressController.text.trim();
    final _start = _startDateController.text.trim();
    final _end = _endDateController.text.trim();
    final _amount = amountController.text.trim();
    final _expense = expenseController.text.trim();
    final _image = _photo;

    if (_photo!.path.isEmpty ||
        _name.isEmpty ||
        _phone.isEmpty ||
        _nametwo.isEmpty ||
        _start.isEmpty ||
        _end.isEmpty ||
        _amount.isEmpty ||
        _expense.isEmpty ||
        _address.isEmpty) {
      return;
    } else {
      //reset fields
      _nameController.text = '';
      _nametwoController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _startDateController.text = '';
      _endDateController.text = '';
      amountController.text = '';
      expenseController.text = '';
      _photo = null;
      setState(() {
        popDialogueBox(); //to show success message
      });
    }

    final userObject = UserModel(
        name: _name,
        nametwo: _nametwo,
        adress: _address,
        phone: _phone,
        start: _start,
        end: _end,
        amount: _amount,
        expense: _expense,
        dropdown: dropdownvalue,
        photo: _image!.path,
        id: DateTime.now().millisecond.toString());
    print(
        "$_name $_nametwo $_address $_end $_amount $_expense  $_start $_phone");

    addUser(userObject);
  }

  File? _photo;
  bool _isImagePickerActive =
      false; // Flag to check if the image picker is active

  Future<void> getPhoto() async {
    if (_isImagePickerActive) {
      return; // Image picker is already active, return without opening it again
    }

    try {
      setState(() {
        _isImagePickerActive =
            true; // Set the flag to indicate that the picker is active
      });

      final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (photo == null) {
        // Handle if user cancels image picker
      } else {
        final photoTemp = File(photo.path);
        setState(() {
          _photo = photoTemp;
        });
      }
    } catch (e) {
      // Handle other exceptions that might occur during image picking
      print('Error occurred: $e');
    } finally {
      setState(() {
        _isImagePickerActive =
            false; // Reset the flag after image picking is done
      });
    }
  }

  Future<void> DreamModelWay() async {
    final _name = _nameController.text.trim();
    final _nametwo = _nametwoController.text.trim();
    final _phone = _phoneController.text.trim();
    final _address = _addressController.text.trim();
    final _start = _startDateController.text.trim();
    final _end = _endDateController.text.trim();
    final _amount = amountController.text.trim();
    final _expense = expenseController.text.trim();
    final _image = _photo;

    if (_photo!.path.isEmpty ||
        _name.isEmpty ||
        _phone.isEmpty ||
        _nametwo.isEmpty ||
        _start.isEmpty ||
        _end.isEmpty ||
        _amount.isEmpty ||
        _expense.isEmpty ||
        _address.isEmpty) {
      return;
    } else {
      //reset fields
      _nameController.text = '';
      _nametwoController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _startDateController.text = '';
      _endDateController.text = '';
      amountController.text = '';
      expenseController.text = '';
      _photo = null;
      setState(() {
        DreamBox(); //to show success message
      });
    }

    final DreamObject = DreamModel(
        name: _name,
        nametwo: _nametwo,
        adress: _address,
        phone: _phone,
        start: _start,
        end: _end,
        amount: _amount,
        expense: _expense,
        dropdown: dropdownvalue,
        photo: _image!.path,
        id: DateTime.now().millisecond.toString());
    print(
        "$_name $_nametwo $_address $_end $_amount $_expense $_start $_phone");

    addDream(DreamObject);
  }

  DreamBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sucess"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (ctx) {
                      return const HomeScreen();
                    }));
                  },
                  child: const Text("Back")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add New")),
            ],
            content: const Text("Saved successfully"),
          );
        });
  }
}
