import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/screens/view_task.dart';

enum ReorderableListSimpleSide { Right, Left }

class ReorderableListSimple extends StatefulWidget {
  ReorderableListSimple({
    @required this.children,
    @required this.onReorder,
    this.allowReordering = true,
    this.childrenAlreadyHaveListener = false,
    this.handleSide = ReorderableListSimpleSide.Left,
    this.handleIcon,
    this.padding,
  });

  final bool allowReordering;
  final bool childrenAlreadyHaveListener;
  final ReorderableListSimpleSide handleSide;
  final Icon handleIcon;
  final List<Widget> children;
  final ReorderCallback onReorder;
  final EdgeInsets padding;

  @override
  State<ReorderableListSimple> createState() =>
      new _ReorderableListSimpleState();
}

class _ReorderableListSimpleState extends State<ReorderableListSimple> {
  int _newIndex;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List<Widget>.from(widget.children);
  }

  @override
  didUpdateWidget(ReorderableListSimple oldWidget) {
    super.didUpdateWidget(oldWidget);
    _children = List<Widget>.from(widget.children);
  }

  int _oldIndexOfKey(Key key) {
    return widget.children
        .indexWhere((Widget w) => Key(w.hashCode.toString()) == key);
  }

  int _indexOfKey(Key key) {
    return _children
        .indexWhere((Widget w) => Key(w.hashCode.toString()) == key);
  }

  Widget _buildReorderableItem(BuildContext context, int index) {
    return ReorderableItemSimple(
      key: Key(_children[index].hashCode.toString()),
      innerItem: _children[index],
      allowReordering: widget.allowReordering,
      childrenAlreadyHaveListener: widget.childrenAlreadyHaveListener,
      handleSide: widget.handleSide,
      handleIcon: widget.handleIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      child: ListView.builder(
        padding: widget.padding,
        itemCount: _children.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildReorderableItem(context, index);
        },
      ),

      // child: Container(
      //   padding: widget.padding,
      //   child: CustomScrollView(
      //     slivers: <Widget>[
      //       SliverList(
      //         delegate: SliverChildBuilderDelegate(
      //           (BuildContext context, int index) {
      //             return _buildReorderableItem(context, index);
      //           },
      //           childCount: widget.children.length,
      //         ),
      //       )
      //     ],
      //   ),
      // ),

      onReorder: (Key draggedItem, Key newPosition) {
        int draggingIndex = _indexOfKey(draggedItem);
        int newPositionIndex = _indexOfKey(newPosition);

        final item = _children[draggingIndex];
        setState(() {
          _newIndex = newPositionIndex;

          _children.removeAt(draggingIndex);
          _children.insert(newPositionIndex, item);
        });
        
        bloc.swap(draggedItem, newPosition);
        

        return true;
      },
      onReorderDone: (Key draggedItem) {
        int oldIndex = _oldIndexOfKey(draggedItem);
        if (_newIndex != null) widget.onReorder(oldIndex, _newIndex);
        _newIndex = null;
      },
    );
  }
}

class ReorderableItemSimple extends StatelessWidget {
  ReorderableItemSimple({
    @required Key key,
    @required this.innerItem,
    this.allowReordering = true,
    this.childrenAlreadyHaveListener = false,
    this.handleSide = ReorderableListSimpleSide.Right,
    this.handleIcon,
  }) : super(key: key);

  final bool allowReordering;
  final bool childrenAlreadyHaveListener;
  final ReorderableListSimpleSide handleSide;
  final Icon handleIcon;
  final Widget innerItem;

  Color _iconColor(ThemeData theme, ListTileTheme tileTheme) {
    if (tileTheme?.selectedColor != null) return tileTheme.selectedColor;

    if (tileTheme?.iconColor != null) return tileTheme.iconColor;

    switch (theme.brightness) {
      case Brightness.light:
        return theme.primaryColor;
      case Brightness.dark:
        return theme.accentColor;
    }
    assert(theme.brightness != null);
    return null;
  }

  Widget _buildInnerItem(BuildContext context) {
    assert(innerItem != null);

    if ((!allowReordering) || childrenAlreadyHaveListener) return innerItem;

    Icon icon = handleIcon;
    if (icon == null) icon = Icon(Icons.drag_handle);

    var item = Expanded(child: innerItem);
    List<Widget> children = <Widget>[];

    if (handleSide == ReorderableListSimpleSide.Right) children.add(item);
    children.add(ReorderableListener(
      child: Container(
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 8.0), child: icon)),
    ));
    if (handleSide == ReorderableListSimpleSide.Left) children.add(item);

    final Row row = Row(
      mainAxisAlignment: handleSide == ReorderableListSimpleSide.Right
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );

    final ThemeData theme = Theme.of(context);
    final ListTileTheme tileTheme = ListTileTheme.of(context);

    return IconTheme.merge(
      data: IconThemeData(color: _iconColor(theme, tileTheme)),
      child: row,
    );
  }

  BoxDecoration _decoration(BuildContext context, ReorderableItemState state) {
    final ThemeData theme = Theme.of(context);
    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      return BoxDecoration(color: Colors.green[100]);
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      return BoxDecoration(
          
          border: Border(
              top: !placeholder
                  ? Divider.createBorderSide(context)
                  : BorderSide.none,
              bottom: placeholder
                  ? BorderSide.none
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : theme.cardColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ReorderableItem(
      key: key,
      childBuilder: (BuildContext context, ReorderableItemState state) {
        BoxDecoration decoration = _decoration(context, state);
        return  Container(
            //color: teheme.cardColor,
            decoration: decoration,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Opacity(
              opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
              child: _buildInnerItem(context),
            ),
        );
      },
    );
  }
}
