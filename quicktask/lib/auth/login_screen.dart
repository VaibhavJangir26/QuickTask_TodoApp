import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/auth/signup_screen.dart';
import '../providers/authentication_provider.dart';
import 'forgot_password.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool isPassVisible=false;
  final _formKey=GlobalKey<FormState>();

  void showPassword(){
    setState(() {
      isPassVisible=!isPassVisible;
    });
  }


  @override
  Widget build(BuildContext context) {

    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [

              Container(
                width: width,
                height: height,
                decoration:  const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xfffff1eb),
                        Color(0xfface0f9),]
                  )
                ),
              ),

              SingleChildScrollView(
                child: Container(
                  width: width*.85,
                  height: height*.8,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        const Text("Welcome Back!",style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),),

                        TextFormField(
                          enableSuggestions: true,
                          enableIMEPersonalizedLearning: true,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(emailController.text.isEmpty){
                              return "Enter the email";
                            }
                            if(!value!.contains('@')){
                              return "Enter a valid mail";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey)
                              )
                          ),
                        ),

                        SizedBox(height: height*.02,),

                        TextFormField(
                          controller: passwordController,
                          obscureText: isPassVisible?false:true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if(passwordController.text.isEmpty){
                              return "Enter the Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock,),
                              suffixIcon: IconButton(
                                onPressed: showPassword,
                                icon: isPassVisible?const Icon(Icons.remove_red_eye):const Icon(CupertinoIcons.eye_slash_fill),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey)
                              )
                          ),
                        ),

                        forgotPassword(height, width),

                        loginButton(height, width),

                        // continueWith(height, width),

                        // loginOptions(height, width),

                        SizedBox(height: height*.005,),

                        newRegister(height, width),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotPassword(double height,double width){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPasswordScreen()));
      },
      child: Container(
        width: width,
        height: height*.04,
        alignment: Alignment.centerRight,
        child: const Text("forgot password?",style: TextStyle(color: Colors.blue),),
      ),
    );
  }

  Widget loginButton(double height,double width){
    return Container(
      width: width*.6,
      height: height*.095,
      padding: const EdgeInsets.all(8),

      child: Consumer<AuthenticationProvider>(
        builder: (context,value,widget){
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            onPressed: (){
              if(_formKey.currentState!.validate()){
                value.login(emailController.text.toString(), passwordController.text.toString(),context);
              }
            },
            child: value.isLoading?const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2.5,)):const Text("Login",style: TextStyle(fontSize: 15),),
          );
        },
      ),


    );
  }


  // Widget continueWith(double height,double width){
  //   return Container(
  //     width: width,
  //     height: height*.04,
  //     alignment: Alignment.center,
  //     child: const Text("-or Continue with-"),
  //   );
  // }

  // Widget loginOptions(double height,double width){
  //   return Container(
  //     width: width,
  //     height: height*.08,
  //     padding: const EdgeInsets.all(4),
  //     alignment: Alignment.center,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const CircleAvatar(
  //           foregroundImage: AssetImage(""),
  //           foregroundColor: Colors.grey,
  //         ),
  //         SizedBox(width: width*.02,),
  //         const CircleAvatar(
  //           foregroundColor: Colors.grey,
  //           foregroundImage: AssetImage(""),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget newRegister(double height,double width){
    return Container(
      width: width,
      height: height*.05,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Create an Account?"),
          SizedBox(width: width*.025,),
          InkWell(
              onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup())),
              child: const Text("Sign Up",style: TextStyle(color: Colors.pink),)),
        ],
      ),

    );
  }


}
