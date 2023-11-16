import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


 class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
   String userInput = "";
   String result = "0";

   List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
    
   ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body:  Column(
        mainAxisAlignment:  MainAxisAlignment.end,
        children: [
          
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Column(children: [
              Container(padding: EdgeInsets.only(bottom: 10,right: 15, top:120),
              alignment: Alignment.bottomRight,
              child: Text(
                //the objects name
                userInput,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                  ),
                ),
              ),
           Container(padding: 
           EdgeInsets.only(
            right: 10,
            bottom: 0,
            top: 0),
              alignment: Alignment.centerRight,
              child: Text(
                //the objects name
                result,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              )
           
            ],),
          ),
          Divider( color:  Colors.white,),
          Expanded(child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
             itemCount:  buttonList.length,
              gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ), 
                itemBuilder: (
                  BuildContext context, int index) {
                    return CustomButton(buttonList[index]);
                    },
              ),
            
          ))
        ],
      ),
    );
  }
  Widget CustomButton(String text){

    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child:  Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 3,
              spreadRadius: 0.5,
              offset: Offset(-3,-3),
            )
          ]
        ),
        child: Center(
          child: Text(
          text,
          style: TextStyle(
           color: getColor(text),
            fontSize: 32,
            fontWeight: FontWeight.bold)
        ),
)
      ),
    );
  }
  getColor(String text ){
    if(
      text == "/" || 
      text == "*" || 
      text == "-" || 
      text == "+" || 
      text == "C"  || 
      text == "("  || 
      text == ")" ){
      return Colors.red;

    }
    return Colors.white;

    
  }
   getBgColor(String text ){
    if(
      text == "AC"  ){
      return Colors.red;
    }
    if(text == "="){
      return Colors.blueAccent;
    }
    return const Color.fromARGB(255, 39, 39, 39);
  }
  
  handleButtons(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0, userInput.length -1);
        return;
      }
      else{
        return null;
      }
    }
    if(text=="="){
      result = calculate();
      userInput = result;
      
      
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }

          if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        
        return;

      }
    }
    userInput = userInput + text;

  }
  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }catch(e){
      return "Undefined";
    }
  }
}