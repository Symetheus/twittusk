import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twittusk/data/dto/tusk_add_dto.dart';
import 'package:twittusk/presentation/widgets/buttons/solid_button.dart';
import 'package:twittusk/presentation/widgets/littleButton.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';
import '../../../../domain/models/user.dart';
import '../../logic/current_user_bloc/current_user_bloc.dart';

class AddTuskScreen extends StatefulWidget {
  const AddTuskScreen({Key? key}) : super(key: key);

  static const routeName = '/add-tusk';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<AddTuskScreen> createState() => _AddTuskScreenState();
}

class _AddTuskScreenState extends State<AddTuskScreen> {
  final TextEditingController _controller = TextEditingController();
  User? _user;
  File? pickedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      setState(() {
        pickedImage = File(image.path);
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUserEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).customColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: Theme.of(context).customColors.onBackground,
          iconSize: Dimens.smallIconSize,
        ),
        title: const Text("Créer un Tusk"),
        actions: [
          LittleButton.primary(
            text: 'Tusker',
            onPressed: () => _onPressed(),
            style: TextButton.styleFrom(
              maximumSize: const Size(Dimens.littleButtonMinWidth,
                  Dimens.littleButtonMinInteractiveTouch),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocConsumer<CurrentUserBloc, CurrentUserState>(
              listener: (context, state) {
                if (state.status == CurrentUserStatus.success) {
                  _user = state.user!;
                }
                if(state.status == CurrentUserStatus.addSuccess){
                  Navigator.pop(context); // pop the add tusk screen
                }
                if(state.status == CurrentUserStatus.addError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Theme.of(context).customColors.error,
                    ),
                  );
                }

              },
              builder: (context, state) {
                print("User : ${state.user}");

                switch (state.status) {
                  case CurrentUserStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  case CurrentUserStatus.success:
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: Dimens.mediumPadding,
                        left: Dimens.mediumPadding,
                        right: Dimens.mediumPadding,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).customColors.surface,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Dimens.smallRadius),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.standardPadding),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  state.user!.profilePicUri,
                                  width: Dimens.avatarSmall,
                                  height: Dimens.avatarSmall,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimens.standardPadding),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          state.user!.username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        const SizedBox(
                                            height: Dimens.minPadding),
                                        Text(
                                          state.user!.arobase,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .customColors
                                                .secondary,
                                            fontSize: Dimens.subtitleTextSize,
                                            fontWeight: FontWeight.w400,
                                            height: Dimens.subtitleLineHeight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  default:
                    return Container();
                }
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.mediumPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).customColors.surface,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Dimens.smallRadius),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.standardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            if (pickedImage != null)
                              Image.file(
                                pickedImage!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            else
                              Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Dimens.standardPadding),
                              child: Container(
                                child: SolidButton(
                                  label: "Ajouter une image",
                                  backgroundColor:
                                      Theme.of(context).customColors.primary,
                                  onPressed: () => pickImage(),
                                  icon: const Icon(
                                      Icons.add_photo_alternate_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).customColors.background,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimens.smallRadius),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top : Dimens.standardPadding),
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    labelText: 'Ecrivez votre Tusk',
                                    border: OutlineInputBorder(),
                                    hintText: 'Ecrivez votre Tusk',
                                    fillColor: Theme.of(context)
                                        .customColors
                                        .surface,
                                    filled: true,

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    final String text = _controller.text;
    if (text.isNotEmpty) {
      if(pickedImage != null){
        BlocProvider.of<CurrentUserBloc>(context).add(CurrentUserAddTuskEvent(_user!, DateTime.now(), text, pickedImage!.path));
      }else{
        BlocProvider.of<CurrentUserBloc>(context).add(CurrentUserAddTuskEvent(_user!, DateTime.now(), text, null));
      }

    }
  }
}
