import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/comment_screen.dart';
import 'package:social_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context ) {
          AppCubit.get(context).getPosts();
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              // print(state);
              // if(state is CreatePostSuccessState){
              //   AppCubit.get(context).getPosts();
              // }
            },
            builder: (context, state) {
              return (AppCubit
                  .get(context)
                  .posts
                  .length > 0) && (AppCubit
                  .get(context)
                  .userModel != null)
                  ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                                '${AppCubit
                                    .get(context)
                                    .userModel!
                                    .cover}'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Communication with frinds',
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),))
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //becouse we in single child scroll view
                      itemBuilder: (context, index) =>
                          buildPostItem(AppCubit
                              .get(context)
                              .posts[index], context, index),
                      itemCount: AppCubit
                          .get(context)
                          .posts
                          .length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 6,),
                    ),
                    SizedBox(height: 8,)

                  ],
                ),
              )

                  : Center(child: CircularProgressIndicator());
            },
          );
        });
  }

  Widget buildPostItem(PostModel model ,context , index ) => Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${model.image}'),
                ) ,
                SizedBox( width: 15,) ,
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${model.name}' , style: TextStyle(height: 1.4),),
                            SizedBox(width: 5,) ,
                            Icon(Icons.check_circle , color: Colors.blue , size: 16,)
                          ],
                        ) ,
                        Text('${model.dateTime}' , style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),)
                      ],
                    )
                ) ,
                SizedBox(width: 15,) ,
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz , size: 16,))

              ],
            ) ,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ) ,
            Text('${model.text}',
              style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w600 , height:  1.3),) ,
            /*
            Padding(
              padding: const EdgeInsets.only(bottom: 10 , top: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: (){} ,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text('#Software',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ) ,

             */
            if(model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 15
                ),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(
                              '${model.postImage}'),
                          fit: BoxFit.cover

                      )
                  ),
                ),
              ) ,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:(){
                        AppCubit.get(context).likePost(AppCubit.get(context).postsId[index] );

                        //  if(state is LikePostSuccessState)
                        //   AppCubit.get(context).getLikes(AppCubit.get(context).postsId[index]);

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(IconBroken.Heart , color: Colors.red,size: 16,),
                            SizedBox(width: 5,) ,
                            Text('${AppCubit.get(context).likes[index]}', style: Theme.of(context).textTheme.caption,) ,
                          ],
                        ),
                      ),
                    ),
                  ) ,

                  Expanded(
                    child: InkWell(
                      onTap:(){
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsScreen()));
                        print('likea ${AppCubit.get(context).likes[index]}');

                        print('comments ${AppCubit.get(context).commentsCount[index]}');
                      },
                      child: Padding(

                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(IconBroken.Chat , color: Colors.amber, size: 16,) ,
                            SizedBox(width: 5,),
                            Text('${AppCubit.get(context).commentsCount[index]}', style: Theme.of(context).textTheme.caption,) ,
                          ],
                        ),
                      ),
                    ),
                  ) ,

                ],
              ),
            ) ,
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ) ,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentsScreen(postId: AppCubit.get(context).postsId[index],)));

                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image!}'),
                        ) ,
                        SizedBox( width: 15,) ,
                        Expanded(
                            child: Text('write comment ...' , style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4
                            ),)
                        ) ,
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){
                    //AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart , color: Colors.red,size: 16,),
                        SizedBox(width: 5,) ,
                        Text('Like', style: Theme.of(context).textTheme.caption,) ,
                      ],
                    ),
                  ),
                ),
              ],
            ) ,


          ],
        ),
      )
  ) ;
}
