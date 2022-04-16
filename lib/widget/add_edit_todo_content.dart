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

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.todo != null ? 'Update Todo' : 'Create Todo'),
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
        if (widget.todo != null) ...[
          TextButton(
            onPressed: () async {
              String title = titleController.text;
              String description = descriptionController.text;
              await Provider.of<Database>(context, listen: false).updateTodo(TodoCompanion(
                id: drift.Value(widget.todo!.id),
                title: drift.Value(title),
                description: drift.Value(description),
                isFinished: drift.Value(isFinished),
              ));
              widget.onUpdated!();

              Navigator.of(context).pop();
            },
            child: const Text('Update'),
          ),
        ] else ...[
          TextButton(
            onPressed: () async {
              String title = titleController.text;
              String description = descriptionController.text;

              await Provider.of<Database>(context, listen: false).insertTodo(TodoCompanion(
                title: drift.Value(title),
                description: drift.Value(description),
                isFinished: drift.Value(isFinished),
              ));
              widget.onCreated!();

              Navigator.of(context).pop();
            },
            child: const Text('Create'),
          ),
        ],
      ],
    );
  }
}
