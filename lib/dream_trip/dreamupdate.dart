import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trekzen/db_model/dream_database/drm_db.dart';
import 'package:trekzen/db_model/model.dart';
import 'package:trekzen/dream_trip/dream.dart';

class DreamUpdate extends StatefulWidget {
  final String name;
  final String nametwo;
  final String address;
  final String phone;
  final String start;
  final String end;
  final String amount;
  final String expense;
  final String dropdown;

  final dynamic photo;
  final int index;

  const DreamUpdate(
      {super.key,
      required this.name,
      required this.nametwo,
      required this.phone,
      required this.address,
      required this.start,
      required this.end,
      required this.amount,
      required this.expense,
      required this.dropdown,
      required this.photo,
      required this.index});

  @override
  State<DreamUpdate> createState() => _DreamUpdateState();
}

class _DreamUpdateState extends State<DreamUpdate> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nametwoController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  String dropdownvalue = 'Transportation';
  var items = [
    'Transportation',
    'Bike',
    'Car',
    'Train',
    'Flight',
  ];
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.name);
    _nametwoController = TextEditingController(text: widget.nametwo);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    _startDateController = TextEditingController(text: widget.start);
    _endDateController = TextEditingController(text: widget.end);
    amountController = TextEditingController(text: widget.amount);
    expenseController = TextEditingController(text: widget.expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Edit trip details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx2) => const Dream()));
              },
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Text(
                    'Edit Trip Details',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      _photo?.path == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 13, 13),
                              child: CircleAvatar(
                                radius: 48,
                                backgroundImage: FileImage(File(widget.photo)),
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 13, 13),
                              child: CircleAvatar(
                                radius: 48,
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
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 11, 11, 11),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 255, 254, 254)),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                getPhoto();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'From',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'starting place is Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Adress required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
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
                        return 'required';
                      } else if (value.length < 10) {
                        return ' Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _endDateController,
                          decoration: const InputDecoration(
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
                                // Format the date using intl package
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
                  DropdownButton<String>(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.deepPurple),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 11, 240, 160), fontSize: 16),
                    iconEnabledColor: const Color.fromARGB(255, 16, 213, 101),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: amountController,
                            decoration: const InputDecoration(
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
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: expenseController,
                            decoration: const InputDecoration(
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            updateDreamDetail(context);
                          }
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Save Data',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black, // Set background color to black
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  late String photoPathValue = '';
  Future<void> updateDreamDetail(ctx) async {
    if (photoPathValue == '') photoPathValue = widget.photo;

    final dreamModel = DreamModel(
      id: DateTime.now().millisecond.toString(),
      name: _nameController.text,
      nametwo: _nametwoController.text,
      phone: _phoneController.text,
      adress: _addressController.text,
      start: _startDateController.text,
      end: _endDateController.text,
      amount: amountController.text,
      expense: expenseController.text,
      dropdown: dropdownvalue,
      photo: photoPathValue,
    );
    await updateTrip(widget.index, dreamModel);

    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(30),
        backgroundColor: Colors.black,
        content: Text(
          'Saved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);

    final photoTemp = File(photo!.path);
    setState(() {
      _photo = photoTemp;
      photoPathValue = _photo!.path;
    });
  }
}
