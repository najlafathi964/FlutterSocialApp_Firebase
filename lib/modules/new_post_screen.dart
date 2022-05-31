import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.blue,
              ),
            ),
            titleSpacing: 5.0,
            title: Text(
              'Create Post',
              style: TextStyle(color: Colors.blue),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if(AppCubit.get(context).postImage == null){
                    AppCubit.get(context).createPost(dateTime: now.toString(), text: textController.text) ;
                  }else{
                    AppCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text) ;
                  }

                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HomeScreen()));

                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel!.image!}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${AppCubit.get(context).userModel!.name!}',
                        style: TextStyle(height: 1.4),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(AppCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image:  FileImage(AppCubit.get(context).postImage!)
                          as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                      onPressed: () {
                        AppCubit.get(context).removePostImage();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            AppCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Image),
                              Text('add photos'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                        },
                        child: Text('#tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
