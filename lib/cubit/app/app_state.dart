abstract class AppStates {}
class InitialState extends AppStates {}
class GetUserDataLoadingState extends AppStates {}
class GetUserDataSuccessState extends AppStates {}
class GetUserDataErrorState extends AppStates {
  String error ;
  GetUserDataErrorState(this.error);
}

class GetAllUsersLoadingState extends AppStates {}
class GetAllUsersSuccessState extends AppStates {}
class GetAllUsersErrorState extends AppStates {
  String error ;
  GetAllUsersErrorState(this.error);
}
class ChangeNavBottomState extends AppStates{}
class NewPostState extends AppStates{}

class ProfileImagePickedSuccessState extends AppStates {}
class ProfileImagePickedErrorState extends AppStates {}

class CoverImagePickedSuccessState extends AppStates {}
class CoverImagePickedErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}
class UploadProfileImageErrorState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}
class UploadCoverImageErrorState extends AppStates {}

class UserUpdateLoadingState extends AppStates {}
class UserUpdateErrorState extends AppStates {}

class LogoutLoadingState extends AppStates {}
class LogoutSuccessState extends AppStates {}

class GetPostsLoadingState extends AppStates {}
class GetPostsSuccessState extends AppStates {}
class GetPostsErrorState extends AppStates {
  String error;

  GetPostsErrorState(this.error);
}

class GetMyPostsLoadingState extends AppStates {}
class GetMyPostsSuccessState extends AppStates {}
class GetMyPostsErrorState extends AppStates {
  String error;

  GetMyPostsErrorState(this.error);
}

class GetLikesSuccessState extends AppStates {}


class GetCommentsLoadingState extends AppStates {}
class GetCommentsSuccessState extends AppStates {}
class GetCommentsErrorState extends AppStates {
  String error;

  GetCommentsErrorState(this.error);
}

class LikePostSuccessState extends AppStates {}
class LikePostErrorState extends AppStates {
  String error;

  LikePostErrorState(this.error);
}


class PostImagePickedSuccessState extends AppStates {}
class PostImagePickedErrorState extends AppStates {}

class CreatePostLoadingState extends AppStates {}
class CreatePostSuccessState extends AppStates {}
class CreatePostErrorState extends AppStates {
  String error ;
  CreatePostErrorState(this.error);
}

class RemovePostImageState extends AppStates {}

class CreateCommentLoadingState extends AppStates {}
class CreateCommentSuccessState extends AppStates {}
class CreateCommentErrorState extends AppStates {
  String error ;
  CreateCommentErrorState(this.error);
}

class RemoveCommentImageState extends AppStates {}

class SendMessageSuccessState extends AppStates {}
class SendMessageErrorState extends AppStates {
  String error ;
  SendMessageErrorState(this.error);
}

class GetMessageSuccessState extends AppStates {}
class GetMessageErrorState extends AppStates {
  String error ;
  GetMessageErrorState(this.error);
}
