// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnhub/Answer.dart';
import 'package:learnhub/DataHelper/CurrentlyPlaying.dart';
import 'package:learnhub/Question.dart';
import 'package:learnhub/Score.dart';
import 'package:vibration/vibration.dart';
import 'DataHelper/DataHelper.dart';
import 'DataHelper/QuestionBasic.dart';
import 'DataHelper/QuestionImageAndFreeText.dart';
import 'DataHelper/QuestionImageAndSingleChoice.dart';
import 'DataHelper/QuestionStack.dart';
import 'DataHelper/QuestionStringAndAnswers.dart';
import 'DataHelper/QuestionStringAndFreeText.dart';
import 'DataHelper/QuestionTypes.dart';

class Answer extends StatefulWidget {
  CurrentlyPlaying playing;
  DataHelper datahelper;
  String input;
  List<String> answers = [];
  String question;
  int ID;
  Answer(
      {Key? key,
      required this.playing,
      required this.datahelper,
      required this.answers,
      required this.input,
      required this.question,
      required this.ID})
      : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    List<Color> farbe = answerVergleichMC();
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(title: Text(widget.playing.stack.name), actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.playing.questionIndex + 1}/${widget.playing.getMaxPoints()}",
                  style: TextStyle(fontSize: 30),
                ),
              )
            ]),
            body: ListView(
              children: [
                Column(children: [
                  if (widget.playing.getActQuestion().isPictureQuestion &&
                      !widget.playing.getActQuestion().isMultipleChoiceQuestion)
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                          width: 250,
                          image: Image.memory(base64Decode((widget.playing.stack
                                          .getQuestion(
                                              widget.playing.questionIndex)
                                      as QuestionImageAndFreeText)
                                  .imageString))
                              .image),
                    ),
                  if (widget.playing.getActQuestion().isPictureQuestion &&
                      widget.playing.getActQuestion().isMultipleChoiceQuestion)
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                          width: 250,
                          image: Image.memory(base64Decode((widget.playing.stack
                                          .getQuestion(
                                              widget.playing.questionIndex)
                                      as QuestionImageAndSingleChoice)
                                  .imageString))
                              .image),
                    ),
                  if (!widget.playing.getActQuestion().isPictureQuestion)
                    Padding(
                      padding: EdgeInsets.all(20),
                      child:
                          Text(widget.question, style: TextStyle(fontSize: 40)),
                    ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  if (!widget.playing.getActQuestion().isMultipleChoiceQuestion)
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: farbe[4]),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.input,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  if (!widget.playing
                          .getActQuestion()
                          .isMultipleChoiceQuestion &&
                      !widget.playing
                          .getActQuestion()
                          .isAnswerCorrect(widget.input))
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.answers[0],
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  if (!widget.playing.getActQuestion().isMultipleChoiceQuestion)
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  if (widget.playing.getActQuestion().isMultipleChoiceQuestion)
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(
                        children: [
                          SizedBox(
                              width: 166.0,
                              height: 100.0,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: farbe[0],
                                      border: Border.all(
                                        color: farbe[0],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(widget.answers[0],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)))),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          SizedBox(
                              width: 166.0,
                              height: 100.0,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: farbe[2],
                                      border: Border.all(
                                        color: farbe[2],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(widget.answers[2],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)))),
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
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: farbe[1],
                                      border: Border.all(
                                        color: farbe[1],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(widget.answers[1],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)))),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          SizedBox(
                              width: 166.0,
                              height: 100.0,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: farbe[3],
                                      border: Border.all(
                                        color: farbe[3],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(widget.answers[3],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      )))),
                        ],
                      ),
                    ]),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  if ((widget.playing.questionIndex + 1) <
                          widget.playing.stack.getAmountOfQuestions() &&
                      (widget.playing.questionIndex + 1) <
                          widget.playing.maxQuestions)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: nextQuestion, child: Text("Weiter")),
                    ),
                  if ((widget.playing.questionIndex + 1) ==
                          widget.playing.stack.getAmountOfQuestions() ||
                      (widget.playing.questionIndex + 1) ==
                          widget.playing.maxQuestions)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: showResult, child: Text("Zum Ergebnis")),
                    ),
                ]),
              ],
            )));
  }

  List<Color> answerVergleichMC() {
    var questionBasic =
        widget.playing.stack.getQuestion(widget.playing.questionIndex);
    if (questionBasic.isAnswerCorrect(widget.input)) {
      widget.playing.correctAnswers++;
    } else {
      Vibration.vibrate(duration: 600, amplitude: 881);
    }
    List<Color> list = [
      Colors.black,
      Colors.black,
      Colors.black,
      Colors.black,
      Colors.black
    ];
    list[widget.ID] = Colors.red;
    if (questionBasic.isMultipleChoiceQuestion) {
      for (int i = 0; i < 4; i++) {
        if (questionBasic.isAnswerCorrect(widget.answers[i])) {
          list[i] = Colors.green;
        }
      }
    } else {
      if (questionBasic.isAnswerCorrect(widget.input)) {
        list[4] = Colors.green;
      }
    }

    return list;
  }

  void nextQuestion() {
    widget.playing.questionIndex++;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Question(
                  datahelper: widget.datahelper,
                  playing: widget.playing,
                )),
        (route) => false);
  }

  void showResult() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Score(
                  datahelper: widget.datahelper,
                  playing: widget.playing,
                )),
        (route) => false);
  }
}
