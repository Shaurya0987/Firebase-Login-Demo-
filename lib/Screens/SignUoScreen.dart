import 'package:firebaselogindemo/Firebase/AuthService.dart';
import 'package:firebaselogindemo/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class Signuoscreen extends StatefulWidget {
  const Signuoscreen({super.key});

  @override
  State<Signuoscreen> createState() => _SignuoscreenState();
}

class _SignuoscreenState extends State<Signuoscreen> {
  final formLKey=GlobalKey<FormState>();

  bool isVisible=false;
  

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    FirebaseAuthHelper helper = FirebaseAuthHelper();
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formLKey,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("Sign Up",style: TextStyle(
                    fontSize: 40
                  ),),
                  SizedBox(height: 50,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter your email...",
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if(value!.isEmpty || !value.contains('@')){
                        return "Enter email correctly";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    obscureText: !isVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isVisible=!isVisible;
                        });
                      }, icon: isVisible?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                      prefixIcon: Icon(Icons.password),
                      hintText: "Enter your password...",
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Password is Empty";
                      }
                      else if(value.length<6){
                        return "Password must be greater than 6 Characters";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if(formLKey.currentState!.validate()){
                          formLKey.currentState!.save();
                          helper.signUp(emailController.text, passwordController.text);
                        }
                    }, child: Text("Sign up")),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Already have an Account? Sign in")
                      ],
                    ),
                  )
                ],
            ))
          ],
        ),
      ),
    );
  }
}