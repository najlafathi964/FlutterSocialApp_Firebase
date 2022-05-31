import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/cubit/login/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  static LoginCubit get(context) => BlocProvider.of(context);



  void userLogin({required String email , required String password}) {
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void passwordIconChange () {
    isPassword = !isPassword ;
    if(isPassword){
      suffix = Icons.visibility_outlined ;
    }else{
      suffix = Icons.visibility_off_outlined ;

    }
    emit(PasswordIconChanged());

  }

}