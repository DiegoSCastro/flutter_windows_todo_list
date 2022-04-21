import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_todo_list/database/database.dart';
import 'package:windows_todo_list/pages/todo_list_page/components/todo_list_builder.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TodoData>>(
      future: Provider.of<Database>(context, listen: false).getAllTodo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Empty List'),
            );
          } else {
            return TodoListBuilder(
              todos: snapshot.data ?? [],
              onUpdated: () {
                setState(() {});
              },
            );
          }
        } else {
          return const Center(
            child: ProgressRing(),
          );
        }
      },
    );
  }
}
