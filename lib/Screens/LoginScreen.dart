import 'package:firebaselogindemo/Firebase/AuthService.dart';
import 'package:firebaselogindemo/Screens/HomeScree.dart';
import 'package:firebaselogindemo/Screens/SignUoScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formLKey=GlobalKey<FormState>();

  bool isVisible=false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  FirebaseAuthHelper helper = FirebaseAuthHelper();

  @override
  Widget build(BuildContext context) {

    
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
                  Text("Sign In",style: TextStyle(
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
                      else if(value.toString().length<6){
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
                      onPressed: () async {
                        if(formLKey.currentState!.validate()){
                          formLKey.currentState!.save();
                          Future<bool> success=helper.login(emailController.text, passwordController.text);
                          if(await success){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Verification Failed")));
                          }
                        }
                    }, child: Text("Login")),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signuoscreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Dont have an Account? Sign in")
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