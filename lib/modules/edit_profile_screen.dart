import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app/app_cubit.dart';
import 'package:social_app/cubit/app/app_state.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/shared/componants.dart';
import 'package:social_app/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit
            .get(context)
            .userModel;
        var profileImage = AppCubit
            .get(context)
            .profileImage;
        var coverImage = AppCubit
            .get(context)
            .coverImage;

        nameController.text = userModel!.name!;
        // nameController.selection = TextSelection.fromPosition(
        //     TextPosition(offset: nameController.text.length));
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

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
              'Edit Profile',
              style: TextStyle(color: Colors.blue),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is UserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      4.0,
                                    ),
                                    topRight: Radius.circular(
                                      4.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                      '${userModel.cover}',
                                    )
                                        : FileImage(coverImage)
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  AppCubit.get(context).getCoverImage();
                                },
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                  '${userModel.image}',
                                )
                                    : FileImage(profileImage)
                                as ImageProvider,
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                AppCubit.get(context).getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (AppCubit
                      .get(context)
                      .profileImage != null ||
                      AppCubit
                          .get(context)
                          .coverImage != null)
                    Row(
                      children: [
                        if (AppCubit
                            .get(context)
                            .profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    AppCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload profile',
                                ),
                                if (state is UserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (AppCubit
                            .get(context)
                            .coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    AppCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover',
                                ),
                                if (state is UserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (AppCubit
                      .get(context)
                      .profileImage != null ||
                      AppCubit
                          .get(context)
                          .coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  // TextFormField(
                  //   enabled: true,
                  //   controller: nameController,
                  //   maxLines: 1,
                  //   decoration: InputDecoration(
                  //       labelText: 'Name',
                  //       prefixIcon: Icon(Icons.person),
                  //       border: OutlineInputBorder()),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'name must not be empty';
                  //     }
                  //   },
                  //   keyboardType: TextInputType.text,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  defultFormFieled(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty ';
                        }
                      },
                      label: 'Name',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 20,
                  ),
                  defultFormFieled(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'bio must not be empty ';
                        }
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                  SizedBox(
                    height: 20,
                  ),
                  defultFormFieled(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty ';
                        }
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call),
                  SizedBox(
                    height: 20,
                  ),
                  (state is! LogoutLoadingState)
                      ? Container(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        AppCubit.get(context).signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                                (route) => false);
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.blue),
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
