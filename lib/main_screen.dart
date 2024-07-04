import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final moneyController = TextEditingController();
  double tips = 0;
  int finalSum = 0;
  bool visibilityTag = false;

  double getTips() {
    return tips;
  }

  double getSumCheck() {
    return double.parse(moneyController.text);
  }

  void changeVisibility(bool tag) {
    setState(() {
      visibilityTag = tag;
    });
  }

  void resetSelection() {
    setState(() {
      tips = 0;
    });
  }

  void setFinalSum() {
    setState(() {
      finalSum = (getSumCheck() + getSumCheck() * getTips()).toInt();
    });
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              alignment: Alignment.bottomLeft,
              child: const Text("Сумма счёта (руб.)")),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: moneyController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'\d{1,}')),
              ],
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.grey),
                  onPressed: moneyController.clear,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
            alignment: Alignment.bottomLeft,
            child: const Text("Размер чаевых"),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('5%'),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                leading: Radio<double>(
                  value: 0.05,
                  groupValue: tips,
                  onChanged: (value) {
                    setState(() {
                      tips = value!.toDouble();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('10%'),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                leading: Radio<double>(
                  value: 0.1,
                  groupValue: tips,
                  onChanged: (value) {
                    setState(() {
                      tips = value!.toDouble();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('15%'),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                leading: Radio<double>(
                  value: 0.15,
                  groupValue: tips,
                  onChanged: (value) {
                    setState(() {
                      tips = value!.toDouble();
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 40.0,
                  child: FilledButton(
                    onPressed: () {
                      if (moneyController.text.isEmpty && tips == 0) {
                        showSnackBar("Пожалуйста, заполните поле и выберите чаевые");
                      } else if (moneyController.text.isEmpty) {
                        showSnackBar("Пожалуйста, заполните поле");
                      } else if (tips == 0) {
                        showSnackBar("Пожалуйста, выберите чаевые");
                      } else {
                        setFinalSum();
                        changeVisibility(true);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple),
                    ),
                    child: const Text('Рассчитать',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 40.0,
                  child: FilledButton(
                    onPressed: () {
                      moneyController.text = "";
                      changeVisibility(false);
                      resetSelection();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple),
                    ),
                    child: const Text('Сброс',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          visibilityTag
              ? Container(
                  margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Итоговая сумма'),
                      Text(
                        '$finalSum руб.',
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ))
              : Container(),
        ],
      ),
    );
  }
}
