import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/cubit/register/register_cubit.dart';
import 'package:social_app/cubit/register/register_state.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/shared/cach_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is CreateUserSuccessState){
            cachHelper.saveData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
            });
            // Navigator.pushAndRemoveUntil(context,
            //     MaterialPageRoute(builder: (context)=> HomeScreen()),
            //         (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('589ac7'),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height,
                          color: HexColor('589ac7'),
                        ),
                        Container(
                          height: size.height,
                          margin: EdgeInsets.only(top: size.height * 0.25),
                          padding: EdgeInsets.only(
                            top: size.height * 0.12,
                            left: 20,
                            right: 20,
                          ),
                          // height: 500,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Create Account',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: HexColor('589ac7'))),
                                  Text('lets go and Communicate with Friends',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.grey)),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        labelText: 'Name',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Your Name';
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        prefixIcon: Icon(Icons.email_outlined),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Your Email Address';
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: phoneController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        labelText: 'Phone',
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Your Phone';
                                      }
                                    },
                                    keyboardType: TextInputType.phone,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    maxLines: 1,
                                    obscureText: cubit.isPassword,

                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock_outline),
                                        suffixIcon: IconButton(
                                          icon: Icon(cubit.suffix),
                                          onPressed: () {
                                            cubit.passwordIconChange();
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Your Password';
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (value) {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                            name: nameController.text);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  (state is! RegisterLoadingState)
                                      ? Container(
                                    height: 50,
                                    width: size.width - 40,
                                    child: MaterialButton(
                                      color: HexColor('589ac7'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(18)),
                                      onPressed: () {
                                        if (formKey.currentState!
                                            .validate()) {
                                         cubit.userRegister(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              email: emailController.text,
                                              password:
                                              passwordController.text);
                                        }
                                      },
                                      child: Text(
                                        "Register ".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                      : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Text('already have an account ? '),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen(),
                                                  ));
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: HexColor('589ac7')),
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        /*
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height:  size.height * 0.01),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 180,
                                    width: 180,
                                    child: Hero(
                                      tag: "lo  "
                                          " "
                                          " g",
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/shop_logo.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )

                         */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
