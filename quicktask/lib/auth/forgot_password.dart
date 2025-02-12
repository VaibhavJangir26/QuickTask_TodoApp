import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utility/toast_msg.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  bool isLoading=false;
  TextEditingController emailController=TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();

  Future resetPassword(String email) async{
    setState(() {
      isLoading=true;
    });
    try{
      await auth.sendPasswordResetEmail(email: email).then((value){
        setState(() {
          isLoading=false;
        });
        ToastMsg.toastMsg("Email is send successfully for password reset");
        Navigator.pushNamed(context, "/login");
      }).onError((error,stackTree){
        setState(() {
          isLoading=false;
        });
        ToastMsg.toastMsg(error.toString());
      });
    }on FirebaseException catch(e){
      setState(() {
        isLoading=false;
      });
      ToastMsg.toastMsg(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child:  Form(
                key: _formKey,
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

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text("Forgot Password",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.cyan),
                        ),

                        const Text("We will send you a link to reset your password. Please follow the instructions in the email to change your password.",
                        style: TextStyle(color: Colors.pink),),

                        SizedBox(height: height*.02,),

                        TextFormField(
                          enableSuggestions: true,
                          enableIMEPersonalizedLearning: true,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (emailController.text.isEmpty) {
                              return "Enter the email";
                            }
                            if (!value!.contains('@')) {
                              return "Enter a valid mail";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(
                                Icons.email,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey))
                          ),
                        ),

                        SizedBox(height: height*.02,),

                        SizedBox(
                            width: width/2,
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  isLoading=false;
                                  if(_formKey.currentState!.validate()){
                                    resetPassword(emailController.text.toString());
                                  }
                                });
                              },
                              child: isLoading?const CircularProgressIndicator(strokeWidth: 2,):const Text("Send",style: TextStyle(fontSize: 18),),
                            )
                        ),

                      ],
                      ),
                    ),
                ]
                ),
              ),
            ),
    );
  }
}
