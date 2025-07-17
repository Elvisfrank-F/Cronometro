import 'package:flutter/material.dart';
import 'dart:async';
import 'cronos.dart';

class CronometroData{
  final Key key;
  final TextEditingController controller;
  final Stopwatch stopwatch;
  bool isRunning;

  CronometroData(this.key) : controller = TextEditingController(),
  stopwatch = Stopwatch(), isRunning = false;
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CronometroData> _cronometros = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addCronos() {
    final key = UniqueKey();
    final newItem = CronometroData(key);
    _cronometros.add(newItem);
    _listKey.currentState?.insertItem(_cronometros.length - 1);

    setState(() {
      
    });
  }

  void _removeCrono(int index) {
    final removedItem = _cronometros.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, index, animation),
      duration: Duration(milliseconds: 500),
    );

    setState(() {
      
    });
  }

  Widget _buildItem(CronometroData data, int index, Animation<double> animation) {


    return SizeTransition(
      sizeFactor: animation,
      child: Cronos(
        key: data.key,
        data: data,
        onDelete: () => _removeCrono(index),
      ),
    );

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cronômetro com animação"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: 0,
                itemBuilder: (context, index, animation) {
                  return _buildItem(_cronometros[index], index, animation);
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addCronos,
              icon: Icon(Icons.add),
              label: Text("Adicionar"),
              style: ElevatedButton.styleFrom(minimumSize: Size(180, 65)),
            )
          ],
        ),
      ),
    );
  }
}