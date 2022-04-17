import 'package:fluent_ui/fluent_ui.dart';

class RemoveDialog extends StatelessWidget {
  final VoidCallback onRemovePressed;
  const RemoveDialog({Key? key, required this.onRemovePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Delete Todo'),
      content: const Text('Are you sure you want to delete this todo?'),
      actions: [
        OutlinedButton(
          child: const Text('Cancel'),
          onPressed: Navigator.of(context).pop,
        ),
        OutlinedButton(
          child: const Text('Delete'),
          onPressed: onRemovePressed,
        ),
      ],
    );
  }
}
