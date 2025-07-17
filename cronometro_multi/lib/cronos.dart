import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';

class Cronos extends StatefulWidget{

  final VoidCallback onDelete;
  final CronometroData data;


  const Cronos({super.key,required this.data, required this.onDelete});

@override
State<Cronos> createState()=> _CronosState();

}

class _CronosState extends State<Cronos> {

  bool _buttonText = false;
  String _stopwatchText = '00:00:00';
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(milliseconds: 1);
  TextEditingController _controller = TextEditingController();

  bool _isMouted = true;

  @override
  void dispose(){
    _isMouted = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _stopwatchText = _formattedTime;
    _buttonText = widget.data.isRunning;
    _controller = widget.data.controller;
    _startStopButtonPressed();
    _startStopButtonPressed();

    
  }
  


  


 //condição para apagar o cronos

 //recurepação de dados



 void parar_tudo(){
  _resetButtonPressed();
  
  
 }


  void _startTimeout() {
    new Timer(_timeout, _handleTimeout);
  }

  void _handleTimeout() {

    if(!_isMouted || !mounted) return;
    if(widget.data.isRunning){
      _startTimeout();
    }
    setState((){
      _setStopwatchText();
    });
  }

  void _startStopButtonPressed() {

    setState((){

      if(widget.data.isRunning){
        _buttonText = false;
        widget.data.isRunning = false;
        _stopWatch.stop();

        widget.data.stopwatch.stop();
        widget.data.isRunning = false;
      }
      else {
         _buttonText = true;
         _stopWatch.start();
        widget.data.isRunning = true;
        widget.data.stopwatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if(widget.data.isRunning) {
      _startStopButtonPressed();
    }
    setState((){
      widget.data.stopwatch.reset();
      _stopWatch.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText(){
    _stopwatchText = widget.data.stopwatch.elapsed.inMinutes.toString().padLeft(2, '0') +
    ':' +
    (widget.data.stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') + ':' +
    (widget.data.stopwatch.elapsed.inMilliseconds % 1000).toString().padLeft(3,'0');
  }

  String get _formattedTime {
  final elapsed = widget.data.stopwatch.elapsed;
  return '${elapsed.inMinutes.toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(elapsed.inMilliseconds % 1000).toString().padLeft(3, '0')}';
}

  @override
  Widget build(BuildContext context){
    return Card(
     margin: const EdgeInsets.all(8),
     child: _buildBody()
    );
  }

  Widget _buildBody(){

    return Column(
     children: <Widget> [
      
      TextField(
        controller: widget.data.controller,
      decoration: InputDecoration(
        labelText: "Me dê um nome",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
        icon: Icon(Icons.clear, size: 18),
        onPressed: () {
          _resetButtonPressed();
           widget.data.controller.clear();
           widget.onDelete();
           _startStopButtonPressed();
           _startStopButtonPressed();
        })
      )
      ),
      SizedBox(
  height: 60, // ou qualquer altura fixa
  child: FittedBox(
    fit: BoxFit.none,
    child: Text(_stopwatchText, style: TextStyle(fontSize: 62)),
  ),
)
      ,Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  width: 100,
                  child:ElevatedButton(
                    child:  Icon(!_buttonText? Icons.play_arrow: Icons.stop),
                    onPressed: _startStopButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_buttonText? Colors.green : Colors.red,
                      foregroundColor: Colors.black)
                  ),
                ),
                SizedBox(width: 100),
                Container(
                  width: 100,
                  child: ElevatedButton(
                    child: Text('Reset'),
                    onPressed: _resetButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                    ),
                  )
                )
              ],
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
     ]
    );
  }
}