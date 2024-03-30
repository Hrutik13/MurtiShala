
import 'package:flutter/material.dart';

void main()
{
  runApp(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home:Scaffold(
          appBar: AppBar(title: const Text('register'),
          ),
          body: const Register(),
        ),
      )
  );
}

class Register extends StatelessWidget{
  const Register({super.key});
  @override
  Widget build(context){
    return Container(
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.lightBlueAccent,

                child: const Text('Sign up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        )
    );
  }
}







