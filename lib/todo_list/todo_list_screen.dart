
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_bloc/todo_list/todo_list_util.dart';
import 'package:study_bloc/todo_list/todo_model.dart';
import 'package:study_bloc/todo_list/widgets/todo_list_item.dart';

import 'bloc/todo_list_bloc.dart';
import 'bloc/todo_list_state.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _todoListCubit = TodoListCubit();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TodoModel? _todoModelSelected;

  @override
  void initState() {
    _todoListCubit.getDataFromLocal();
    super.initState();
  }

  void _onRemove() {
    if (_todoModelSelected != null) {
      _todoListCubit.removeItemTodo(_todoModelSelected!.id ?? '');
    }
  }

  void _onCreate() {
    if (!validateAndSave(_formKey)) {
      return;
    }
    _todoListCubit.createItemTodo(_nameController.text);
    _nameController.text = '';
  }

  void _onItemTap(TodoModel model) {
    if (_todoModelSelected?.id == model.id) {
      _todoModelSelected = null;
    } else {
      _todoModelSelected = model;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TodoList'),
        actions: [
          BlocBuilder(
            bloc: _todoListCubit,
            builder: (_, state) {
              print(state);
              if (state is TodoListCreatingState) {
                return const SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: _onCreate,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: _onRemove,
          ),
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _nameController,
                validator: validName,
              ),
            ),
          ),
          Expanded(
              child: BlocBuilder<TodoListCubit, TodoListState>(
            bloc: _todoListCubit,
            builder: (_, state) {
              if (state is TodoListLoadingState){
                return Center(child: CircularProgressIndicator());
              }
              if (_todoListCubit.listTodo.isNotEmpty) {
                return ListView.separated(
                  padding:const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (_, index) {
                    final itemModel = _todoListCubit.listTodo[index];
                    return TodoListItem(
                      todoModel: _todoListCubit.listTodo[index],
                      onTap: _onItemTap,
                      selected: _todoModelSelected?.id == itemModel.id,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: _todoListCubit.listTodo.length,
                );
              }
              return const Center(
                child: Text('Chua co du lieu'),
              );
            },
          ))
        ],
      ),
    );
  }
}
