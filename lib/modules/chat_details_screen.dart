import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget{

  final TextEditingController messageController = TextEditingController();
  UserModel? userModel ;
  ChatDetailsScreen({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        AppCubit.get(context).getMessage(reciverId: userModel!.uId!) ;
        return BlocConsumer<AppCubit , AppStates >(
          listener: (context, state){},
          builder: (context , state){
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    SizedBox(width: 15,),
                    Text('${userModel!.name}' , style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            //  body: (AppCubit.get(context).messages.length > 0)
            //  ?
              body:  Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context , index){
                              var message = AppCubit.get(context).messages[index] ;
                              if(AppCubit.get(context).userModel!.uId! == message.senderId){
                                return buildSenderMessage(message) ;
                              }
                              return buildReciverMessage(message) ;
                            },
                            separatorBuilder: (context , index){
                              return SizedBox(height: 15,);
                            },
                            itemCount: AppCubit.get(context).messages.length),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]! ,
                                width: 1
                            ) ,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController ,
                               /* decoration: InputDecoration(
                                    contentPadding: EdgeInsetsDirectional.only(start: 20),
                                    border: InputBorder.none ,
                                    hintText: 'Type Your Massege Here .. '
                                ),*/
                              ),
                            ) ,
                            Container(
                              height: 50,
                              color: Colors.blue,
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: (){
                                  AppCubit.get(context).sendMessage(
                                      reciverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text) ;
                                  messageController.text ='' ;
                                } ,
                                child: Icon(IconBroken.Send , size: 16, color: Colors.white,), ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
               //   :Center(child: CircularProgressIndicator())
            ) ;
          },
        ) ;
      },
    );
  }
  
  Widget buildReciverMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5 ,
          horizontal: 10
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10) ,
            topStart: Radius.circular(10) ,
            topEnd: Radius.circular(10) ,


          )
      ),
      child: Text('${messageModel.text}'),
    ),
  ) ;

  Widget buildSenderMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5 ,
          horizontal: 10
      ),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.2),

          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10) ,
            topStart: Radius.circular(10) ,
            topEnd: Radius.circular(10) ,


          )
      ),
      child: Text('${messageModel.text}'),
    ),
  ) ;
}