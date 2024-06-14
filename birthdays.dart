import 'package:bday/models/birthday.dart';
import 'package:flutter/material.dart';

class Birthdays extends StatelessWidget {
  final List<Birthday> birthdays;
  const Birthdays({required this.birthdays});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 0, 255),
      child: ListView.builder(
        itemCount: birthdays.length,
        itemBuilder: (context, index) {
          final birthday = birthdays[index];
          return BirthdayItem(birthday: birthday);
        },
      ),
    );
  }
}

class BirthdayItem extends StatelessWidget {
  const BirthdayItem({super.key, required this.birthday});
  final Birthday birthday;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${birthday.ime} ${birthday.prezime}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Datum rodenja: ${birthday.datum.toLocal()}".split(' ')[2],
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
