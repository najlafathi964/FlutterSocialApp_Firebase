import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is NewPostState) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPostScreen(),
            ));
      }
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            cubit.titels[cubit.currentIndex],
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(IconBroken.Notification),
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(IconBroken.Search),
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {
                cubit.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()),
                        (route) => false);
              },
              icon: Icon((state is! LogoutLoadingState) ?IconBroken.Logout :IconBroken.Arrow___Down_Circle),
              color: Colors.grey,
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            cubit.changeBottomNavBar(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload), label: 'NewPost'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Location), label: 'Users'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: 'Settings'),
          ],
        ),
      );
    });
  }
}

// model != null
// ?Column(
// children: [
// // or  if(!model.isEmailVerified )
// if(!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// color: Colors.amber.withOpacity(0.6),
// height: 50,
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: Row(
// children: [
// Icon(Icons.info_outline ),
// SizedBox(width: 15,) ,
// Expanded(child: Text('Please Verify Your Email')) ,
// SizedBox(width: 20,) ,
// TextButton(onPressed: (){
// FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
// Fluttertoast.showToast(
// msg: 'check your email' ,
// toastLength: Toast.LENGTH_LONG ,
// gravity: ToastGravity.BOTTOM ,
// timeInSecForIosWeb: 5 ,
// fontSize: 16
// );
// }
// ).catchError((error){
//
// });
// } ,
// child: Text('Send '),
// ),
//
// ],
// ),
// ),
// )
// ],
// )
// :CircularProgressIndicator() ,
