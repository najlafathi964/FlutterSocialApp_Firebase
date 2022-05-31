import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/register/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(uId: value.user!.uid, name: name, phone: phone, email: email);
      //  emit(RegisterSuccessState());  بنشيلها ليقدر ينشأ اليوزر قبل ما يفوت على الهووم
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void createUser({String? email, String? uId, String? name, String? phone}) {
    UserModel model = UserModel(
        email: email,
        name: name,
        uId: uId,
        image:
            'https://thumbs.dreamstime.com/b/closeup-photo-funny-excited-lady-raise-fists-screaming-loudly-celebrating-money-lottery-winning-wealthy-rich-person-wear-casual-172563278.jpg',
       cover :
       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzyNAiGNMKSkDMMDK8p5VNdy-rzMp515VGTKdg6ZZgjO-AkRem6wK0MQuhDi7ntM8NB6I&usqp=CAU',
        bio : 'Write Your Bio ...' ,
        phone: phone,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uId!));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void passwordIconChange() {
    isPassword = !isPassword;
    if (isPassword) {
      suffix = Icons.visibility_outlined;
    } else {
      suffix = Icons.visibility_off_outlined;
    }
    emit(RegisterPasswordIconChanged());
  }
}
