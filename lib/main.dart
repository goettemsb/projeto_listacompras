import 'package:flutter/material.dart';

void
main() => runApp(
  const MyApp(),
);

class MyApp
    extends
        StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(
         key: key,
       );

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(
          0xFFF3F4F6,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
      ),
      home: const MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome
    extends
        StatefulWidget {
  const MyHome({
    Key? key,
  }) : super(
         key: key,
       );

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState
    extends
        State<
          MyHome
        > {
  final List<
    String
  >
  _tasks = [];

  void _showAddTaskDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (
            context,
          ) => AlertDialog(
            title: const Text(
              'Adicionar Produto',
            ),
            content: TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Digite o produto',
                border: OutlineInputBorder(),
              ),
              onSubmitted:
                  (
                    _,
                  ) => _addTask(
                    _controller,
                  ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).pop(),
                child: const Text(
                  'Cancelar',
                ),
              ),
              ElevatedButton(
                onPressed: () => _addTask(
                  _controller,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  'Adicionar',
                ),
              ),
            ],
          ),
    );
  }

  void _addTask(
    TextEditingController controller,
  ) {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      setState(
        () {
          _tasks.add(
            text,
          );
        },
      );
      Navigator.of(
        context,
      ).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            'Produto "$text" adicionado!',
          ),
          backgroundColor: Colors.teal,
          duration: const Duration(
            seconds: 1,
          ),
        ),
      );
    }
  }

  void _removeTask(
    int index,
  ) {
    final removedTask = _tasks[index];
    setState(
      () {
        _tasks.removeAt(
          index,
        );
      },
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          'Produto "$removedTask" removido!',
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(
          seconds: 1,
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Lista de Compras',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Text(
                'Sua lista está vazia.\nAdicione um produto!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(
                16,
              ),
              itemCount: _tasks.length,
              separatorBuilder:
                  (
                    _,
                    __,
                  ) => const SizedBox(
                    height: 10,
                  ),
              itemBuilder:
                  (
                    context,
                    index,
                  ) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          _tasks[index],
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => _removeTask(
                            index,
                          ),
                          tooltip: 'Remover',
                        ),
                      ),
                    );
                  },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(
          Icons.add,
          size: 32,
        ),
        tooltip: 'Adicionar novo produto',
      ),
    );
  }
}
