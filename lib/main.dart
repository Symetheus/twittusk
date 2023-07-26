import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twittusk/data/repository/firebase/firebase_tusk_repository.dart';
import 'package:twittusk/data/repository/local/local_tusk_repository.dart';
import 'package:twittusk/presentation/screens/logic/feed_bloc/feed_bloc.dart';
import 'package:twittusk/presentation/screens/logic/login_bloc/login_bloc.dart';
import 'package:twittusk/presentation/screens/ui/add_tusk_screen/add_tusk_screen.dart';
import 'package:twittusk/presentation/screens/ui/login_screen/login_screen.dart';
import 'package:twittusk/presentation/screens/ui/nav_screen/nav_screen.dart';
import 'package:twittusk/theme/theme.dart';
import 'data/data_source/firebase/firebase_tusk_data_source.dart';
import 'domain/repository/tusk_repository.dart';

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
  FirebaseDynamicLinks.instance.onLink.listen( (pendingDynamicLinkData) {
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
        ],
        child: MaterialApp(
          title: 'Twittusk',
          theme: AppTheme.darkThemeData,
          debugShowCheckedModeBanner: false,
          //home: homeScreen,
          // home: ProfileFeedScreen(user: User(uid: 'uid', username: 'Elon Musk', arobase: 'ElonMusk', email: 'email', profilePicUri: 'https://www.thestreet.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTg4NzYwNTI4NjE5ODQxMDU2/elon-musk_4.jpg', bannerPicUri: 'https://img.phonandroid.com/2021/08/spacex-starship.jpg', bio: 'bio'),),
          routes: {
            NavScreen.routeName: (context) => const NavScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            // FeedScreen.routeName: (context) => const FeedScreen(),
          },
          /*theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),*/
          // home: const FeedScreen(),
          // home: NavScreen(),
          //home: ProfileFeedScreen(user: User(uid: 'uid', username: 'Elon Musk', arobase: 'ElonMusk', email: 'email', profilePicUri: 'https://www.thestreet.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTg4NzYwNTI4NjE5ODQxMDU2/elon-musk_4.jpg', bannerPicUri: 'https://img.phonandroid.com/2021/08/spacex-starship.jpg', bio: 'bio'),),
          home: AddTuskScreen(
            user: User(
                uid: 'uid',
                username: 'Elon Musk',
                arobase: '@ElonMusk',
                email: 'email',
                profilePicUri:
                    'https://www.thestreet.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTg4NzYwNTI4NjE5ODQxMDU2/elon-musk_4.jpg',
                bannerPicUri:
                    'https://img.phonandroid.com/2021/08/spacex-starship.jpg',
                bio: 'bio'),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
