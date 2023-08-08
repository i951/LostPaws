part of 'create_post_bloc.dart';

enum CreatePostStatus {
  initial,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  invalidPhone,
}

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(CreatePostStatus.initial) CreatePostStatus status,
    String? error,
    @Default(false) bool autoValidate,
    PostTypeOption? postType,
    @Default("") String postTitle,
    @Default([]) List<String> photoPaths,
    PetTypeOption? petType,
    String? breed,
    PetColour? colour,
    String? weight,
    String? size,
    DateTime? dateLastSeen,
    LocationLastSeen? locationLastSeen,
    String? description,
    String? contactPhoneStart,
    String? contactPhoneMiddle,
    String? contactPhoneEnd,
  }) = _CreatePostState;
}
