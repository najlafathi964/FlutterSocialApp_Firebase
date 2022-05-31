import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cach_helper.dart';
import 'package:social_app/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {

  TextEditingController commentController = TextEditingController();
  String? postId;

  CommentsScreen({this.postId});

  @override
  Widget build(BuildContext context) {
    return  Builder( 
      builder: (context){
        AppCubit.get(context).getComments(postId) ;
        return BlocConsumer<AppCubit , AppStates >(
          listener: (context, state){},
          builder: (context , state){
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  titleSpacing: 0,
                  title:
                      Text('comments' , style: TextStyle(color: Colors.black),)


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
                                var comment = AppCubit.get(context).comments[index] ;

                                return buildCommentItem(comment , context) ;
                              },
                              separatorBuilder: (context , index){
                                return SizedBox(height: 15,);
                              },
                              itemCount: AppCubit.get(context).comments.length),
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
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image!}'),
                              ) ,
                              SizedBox( width: 15,) ,
                              Expanded(
                                  child:TextFormField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                        hintText: 'Type Your Comment Here',
                                        border: InputBorder.none
                                    ),

                                    keyboardType: TextInputType.text,
                                  )
                              ) ,
                              Container(
                                height: 50,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: (){
                                    AppCubit.get(context).createComment(dateTime: DateTime.now().toString(), text: 'lalala' , postId: postId!  ) ;
                                    commentController.text ='' ;
                                  } ,
                                  child: Icon(IconBroken.Send , size: 16, color: Colors.grey,), ),
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

  Widget buildCommentItem(CommentModel commentModel , context) => Container(
    padding: EdgeInsets.symmetric(
        vertical: 5 ,
        horizontal: 10
    ),
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.all(
         Radius.circular(10) ,


        )
    ),
    child: ListTile(
      title:  Text('${commentModel.name}'),
       subtitle: Text('${commentModel.text} '),
      leading:CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage('${commentModel.image}'),
      )  ,

    ),
  ) ;

}