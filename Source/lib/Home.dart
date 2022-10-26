import 'package:flutter/material.dart';
import 'package:learnhub/EditDeck.dart';
import 'DataHelper/DataHelper.dart';
import 'DataHelper/QuestionStack.dart';
import 'DataHelper/QuestionStack.dart';
import 'Topic.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    quizes.loadDemoData();
  }
  DataHelper quizes = DataHelper();

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: addNewDeck,)
          ],
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 50),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: quizes.amountOfQuestionStacks(),
                  itemBuilder: (BuildContext context, int index) {
                    QuestionStack questionStack =
                        quizes.getQuestionStack(index);
                    return Topic(
                      questionStack: questionStack,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
          ],
        ),
      ),
    );
  }

  void addNewDeck() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditDeck(QuestionStack(""))))
        .then((questionStack) {
          if(questionStack != null){
          setState(() {
            quizes.addQuestionStack(questionStack);
          });
          }
        });
  }
}
