import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/shared/cach_helper.dart';


Future<void> firebaseMassegingBackgroundHandler(RemoteMessage message) async{

}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp() ;

  var token = FirebaseMessaging.instance.getToken();

  // ما بظهر في لائحة الاشعار و لكن بينفذ ال event لو فاتح التطبيق ووصل اشعار
  FirebaseMessaging.onMessage.listen((event) {

  });
//لو التطبيق مسكر ووصل اشعار
  FirebaseMessaging.onMessageOpenedApp.listen((event) {

  });
  //بينفذ بالخلفية الامر
  FirebaseMessaging.onBackgroundMessage(firebaseMassegingBackgroundHandler);

  print(token);
  await cachHelper.init();
  var uId = cachHelper.getData(key: 'uId');
  Widget widget ;

  if(uId != null ){
    widget = HomeScreen() ;
  }else {
    widget = LoginScreen();
  }
  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget ;

   MyApp({ this.startWidget}) ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit() .. getUserData() .. getPosts()  ,
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state) {},
        builder: (context , state ) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'social app',
          theme: ThemeData(
          primarySwatch: Colors.blue,
            bottomAppBarColor: Colors.white ,
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.white
            )
          ),
          home: startWidget,
          );
        }
      ),
    );
  }
}
