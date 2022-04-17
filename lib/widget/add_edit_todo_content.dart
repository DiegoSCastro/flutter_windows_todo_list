import 'package:drift/drift.dart' as drift;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_todo_list/database/database.dart';

class AddEditTodoContent extends StatefulWidget {
  final Function? onCreated;
  final Function? onUpdated;
  final TodoData? todo;
  const AddEditTodoContent({
    Key? key,
    this.onCreated,
    this.onUpdated,
    this.todo,
  }) : super(key: key);

  @override
  State<AddEditTodoContent> createState() => _AddEditTodoContentState();
}

class _AddEditTodoContentState extends State<AddEditTodoContent> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isFinished = false;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    if (widget.todo != null) {
      titleController.text = widget.todo?.title ?? '';
      descriptionController.text = widget.todo?.description ?? '';
      isFinished = widget.todo?.isFinished ?? false;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool get hasTodo => widget.todo != null;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(hasTodo ? 'Update Todo' : 'Create Todo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            placeholder: 'Title',
            controller: titleController,
          ),
          const SizedBox(height: 24),
          TextBox(
            minLines: 3,
            maxLines: 5,
            placeholder: 'Description',
            controller: descriptionController,
          ),
          const SizedBox(height: 24),
          Checkbox(
            content: const Text('Finished?'),
            checked: isFinished,
            onChanged: (v) {
              setState(() {
                isFinished = !isFinished;
              });
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await createUpdateTodo(context);
            Navigator.of(context).pop();
          },
          child: Text(hasTodo ? 'Update' : 'Create'),
        ),
      ],
    );
  }

  Future<void> createUpdateTodo(BuildContext context) async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (hasTodo) {
      TodoCompanion updatedTodo = TodoCompanion(
        id: drift.Value(hasTodo ? widget.todo!.id : 0),
        title: drift.Value(title),
        description: drift.Value(description),
        isFinished: drift.Value(isFinished),
      );
      await Provider.of<Database>(context, listen: false).updateTodo(updatedTodo);
      widget.onUpdated!();
    } else {
      TodoCompanion newTodo = TodoCompanion(
        title: drift.Value(title),
        description: drift.Value(description),
        isFinished: drift.Value(isFinished),
      );
      await Provider.of<Database>(context, listen: false).insertTodo(newTodo);

      widget.onCreated!();
    }
  }
}
