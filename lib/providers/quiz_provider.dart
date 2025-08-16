import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../models/question.dart';

class QuizProvider extends ChangeNotifier{
  final List<Question> _all;
  late List<Question> _questions;
  int _index = 0;
  int _score = 0;
  int? _selected;
  String _category = 'All';

  final int perQuestionSeconds;
  int _secondsLeft;
  Timer? _timer;

  QuizProvider(this._all,{this.perQuestionSeconds =10})
      : _secondsLeft = perQuestionSeconds{
    _questions = _all;
  }


  List<String> get categories => [
    'All',
    ...{
      for (final q in _all) q.category
    }];

  String get category => _category;
  int get index => _index;
  int get total => _questions.length;
  int get score => _score;
  int? get selected => _selected;
  int get secondsLeft => _secondsLeft;
  Question get current => _questions[_index];


  void setCategory(String c){
    _category = c;
    _questions = c == 'All' ? _all :_all.where((q) => q.category == c).toList();
    _resetQuiz();
    notifyListeners();
  }

  void startTimer(void Function() onTick, void Function() onTimeout){
    _timer?.cancel();
    _secondsLeft = perQuestionSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_){
      _secondsLeft --;
      onTick();
      if(secondsLeft <= 0){
        _timer?.cancel();
        _selected ??= -1;
        onTimeout();
      }
    });
  }

  void stopTimer(){
    _timer?.cancel();
  }

  void select(int i){
    if(_selected!=null) return;
    _selected=i;
    if(i==current.answerIndex) _score++;
    notifyListeners();
  }


  bool get isLast => _index==total-1;


  void next(){
    if(_selected==null) return;
    _index++;
    _selected=null;
    _secondsLeft=perQuestionSeconds;
    notifyListeners();
  }

  void _resetQuiz(){
    _index=0;
    _score=0;
    _selected=null;
    _secondsLeft=perQuestionSeconds;
    stopTimer();
  }

  void restart(){
    _resetQuiz();
    notifyListeners();
  }


}
