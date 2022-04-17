import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_todo_list/pages/todo_list_page/todo_list_page.dart';

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
      children: const [
        TodoListPage(),
        Center(
          child: Text('Settings'),
        )
      ],
    );
  }
}
