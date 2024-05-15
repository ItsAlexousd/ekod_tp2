import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppView(),
    );
  }
}

class TodoItem {
  TodoItem({
    required this.title,
    this.completed = false,
  });

  final String title;
  bool completed;
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final items = <TodoItem>[];
  final controller = TextEditingController();

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un item'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Titre'),
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
                controller.clear();
              },
            ),
            ElevatedButton(
              child: const Text('Ajouter'),
              onPressed: () {
                _addItem(controller.text.trim());
                Navigator.of(context).pop();
                controller.clear();
              },
            ),
          ],
        );
      },
    );
  }

  void _addItem(String title) {
    if (title.isNotEmpty) {
      if (!items.any((item) => item.title == title)) {
        setState(() {
          items.add(TodoItem(title: title));
          controller.clear();
        });
      } else {
        _showSnackBar('Cet item existe déjà.');
      }
    } else {
      _showSnackBar('Veuillez entrer un item.');
    }
  }

  void _toggleItem(int index) {
    setState(() {
      items[index].completed = !items[index].completed;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Exercice 6'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            final isCompleted = items[index].completed;
            return Card(
              child: CheckboxListTile(
                title: Text(
                  items[index].title,
                  style: TextStyle(
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                value: isCompleted,
                onChanged: (_) {
                  _toggleItem(index);
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddItemDialog,
          child: const Icon(Icons.add),
        ));
  }
}
