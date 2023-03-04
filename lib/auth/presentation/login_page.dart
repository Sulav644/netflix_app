import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:netflix_app/netflix_app/home_page/netflix_page.dart';
import 'package:netflix_app/auth/presentation/login_form.dart';
import 'package:netflix_app/auth/application/response_repos_cubit.dart';
import 'package:netflix_app/auth/infrastructure/response_repos_notifier.dart';

import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils.dart';
import '../../loader_page.dart';
import '../infrastructure/user_details.dart';
import 'components/image_picker.dart';

enum TextFormValidStatus {
  textFormOneValid,
  textFormOneInvalid,
  textFormTwoValid,
  textFormTwoInvalid,
  textFormThreeValid,
  textFormThreeInvalid,
  textFormFourValid,
  textFormFourInvalid,
  textFormFiveValid,
  textFormFiveInvalid,
}

enum LoginProps { height }

class RangeSelectorPage extends StatefulWidget {
  const RangeSelectorPage({super.key});

  @override
  State<RangeSelectorPage> createState() => _RangeSelectorPageState();
}

class _RangeSelectorPageState extends State<RangeSelectorPage>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  FocusNode focusNodeFirstName = FocusNode(),
      focusNodeLastName = FocusNode(),
      focusNodePhoneNumber = FocusNode(),
      focusNodeEmail = FocusNode(),
      focusNodePassword = FocusNode();
  int phone = 0;
  String _firstName = '';
  String _lastName = '';
  String email = '';
  String password = '';

  late AnimationController controller;

  late Animation<TimelineValue<LoginProps>> animation;
  late Dio dio;
  int statusCode = 0;
  void fetch() async {
    final res =
        await dio.getUri(Uri.https('jsonplaceholder.typicode.com', 'photos'));
    if (res.statusCode == 200) {
      setState(() {
        statusCode = res.statusCode!;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    focusNodeFirstName.requestFocus();
    dio = Dio();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = TimelineTween<LoginProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 1000.milliseconds,
          curve: Curves.ease,
        )
        .animate(LoginProps.height, tween: Tween(begin: 60.0, end: 10.0))
        .parent
        .animatedBy(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailStatus = context.watch<DetailsCubit>();
    final imagePreview = context.watch<ImagePreviewCubit>().state;
    final loginStatus = context.read<LoginVerifyCubit>();

    final pickedConfirmImageStatus =
        context.watch<PickedConfirmImageCubit>().state;
    void unFocusTextFields() {
      focusNodeFirstName.unfocus();
      focusNodeLastName.unfocus();
      focusNodePhoneNumber.unfocus();
      focusNodeEmail.unfocus();
      focusNodePassword.unfocus();
    }

    return GestureDetector(
      onTap: () {
        unFocusTextFields();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, state) {
                  return SizedBox(
                    height: animation.value.get(LoginProps.height),
                  );
                },
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        verticalSpace(getHeightRatio(context, 0.03)),
                        defaultTextStyle(
                            Colors.red,
                            Text('project90'.toUpperCase()),
                            25,
                            FontWeight.bold),
                        verticalSpace(getHeightRatio(context, 0.03)),
                        if (pickedConfirmImageStatus ==
                                ImagePickedConfirmStatus.imageConfirmed ||
                            pickedConfirmImageStatus ==
                                ImagePickedConfirmStatus.none ||
                            pickedConfirmImageStatus ==
                                ImagePickedConfirmStatus.imageCanceled)
                          const ImagePickerPage(),
                        if (pickedConfirmImageStatus ==
                            ImagePickedConfirmStatus.imagePicked)
                          verticalSpace(getHeightRatio(context, 0.2)),
                        verticalSpace(getHeightRatio(context, 0.05)),
                        RangeSelectorForm(
                          formKey: formKey,
                          focusNodeFirstName: focusNodeFirstName,
                          focusNodeLastName: focusNodeLastName,
                          focusNodePhoneNumber: focusNodePhoneNumber,
                          focusNodeEmail: focusNodeEmail,
                          focusNodePassword: focusNodePassword,
                          minValueSetter: (value) => phone = value,
                          firstValueSetter: (value) => _firstName = value,
                          lastValueSetter: (value) => _lastName = value,
                          emailValueSetter: (value) => email = value,
                          passwordValueSetter: (value) => password = value,
                        ),
                        verticalSpace(15),
                        blocConsumer(detailStatus, loginStatus),
                      ],
                    ),
                  ),
                  if (pickedConfirmImageStatus ==
                      ImagePickedConfirmStatus.imagePicked)
                    ProfilePictureSelectDialog(imagePreview: imagePreview),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
  Future<dynamic> navigateToHomePage() =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoaderPage(
          goToPage: NetFlixPage(pageState: PageState.newComing),
        );
      }));
  Widget blocConsumer(
          DetailsCubit detailStatus, LoginVerifyCubit loginStatus) =>
      BlocConsumer<ResponseReposNotifier, ResponseReposState>(
        listener: (context, state) {
          state.map(
              initial: (_) => debugPrint(''),
              loadInProgress: (_) => debugPrint(''),
              loadSuccess: (_) {
                if (!_.repos.isFresh) {
                  showSnackBar(
                      'no% internet connection'.capitalizeAndTrimOneWord());
                } else {
                  navigateToHomePage();
                }
              },
              loadFailure: (_) => debugPrint(''));
        },
        builder: (context, state) {
          return LoginButton(
            responseReposState: state,
            firstName: _firstName,
            lastName: _lastName,
            phone: phone,
            email: email,
            password: password,
            loginStatus: loginStatus,
            detailStatus: detailStatus,
            statusCode: statusCode,
          );
        },
      );
}

class LoginButton extends StatelessWidget {
  final int phone;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final LoginVerifyCubit loginStatus;
  final DetailsCubit detailStatus;
  final int statusCode;
  final ResponseReposState responseReposState;
  final RangeSelectorPage rangeSelectorPage = const RangeSelectorPage();
  const LoginButton({
    super.key,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.loginStatus,
    required this.detailStatus,
    required this.statusCode,
    required this.responseReposState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(responseReposState.map(
                  initial: (_) => const Color.fromARGB(255, 26, 25, 25),
                  loadInProgress: (_) => Colors.red,
                  loadSuccess: (_) {
                    if (!_.repos.isFresh) {
                      return const Color.fromARGB(255, 26, 25, 25);
                    } else {
                      return Colors.red;
                    }
                  },
                  loadFailure: (_) => const Color.fromARGB(255, 26, 25, 25))),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: responseReposState.map(
                              initial: (_) => Colors.white,
                              loadInProgress: (_) => Colors.red,
                              loadSuccess: (_) {
                                if (!_.repos.isFresh) {
                                  return Colors.white;
                                } else {
                                  return Colors.red;
                                }
                              },
                              loadFailure: (_) => Colors.white))))),
          onPressed: () {
            if (firstName == '') {
              loginStatus.setFirstName(const Validation.empty());
            } else if (firstName != '' && firstName.length < 3) {
              loginStatus.setFirstName(const Validation.notMatchedPattern());
            } else {
              loginStatus.setFirstName(const Validation.valid());
              detailStatus.addFirstName(firstName);
            }

            if (lastName == '') {
              loginStatus.setLastName(const Validation.empty());
            } else if (lastName != '' && lastName.length < 3) {
              loginStatus.setLastName(const Validation.notMatchedPattern());
            } else {
              loginStatus.setLastName(const Validation.valid());
              detailStatus.addLastName(lastName);
            }

            if (phone == 0) {
              loginStatus.setPhoneNumber(const Validation.empty());
            } else if (phone != 0 && phone.toString().length < 10) {
              loginStatus.setPhoneNumber(const Validation.notMatchedPattern());
            } else {
              loginStatus.setPhoneNumber(const Validation.valid());
              detailStatus.addPhone(phone);
            }

            if (email == '') {
              loginStatus.setEmail(const Validation.empty());
            } else if (email != '' && !isEmail(email)) {
              loginStatus.setEmail(const Validation.notMatchedPattern());
            } else {
              loginStatus.setEmail(const Validation.valid());
              detailStatus.addEmail(email);
            }

            if (password == '') {
              loginStatus.setPassword(const Validation.empty());
            } else if (password != '' && !isPassword(password)) {
              loginStatus.setPassword(const Validation.notMatchedPattern());
            } else {
              loginStatus.setPassword(const Validation.valid());
              detailStatus.addPassword(password);
            }

            final isVerified = context.read<DetailsCubit>().isVerified();
            if (isVerified) {
              context.read<ResponseReposNotifier>().getResponseReposPage();
            }
          },
          child: responseReposState.map(
              initial: (_) => Text(
                    'login'.capitalize(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              loadInProgress: (_) => const CircularProgressIndicator(),
              loadSuccess: (_) => Text(
                    'login'.capitalize(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              loadFailure: (_) => Text(
                    'login'.capitalize(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ))),
    );
  }
}

class ProfilePictureSelectDialog extends StatelessWidget {
  final ImagePreview imagePreview;
  const ProfilePictureSelectDialog({super.key, required this.imagePreview});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context),
      height: getHeightRatio(context, 0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: getWidthRatio(context, 0.8),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 49, 49, 49),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  verticalSpace(60),
                  CircleAvatar(
                    backgroundImage: FileImage(
                      imagePreview.image!,
                    ),
                    radius: 85,
                  ),
                  verticalSpace(60),
                  ProfilePictureButtons(imagePreview: imagePreview),
                  verticalSpace(60),
                ],
              )),
        ],
      ),
    );
  }
}

class ProfilePictureButtons extends StatelessWidget {
  final ImagePreview imagePreview;
  const ProfilePictureButtons({super.key, required this.imagePreview});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfilePictureButton(
            imagePreview: imagePreview,
            onPressed: () {
              context.read<DetailsCubit>().addImage(imagePreview.image!);
              context.read<PickedConfirmImageCubit>().setImageConfirmed();
            },
            title: 'save^'),
        horizontalSpace(20),
        ProfilePictureButton(
            imagePreview: imagePreview,
            onPressed: () {
              context.read<PickedConfirmImageCubit>().setImageNone();
            },
            title: 'cancel^'),
      ],
    );
  }
}

class ProfilePictureButton extends StatelessWidget {
  final ImagePreview imagePreview;
  final VoidCallback onPressed;
  final String title;
  const ProfilePictureButton(
      {super.key,
      required this.imagePreview,
      required this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 39, 39, 39)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.red)))),
        onPressed: onPressed,
        child: Text(title.capitalizeAndTrim()));
  }
}

class Details {
  File? image;
  String? firstName;
  String? lastName;
  int? phone;
  String? email;
  String? password;
  Details(
      {this.image,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.password});
  Details copyWith({
    File? image,
    String? firstName,
    String? lastName,
    int? phone,
    String? email,
    String? password,
  }) {
    return Details(
        image: this.image ?? image,
        firstName: this.firstName ?? firstName,
        lastName: this.lastName ?? lastName,
        phone: this.phone ?? phone,
        email: this.email ?? email,
        password: this.password ?? password);
  }
}

class ImagePreview {
  File? image;

  ImagePreview({
    this.image,
  });
  ImagePreview copyWith({
    File? image,
  }) {
    return ImagePreview(
      image: this.image ?? image,
    );
  }
}

class ImagePreviewCubit extends Cubit<ImagePreview> {
  ImagePreviewCubit() : super(ImagePreview().copyWith());
  ImagePreview imagePreview = ImagePreview().copyWith();
  void setImagePreview(File file) {
    ImagePreview i = imagePreview.copyWith(image: file);
    emit(i);
  }
}

class LoginVerifyCubit extends Cubit<LoginVerify> {
  LoginVerifyCubit() : super(const LoginVerify());
  void setFirstName(Validation firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void setLastName(Validation lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void setPhoneNumber(Validation phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void setEmail(Validation email) {
    emit(state.copyWith(email: email));
  }

  void setPassword(Validation password) {
    emit(state.copyWith(password: password));
  }
}

class DetailsCubit extends Cubit<UserDetails> {
  DetailsCubit() : super(const UserDetails());

  void addImage(File imgUrl) {
    emit(state.copyWith(image: imgUrl));
  }

  void addFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void addLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void addPhone(int phone) {
    emit(state.copyWith(phone: phone));
  }

  void addEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void addPassword(String password) {
    emit(state.copyWith(password: password));
  }

  bool isVerified() {
    if (state.firstName != '' &&
        state.phone != 0 &&
        state.email != '' &&
        state.password != '') {
      return true;
    } else {
      return false;
    }
  }
}
