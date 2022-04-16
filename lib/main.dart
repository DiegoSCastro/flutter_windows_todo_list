import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_todo_list/database/database.dart';
import 'package:windows_todo_list/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Database>(
      create: (context) => Database(),
      child: FluentApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const Home(),
      ),
    );
  }
}
