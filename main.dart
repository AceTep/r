import 'package:bday/birthdays.dart';
import 'package:bday/models/birthday.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BirthdayApp",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BirthdayScreen(),
    );
  }
}

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  List<Birthday> birthdays = [
    Birthday(
        ime: "Mateo", prezime: "Trakostanec", datum: DateTime(2002, 16, 4)),
    Birthday(
        ime: "Mateo", prezime: "Trakostanec", datum: DateTime(2002, 16, 4)),
    Birthday(
        ime: "Mateo", prezime: "Trakostanec", datum: DateTime(2002, 16, 4)),
  ];

  void _addBirthday(Birthday birthday) {
    setState(() {
      birthdays.add(birthday);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Birthday list"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    AddBirthdaySheet(onAddBirthday: _addBirthday),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Birthdays(birthdays: birthdays),
    );
  }
}

class AddBirthdaySheet extends StatefulWidget {
  final Function(Birthday) onAddBirthday;
  AddBirthdaySheet({required this.onAddBirthday});

  @override
  State<AddBirthdaySheet> createState() => _AddBirthdaySheetState();
}

class _AddBirthdaySheetState extends State<AddBirthdaySheet> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: "First name"),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: "Last name"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                _selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                child: const Text('Choose Date'),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Add Birthday'),
            onPressed: () {
              if (_firstNameController.text.isEmpty ||
                  _lastNameController.text.isEmpty ||
                  _selectedDate == null) {
                return;
              }
              final newBirthday = Birthday(
                ime: _firstNameController.text,
                prezime: _lastNameController.text,
                datum: _selectedDate!,
              );
              widget.onAddBirthday(newBirthday);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
