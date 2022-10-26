// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';

import 'DataHelper/QuestionBasic.dart';
import 'DataHelper/QuestionStringAndAnswers.dart';
import 'DataHelper/QuestionStringAndFreeText.dart';
import 'DataHelper/QuestionTypes.dart';

class Question extends StatefulWidget {
  CurrentlyPlaying playing;
  bool isMultipleChoice = false;
  Question({Key? key, required this.playing}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final TextEditingController _inputControl = TextEditingController();
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
        appBar: AppBar(title: Text(widget.playing.stack.name)),
        body: ListView(
          children: [
            Column(children: [
              /*if (_questionType) Image.asset("assets/images/Logo.png"),*/
              Padding(padding: EdgeInsets.all(10)),
              Text(questionName(), style: TextStyle(fontSize: 40)),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              if (!widget.isMultipleChoice)
                TextField(
                  controller: _inputControl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Eingabe...",
                  ),
                ),
              if (!widget.isMultipleChoice)
                Padding(
                  padding: EdgeInsets.all(10),
                ),
              if (!widget.isMultipleChoice)
                FloatingActionButton(
                    onPressed: mcPressed, child: Icon(Icons.check)),
              if (widget.isMultipleChoice)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text("A:________"))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text("C:________"))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text("A:________"))),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                          width: 166.0,
                          height: 100.0,
                          child: ElevatedButton(
                              onPressed: mcPressed, child: Text("A:________"))),
                    ],
                  ),
                ]),
            ]),
          ],
        ));
  }

  void mcPressed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Answer(
                  playing: widget.playing,
                )),
        (route) => false);
  }

  String questionName() {
    QuestionBasic questionBasic =
        widget.playing.stack.getQuestion(widget.playing.questionIndex);
    if (questionBasic.questionType == QuestionTypes.stringAndAnswer) {
      widget.isMultipleChoice = false;
      QuestionStringAndAnswers questionStringAndAnswers =
          questionBasic as QuestionStringAndAnswers;
      return questionStringAndAnswers.question;
    } else if (questionBasic.questionType == QuestionTypes.stringAndFreeText) {
      widget.isMultipleChoice = true;
      QuestionStringAndFreeText questionStringAndFreeText =
          questionBasic as QuestionStringAndFreeText;
      return questionStringAndFreeText.question;
    } else {
      return "Ordne zu";
    }
  }
}
