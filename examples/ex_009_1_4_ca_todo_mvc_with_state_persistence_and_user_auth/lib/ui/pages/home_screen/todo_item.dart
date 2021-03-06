import 'package:ex_009_1_3_ca_todo_mvc_with_state_persistence_user_auth/ui/injected/injected_todo.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../domain/entities/todo.dart';
import '../../../ui/pages/detail_screen/detail_screen.dart';
import '../../common/localization/localization.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = todoItem(context);
    return todo.rebuilder(
      () {
        print('rebuilder of  key');
        return Dismissible(
          key: Key('__${todo.state.id}__'),
          onDismissed: (direction) {
            removeTodo(todo.state);
          },
          child: ListTile(
            onTap: () async {
              final shouldDelete = await RM.navigate.to(
                todoItem.reInherited(
                  context: context,
                  builder: (context) => DetailScreen(),
                ),
              );
              if (shouldDelete == true) {
                RM.scaffold.context = context;
                removeTodo(todo.state);
              }
            },
            leading: Checkbox(
              key: Key('__Checkbox${todo.state.id}__'),
              value: todo.state.complete,
              onChanged: (value) {
                final newTodo = todo.state.copyWith(
                  complete: value,
                );
                todo.state = newTodo;
              },
            ),
            title: Text(
              todo.state.task,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              todo.state.note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        );
      },
    );
  }

  void removeTodo(Todo todo) {
    todos.setState((s) => s.first.deleteTodo(todo));

    RM.scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          i18n.of(RM.context).todoDeleted(todo.task),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: i18n.of(RM.context).undo,
          onPressed: () {
            todos.setState((s) => s.first.addTodo(todo));
          },
        ),
      ),
    );
  }
}
