import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_screen.dart';
import 'package:social_app/modules/feed_screen.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/cach_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/cach_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    var uId = cachHelper.getData(key: 'uId');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(ProfileImagePickedErrorState());
    }
  }
  void uploadProfileImage(
      {
        required String name,
        required String phone,
        required String bio,
      }
      ) {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       // emit(UploadProfileImageSuccessState());
        updateUser(name: name, phone: phone, bio: bio , image:value) ;
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }



  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       // emit(UploadCoverImageSuccessState());
        updateUser(name: name, phone: phone, bio: bio , cover: value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  /*void updateUserImages({
    required String name ,
    required String phone ,
    required String bio
  }){
    emit(UserUpdateLoadingState());
    if(coverImage != null){
      uploadCoverImage();
    }else if(profileImage != null){
      uploadProfileImage();
    }else if (coverImage != null && profileImage != null){

    }else{
      updateUser(name: name , phone: phone , bio: bio) ;
    }

  }*/
  void updateUser({
    required String name ,
    required String phone ,
    required String bio ,
    String? cover ,
    String? image
  }){
    UserModel model = UserModel(
        name: name,
        email:userModel!.email ,
        uId: userModel!.uId,
        bio : bio ,
        phone: phone,
        image: image ?? userModel!.image ,
        cover: cover ?? userModel!.cover,
        isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value){
      getUserData();
    }).catchError((error){
      emit(UserUpdateErrorState());
    });
  }
 Future<void> signOut () async {
    emit(LogoutLoadingState());
    await FirebaseAuth.instance.signOut() .then((value) {
      cachHelper.removeData(key: 'uId').then((value) {
        emit(LogoutSuccessState()) ;

      }) ;
    }) ;
 }
  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(PostImagePickedErrorState());
    }
  }
  void uploadPostImage({
    required String dateTime ,
    required String text ,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text , postImage: value) ;

      }).catchError((error) {
        emit(CreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }

  void createPost({
    required String dateTime ,
    required String text ,
    String? postImage
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image:userModel!.image ,
        dateTime: dateTime ,
        text: text ,
        postImage: postImage??''

    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          emit(CreatePostSuccessState());
    }).catchError((error){
      emit(CreatePostErrorState(error.toString()));
    });
  }

  void createComment({
     String? commentImage ,
    required String dateTime ,
    required String text ,
    required String postId
  }){
    CommentModel commentModel = CommentModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image:userModel!.image ,
        dateTime: dateTime ,
        text: text ,
        commentImage: commentImage??''

    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
    //     .doc(userModel!.uId)
    // .collection('myComments')
        .add(commentModel.toMap())
        .then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error){
      emit(CreateCommentErrorState(error.toString()));
    });

  }

  List<CommentModel> comments =[] ;

  void getComments(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
    // .doc(userModel!.uId)
    // .collection('myComments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments=[] ;
     // commentsCount =[] ;
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      //  commentsCount.add(element.data().length);
       // print(commentsCount);

      });

      emit(GetCommentsSuccessState());
    });
  }
  void removePostImage(){
    postImage = null ;
    emit(RemovePostImageState());
  }
  List<PostModel> posts = [];
  List<String> postsId =[];
  List<int> likes = [] ;
  List<int> commentsCount =[] ;

  void getPosts(){
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((event) {
      posts=[] ;
      likes=[];
      postsId=[];
      commentsCount =[] ;
      event.docs.forEach((element) {
        element.reference
            .collection('comment')
            .get()
            .then((value){
          commentsCount.add(value.docs.length);
          print('comments count ${value.docs.length}');



        });
        element.reference
            .collection('likes')
            .get()
            .then((value){
          likes.add(value.docs.length);
          print('likes count = ${value.docs.length}');

          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));


        });

        emit(GetPostsSuccessState());
      });

    });
  }

  List<PostModel> myPosts =[] ;
  List<String> myPostsId =[];
  List<int> myLikes = [] ;
  List<int> myCommentsCount =[] ;
  void getMyPosts(){
    emit(GetMyPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
    .where('uId', isEqualTo: userModel!.uId)
    //.orderBy('dateTime' , descending: true)
        .snapshots()
        .listen((event) {
      myPosts=[] ;
      myLikes=[];
      myPostsId=[];
      myCommentsCount =[] ;
      event.docs.forEach((element) {
                element.reference
                .collection('comment')
                .get()
                .then((value){
                  myCommentsCount.add(value.docs.length);
                  print('comments count ${value.docs.first} ${value.docs.length}');



                });
                element.reference
                    .collection('likes')
                    .get()
                    .then((value){
                  myLikes.add(value.docs.length);
                  print('likes count = ${value.docs.length}');

                  myPostsId.add(element.id);
                  myPosts.add(PostModel.fromJson(element.data()));


                });


                emit(GetMyPostsSuccessState());
                });

    });
  }

  void likePost (String postId ){
     FirebaseFirestore.instance
     .collection('posts')
     .doc(postId)
     .collection('likes')
     .doc(userModel!.uId)
     .set({'like':true}).then((value) {
       emit(LikePostSuccessState());
     }).catchError((error){
       emit(LikePostErrorState(error.toString()));
     }) ;
  }
  List<UserModel> users = [] ;
  void getUsers(){
    emit(GetAllUsersLoadingState());
//if(users.length == 0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if(element.data()['uId'] != userModel!.uId) // to get all users without me
            users.add(UserModel.fromJson(element.data()));
          });
          emit(GetAllUsersSuccessState());


    }).catchError((error){
      emit(GetAllUsersErrorState(error.toString()));

    });
  }

  void sendMessage({
  required String reciverId ,
    required String dateTime ,
    required text
}){
    MessageModel messageModel = MessageModel(
      text: text ,
      dateTime: dateTime ,
      senderId: userModel!.uId,
      receiverId: reciverId
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(reciverId)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages  =[];

  void getMessage({required String reciverId}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[] ;
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessageSuccessState());
    });
  }
  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titels = ['Home', 'Chat', 'Posts', 'Users', 'Settings'];

  void changeBottomNavBar(int index) {

    if(index ==1 ){
      getUsers() ;
    }

    if (index == 2)
      emit(NewPostState());
    else {
      currentIndex = index;
      emit(ChangeNavBottomState());
    }
  }
}
