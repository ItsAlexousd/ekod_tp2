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

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final items = <String>[];
  final controller = TextEditingController();

  void _addItem() {
    final item = controller.text.trim();
    if (item.isNotEmpty) {
      if (!items.contains(item)) {
        setState(() {
          items.add(item);
          controller.clear();
        });
      } else {
        _showSnackBar('Cet item existe déjà.');
      }
    } else {
      _showSnackBar('Veuillez entrer un item.');
    }
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
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
        title: const Text('Exercice 4'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Ajouter un élément',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Ajouter'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(items[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
