import 'package:fluent_ui/fluent_ui.dart';
import 'package:windows_todo_list/pages/components/content_body.dart';
import 'package:windows_todo_list/widget/add_edit_todo_content.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationView(
        appBar: _buildNavigationAppBar(),
        pane: _buildNavigationPane(),
        content: ContentBody(selectedIndex: selectedIndex),
      ),
    );
  }

  NavigationAppBar _buildNavigationAppBar() {
    return NavigationAppBar(
      leading: Container(),
      title: const Text(
        'Todo List',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: Row(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddEditTodoContent(
                        onCreated: () {
                          setState(() {});
                        },
                        onUpdated: () {
                          setState(() {});
                        },
                      );
                    });
              },
              child: const Text('Create Todo'),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  NavigationPane _buildNavigationPane() {
    return NavigationPane(
      header: const FlutterLogo(
        style: FlutterLogoStyle.horizontal,
        size: 100,
      ),
      selected: selectedIndex,
      onChanged: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.to_do_logo_outline),
          title: const Text('Todo List'),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.settings),
          title: const Text('Settings'),
        ),
      ],
    );
  }
}
