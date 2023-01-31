import 'package:baseball_game/Views/Utilities/valid_number.dart';
import 'package:baseball_game/Views/Widgets/ball.dart';
import 'package:baseball_game/Views/Widgets/edit_guess.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const routeName = '/startScreen';
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int strikes = 0;
  int keyDigit = 123;
  int balls = 0;
  final _numberKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  bool firstSubmitted = false;
  bool strikeOut = false;
  bool gameStarted = false;

  String guessedNumber = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (strikes == 3) {
      Future.delayed(Duration.zero, () {
        showAlertDialog(context);
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [_restartGame()],
        ),
        body: gameStarted
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _numberKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child:
                                  Text('Key', style: TextStyle(fontSize: 24))),
                          const SizedBox(width: 16),
                          Text(':', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 16),
                          Text(_keyDigit(), style: TextStyle(fontSize: 24))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child: Text('Guess',
                                  style: TextStyle(fontSize: 24))),
                          const SizedBox(width: 16),
                          Text(':', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 16),
                          Text(firstSubmitted ? guessedNumber : '',
                              style: TextStyle(fontSize: 24))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 40,
                              child: Text('Balls',
                                  style: TextStyle(fontSize: 18))),
                          const SizedBox(width: 16),
                          Text(':', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 16),
                          Text(firstSubmitted ? balls.toString() : '0',
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Ball(value: balls, color: Colors.blue),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 60,
                              child: Text('Strikes',
                                  style: TextStyle(fontSize: 18))),
                          const SizedBox(width: 16),
                          Text(':', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 16),
                          Text(strikes.toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Ball(value: strikes, color: Colors.red),
                      const SizedBox(
                        height: 16 * 2.5,
                      ),
                      EditGuess(
                        controller: _numberController,
                      ),
                      const SizedBox(
                        height: 8 * 3,
                      ),
                      ElevatedButton(
                          child: const Text(
                            'Submit',
                          ),
                          onPressed: () {
                            if (_numberKey.currentState!.validate()) {
                              initValues();
                              // charactersBall();
                              strikCharacter();
                              setState(() {
                                guessedNumber = _numberController.text;
                                firstSubmitted = true;
                              });
                            }
                          }),
                    ],
                  ),
                ),
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Play ball ~~~',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Press Start'),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gameStarted = true;
                            keyDigit = NumberCheck.randomDigit();
                          });
                        },
                        child: const Text('Start'))
                  ],
                ),
              ));
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        'Strike out ~~~',
        style: TextStyle(fontSize: 24),
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            const Text('Press Ok for a new game'),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    balls = 0;
                    strikes = 0;
                    gameStarted = true;
                    firstSubmitted = false;
                    _numberController.clear();
                    strikeOut = false;
                    keyDigit = NumberCheck.randomDigit();
                  });
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String _keyDigit() {
    if (keyDigit.toString().length == 3) {
      return keyDigit.toString();
    } else if (keyDigit.toString().length == 2) {
      return '0' + keyDigit.toString();
    } else if (keyDigit.toString().length == 1) {
      return '00' + keyDigit.toString();
    } else {
      return '000';
    }
  }

  Widget _restartGame() {
    return TextButton(
        onPressed: () {
          setState(() {
            balls = 0;
            strikes = 0;
            keyDigit = NumberCheck.randomDigit();
            firstSubmitted = false;
            _numberController.clear();
          });
          setState(() {});
        },
        child: const Text(
          'New game',
          style: TextStyle(color: Colors.white),
        ));
  }

  void initValues() {
    setState(() {
      balls = 0;
      strikes = 0;
    });
  }

  // void charactersBall() {
  //   var strr = _numberController.text;
  //   var str3 = keyDigit.toString();

  //   Set<String> uniqueList = {};
  //   for (int i = 0; i < strr.length; i++) {
  //     if (str3.contains(strr[i])) {
  //       uniqueList.add(strr[i]);
  //     }
  //   }
  //   setState(() {
  //     balls = uniqueList.length;
  //   });
  // }

  strikCharacter() {
    var str = _numberController.text;
    var str2 = keyDigit.toString();
    if (str2.length == 1) {
      if (str[0].toString() == '0') {
        setState(() {
          str = str.replaceFirst(str[0], "a");
          strikes = strikes + 1;
        });
      }
      if (str[1].toString() == '0') {
        setState(() {
          str = str.replaceFirst(str[1], "a");
          strikes = strikes + 1;
        });
      }
      if (str[2].toString() == '0') {
        setState(() {
          str = str.replaceFirst(str[2], "a");
          strikes = strikes + 1;
        });
      }
    }
    if (str2.length == 2) {
      if (str[0].toString() == '0') {
        setState(() {
          str = str.replaceFirst(str[0], "a");
          strikes = strikes + 1;
        });
      }
      if (str[1].toString() == str2[0]) {
        setState(() {
          str = str.replaceFirst(str[1], "a");
          strikes = strikes + 1;
        });
      }
      if (str[2].toString() == str2[1]) {
        setState(() {
          str = str.replaceFirst(str[2], "a");
          strikes = strikes + 1;
        });
      }
    }

    if (str2.length == 3) {
      for (int i = 0; i < str.length; i++) {
        if (str2[i] == str[i]) {
          setState(() {
            str = str.replaceFirst(str[i], "a");
            strikes = strikes + 1;
          });
        }
      }
    }
    if (strikes == 3) {
      setState(() {
        debugPrint('Strike i');
        strikeOut == true;
      });
    }
    var str3 = keyDigit.toString();

    Set<String> uniqueList = {};
    for (int i = 0; i < str.length; i++) {
      if (str3.contains(str[i])) {
        uniqueList.add(str[i]);
      }
    }
    setState(() {
      balls = uniqueList.length;
    });
  }
}
