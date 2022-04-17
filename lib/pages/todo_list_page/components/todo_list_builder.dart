import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_todo_list/database/database.dart';
import 'package:windows_todo_list/widget/add_edit_todo_content.dart';
import 'package:windows_todo_list/widget/remove_dialog.dart';

class TodoListBuilder extends StatefulWidget {
  final List<TodoData> todos;
  final Function? onUpdated;

  const TodoListBuilder({
    Key? key,
    required this.todos,
    this.onUpdated,
  }) : super(key: key);

  @override
  State<TodoListBuilder> createState() => _TodoListBuilderState();
}

class _TodoListBuilderState extends State<TodoListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        var todo = widget.todos[index];

        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddEditTodoContent(
                    todo: todo,
                    onUpdated: widget.onUpdated,
                  );
                });
          },
          child: ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: todo.isFinished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(todo.description),
            trailing: IconButton(
              icon: const Icon(FluentIcons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RemoveDialog(
                      onRemovePressed: () async {
                        await Provider.of<Database>(context, listen: false).deleteTodo(todo);
                        widget.onUpdated!();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
