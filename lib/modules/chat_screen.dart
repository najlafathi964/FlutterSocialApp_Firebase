import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details_screen.dart';

class ChatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates >(
      listener: (context , state){} ,
        builder:(context , state ){
        return (AppCubit.get(context).users.length > 0)
        ?ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildChatItem(AppCubit.get(context).users[index] , context),
            separatorBuilder: (context , index){
              return Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width:  double.infinity ,
                color: Colors.grey,
                height: 1,),
              );
            },
            itemCount: AppCubit.get(context).users.length)
        :Center(child: CircularProgressIndicator());
        });
  }

  Widget buildChatItem(UserModel model , context )=>  InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(userModel: model,)));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('${model.image}'),
          ) ,
          SizedBox( width: 15,) ,
          Text('${model.name}' , style: TextStyle(height: 1.4),),

        ],
      ),
    ),
  );

}