import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twittusk/presentation/screens/logic/current_user_bloc/current_user_bloc.dart';
import 'package:twittusk/presentation/screens/logic/edit_profile_bloc/edit_profile_bloc.dart';
import '../../../../theme/dimens.dart';
import '../../../widgets/buttons/outline_button.dart';
import '../../../widgets/buttons/solid_button.dart';
import '../../../widgets/text_input_solid.dart';
import 'dart:io';

class EditProfileScreen extends StatelessWidget {
  static const routeName = "/edit-profile";
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String uriAvatar = "";
  String uriBanner = "";

  EditProfileScreen({super.key});

  static void navigate(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EditProfileBloc>(context)
        .add(EditProfileGetCurrentUserEvent());
    return Material(
      child: SingleChildScrollView(
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if(state.status == EditProfileStatus.successImage || state.status == EditProfileStatus.success) {
              uriAvatar = state.avatarUri!;
              uriBanner = state.bannerUri!;
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case EditProfileStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case EditProfileStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case EditProfileStatus.error:
                return const Center(
                  child: Text("Something went wrong"),
                );

              default:
                pseudoController.text = state.user!.username;
                emailController.text = state.user!.email;
                bioController.text = state.user!.bio;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Photo de profile"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => _updateAvatar(context),
                              child: CircleAvatar(
                                radius: Dimens.avatarLarge,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(state.avatarUri!),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Image de banière"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => _updateBanner(context),
                              child: Image.network(
                                state.bannerUri!,
                                width: 150,
                                height: Dimens.bannerMinHeight,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextInputSolid(
                        hintText: "Pseudo",
                        controller: pseudoController,
                      ),
                      const SizedBox(height: 20),
                      TextInputSolid(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      TextInputSolid(
                        hintText: "Bio",
                        controller: bioController,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SolidButton(
                            label: "Update",
                            onPressed: () => _update(context),
                            backgroundColor: Theme.of(context).primaryColor,
                          )),
                      const SizedBox(height: 20),
                      OutlineButton(
                        label: "Cancel",
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _onCancel(context),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  void _onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  void _update(BuildContext context) {
    final user = BlocProvider.of<CurrentUserBloc>(context).state.user;
    if (user != null) {
      final updatedUser = user.copyWith(
        username: pseudoController.text,
        email: emailController.text,
        bio: bioController.text,
        bannerPicUri: uriBanner,
        profilePicUri: uriAvatar,
      );
      BlocProvider.of<EditProfileBloc>(context).add(UpdateUserEvent(updatedUser));
      BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUserEvent());
      Navigator.pop(context);
    }
  }

  void _updateAvatar(BuildContext context) async {
    final image = await _pickImage();
    if (image != null) {
      BlocProvider.of<EditProfileBloc>(context)
          .add(UserChangeAvatarEvent(image));
    }
  }

  void _updateBanner(BuildContext context) async {
    final image = await _pickImage();
    if (image != null) {
      BlocProvider.of<EditProfileBloc>(context)
          .add(UserChangeBannerEvent(image));
    }
  }

  Future<File?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
}
