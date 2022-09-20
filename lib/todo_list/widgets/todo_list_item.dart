
import 'package:flutter/material.dart';

import '../todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoModel todoModel;
  final Function(TodoModel todoModel) onTap;
  final bool selected;

  const TodoListItem({
    Key? key,
    required this.todoModel,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(todoModel);
      },
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: selected ? Colors.green : Colors.grey[350],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
              ),
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todoModel.name ?? '',
              ),
              Text(
                todoModel.dateTime ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
