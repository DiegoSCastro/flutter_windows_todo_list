import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_todo_list/database/database.dart';
import 'package:windows_todo_list/widget/add_edit_todo_content.dart';

class ContentBody extends StatefulWidget {
  const ContentBody({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  State<ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends State<ContentBody> {
  @override
  Widget build(BuildContext context) {
    return NavigationBody(
      index: widget.selectedIndex,
      children: [
        FutureBuilder<List<TodoData>>(
            future: Provider.of<Database>(context, listen: false).getAllTodo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Empty List'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var todo = snapshot.data![index];

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddEditTodoContent(
                                    todo: todo,
                                    onUpdated: () {
                                      setState(() {});
                                    },
                                  );
                                });
                          },
                          child: ListTile(
                            title: Text(
                              todo.title,
                              style: TextStyle(
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
                                      return ContentDialog(
                                        title: const Text('Delete Todo'),
                                        content: const Text(
                                            'Are you sure you want to delete this todo?'),
                                        actions: [
                                          OutlinedButton(
                                            child: const Text('Cancel'),
                                            onPressed: Navigator.of(context).pop,
                                          ),
                                          OutlinedButton(
                                            child: const Text('Delete'),
                                            onPressed: () async {
                                              await Provider.of<Database>(context, listen: false)
                                                  .deleteTodo(todo);
                                              setState(() {});
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        );
                      });
                }
              } else {}
              return const Center(
                child: ProgressRing(),
              );
            }),
        const Center(
          child: Text('Settings'),
        )
      ],
    );
  }
}
