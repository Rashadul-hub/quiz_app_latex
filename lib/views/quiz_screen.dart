import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/latex_text.dart';
import '../widgets/option_tile.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  @override
  void initState() {
    super.initState();
    final quizPro = context.read<QuizProvider>();
    quizPro.startTimer(()=>setState((){}), ()=>_onTimeout());
  }

  @override
  void dispose() {
    context.read<QuizProvider>().stopTimer();
    super.dispose();
  }

  void _onTimeout(){
    final quizPro = context.read<QuizProvider>();
    if(quizPro.selected == null) quizPro.select(-1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final quizPro = context.watch<QuizProvider>();
    final question = quizPro.current;
    final locked = quizPro.selected!= null;

    return Scaffold(
      appBar: AppBar(
          title: Text('Q${quizPro.index+1}/${quizPro.total}'),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right:16),
                child: Center(child: Text('${quizPro.secondsLeft}s')))
          ]
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (c, a)=>FadeTransition(opacity: a, child: SlideTransition(position: a.drive(Tween(begin: const Offset(0.1,0), end: Offset.zero)), child: c)),
              child: Column(key: ValueKey(question.id), crossAxisAlignment: CrossAxisAlignment.stretch, children: [

                Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(padding: const EdgeInsets.all(16),
                    child: LatexText(
                        tex:question.question,
                        style: Theme.of(context).textTheme.titleMedium)
                    )),


                ...List.generate(question.options.length, (i)=> OptionTile(
                  label: question.options[i],
                  selected: quizPro.selected==i,
                  correct: i==question.answerIndex,
                  locked: locked,
                  onTap: ()=>quizPro.select(i),
                )),
              ]),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: ()=>{
                      quizPro.restart(), Navigator.pop(context)
                    },
                    child: const Text('Quit')),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: FilledButton(
                    onPressed: locked? null : (){
                      if(quizPro.isLast){
                        quizPro.stopTimer();
                        Navigator.pushReplacementNamed(context, '/result');
                      }else{
                        quizPro.next();
                        quizPro.startTimer(()=> setState(() {}),
                                ()=> _onTimeout());
                      }
                    },
                    child: Text(quizPro.isLast ? 'Finish' : 'Next')
                  ),
                ),

              ],
            )

          ],
        ),
      ),

    );
  }
}

