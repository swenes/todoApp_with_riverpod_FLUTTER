import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_with_riverpod/models/to_do_model.dart';
import 'package:to_do_with_riverpod/providers/all_providers.dart';

class ListItemWidget extends ConsumerStatefulWidget {
  const ListItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends ConsumerState<ListItemWidget> {
  late FocusNode focusNode;
  late TextEditingController textController;
  bool hasFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodoProvider);

    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(
            () {
              hasFocus = false;
            },
          );
          ref.read(todoListProvider.notifier).edit(
              id: currentTodoItem.id, newDescription: textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            focusNode.requestFocus();
            textController.text = currentTodoItem.description;
            hasFocus = true;
          });
        },
        leading: Checkbox(
          value: currentTodoItem.completed,
          onChanged: ((value) {
            ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
          }),
        ),
        title: hasFocus
            ? TextField(
                controller: textController,
                focusNode: focusNode,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
