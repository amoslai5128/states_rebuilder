import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todos_app_core/todos_app_core.dart';

import '../../../injected.dart';
import '../../common/enums.dart';
import '../../exceptions/error_handler.dart';

class ExtraActionsButton extends StatelessWidget {
  ExtraActionsButton({Key key}) : super(key: key);
  final extraAction = RM.inject(() => ExtraAction.clearCompleted);
  @override
  Widget build(BuildContext context) {
    return extraAction.listen(
      child: On.data(
        () {
          return PopupMenuButton<ExtraAction>(
            key: ArchSampleKeys.extraActionsButton,
            onSelected: (action) {
              extraAction.state = action;
              todosService.setState(
                (s) async {
                  if (action == ExtraAction.toggleAllComplete) {
                    return s.toggleAll();
                  } else if (action == ExtraAction.clearCompleted) {
                    return s.clearCompleted();
                  }
                },
                onError: ErrorHandler.showErrorSnackBar,
              );
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ExtraAction>>[
                PopupMenuItem<ExtraAction>(
                  key: ArchSampleKeys.toggleAll,
                  value: ExtraAction.toggleAllComplete,
                  child: Text(todosService.state.allComplete
                      ? ArchSampleLocalizations.of(context).markAllIncomplete
                      : ArchSampleLocalizations.of(context).markAllComplete),
                ),
                PopupMenuItem<ExtraAction>(
                  key: ArchSampleKeys.clearCompleted,
                  value: ExtraAction.clearCompleted,
                  child:
                      Text(ArchSampleLocalizations.of(context).clearCompleted),
                ),
              ];
            },
          );
        },
      ),
    );
  }
}
