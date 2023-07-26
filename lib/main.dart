import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twittusk/data/repository/firebase/firebase_tusk_repository.dart';
import 'package:twittusk/data/repository/local/local_tusk_repository.dart';
import 'package:twittusk/presentation/screens/logic/current_user_bloc/current_user_bloc.dart';
import 'package:twittusk/presentation/screens/logic/feed_bloc/feed_bloc.dart';
import 'package:twittusk/presentation/screens/logic/login_bloc/login_bloc.dart';
import 'package:twittusk/presentation/screens/ui/add_tusk_screen/add_tusk_screen.dart';
import 'package:twittusk/presentation/screens/ui/login_screen/login_screen.dart';
import 'package:twittusk/presentation/screens/ui/nav_screen/nav_screen.dart';
import 'package:twittusk/presentation/screens/ui/profile_feed_screen/profile_feed_screen.dart';
import 'package:twittusk/theme/theme.dart';
import 'data/data_source/firebase/firebase_tusk_data_source.dart';
import 'domain/repository/tusk_repository.dart';
import 'package:twittusk/domain/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  await Firebase.initializeApp();
  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    print(deepLink.path); // TODO: handle deep link
    //Navigator.pushNamed(context, deepLink.path);
  }
  FirebaseDynamicLinks.instance.onLink.listen(
    (pendingDynamicLinkData) {
      if (pendingDynamicLinkData != null) {
        final Uri deepLink = pendingDynamicLinkData.link;
        print(deepLink.path); // TODO: handle deep link
        //Navigator.pushNamed(context, deepLink.path);
      }
    },
  );

  final homeScreen = FirebaseAuth.instance.currentUser == null
      ? const LoginScreen()
      : const NavScreen();
  runApp(MyApp(homeScreen: homeScreen));
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;

  const MyApp({super.key, this.homeScreen = const LoginScreen()});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TuskRepository>(
          create: (context) => LocalTuskRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FeedBloc>(
            create: (context) => FeedBloc(
              FirebaseTuskRepository(
                FirebaseTuskDataSource(),
              ),
            ),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              FirebaseTuskRepository(
                FirebaseTuskDataSource(),
              ),
            ),
          ),
          BlocProvider<CurrentUserBloc>(
            create: (context) => CurrentUserBloc(
              FirebaseTuskRepository(
                FirebaseTuskDataSource(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
            title: 'Twittusk',
            theme: AppTheme.darkThemeData,
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => homeScreen,
              NavScreen.routeName: (context) => const NavScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              AddTuskScreen.routeName: (context) => const AddTuskScreen(),
              // FeedScreen.routeName: (context) => const FeedScreen(),
            },
            onGenerateRoute: (settings) {
              Widget content = const SizedBox.shrink();

              switch (settings.name) {
                case ProfileFeedScreen.routeName:
                  final arguments = settings.arguments;
                  if (arguments != null && arguments is User) {
                    content = ProfileFeedScreen(user: arguments);
                  }
              }
              return MaterialPageRoute(builder: (context) => content);
            }
            /*theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),*/

            ),
      ),
    );
  }
}
