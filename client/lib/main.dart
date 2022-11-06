import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import './utils/router.dart' as router;
import './utils/routing_names.dart';
//import './InitialScreen/register_screen.dart';
import './utils/dependency_injection.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import './utils/global_variables.dart';

//final injector = Injector();
void main() async {
  // DependencyInjection().initialize(injector);
  // //injector = Injector.getInjector();
  // await SocketInitializer().initialize(injector);
  runApp(const MyApp());
}

GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: globalKey,
        // theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     scaffoldBackgroundColor: Colors.deepPurpleAccent),
        //home: const SafeArea(child: InittialScreen()),
        onGenerateRoute: router.generateRoute,
        initialRoute: InitialScreenView,
      ),
    );
  }
}
