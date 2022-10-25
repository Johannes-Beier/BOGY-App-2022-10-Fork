// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/Question.dart';

class Answer extends StatefulWidget {
  const Answer({Key? key}) : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  final TextEditingController _inputControl = TextEditingController();

  bool _questionType = true;

  String _input = "";
  @override
  void initState() {
    super.initState();

    _inputControl.text = _input;
    _inputControl.addListener(() {
      setState(() {
        _input = _inputControl.text;
      });
    });
  }

  @override
  void dispose() {
    _inputControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NameDesStapels")),
      body: Column(
        children: [
          Placeholder(fallbackHeight: 250, color: Colors.black),
          Padding(padding: EdgeInsets.all(10)),
          Text("Beantworte", style: TextStyle(fontSize: 40)),
          if (!_questionType)
            TextField(
              controller: _inputControl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Eingabe...",
              ),
            ),
          if (_questionType)
            Row(children: [
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                  width: 166.0,
                  height: 100.0,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("A:________"))),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                  width: 166.0,
                  height: 100.0,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("B:________"))),
            ]),
          if (_questionType) Padding(padding: EdgeInsets.all(10)),
          if (_questionType)
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("C:________"))),
                      Padding(padding: EdgeInsets.all(10)),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("D:________"))),
                    ],
                  ),
                ],
              ),
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Question()),
                    (route) => false);
              },
              child: Text("Zur nächsten Frage")),
        ],
      ),
    );
  }
}