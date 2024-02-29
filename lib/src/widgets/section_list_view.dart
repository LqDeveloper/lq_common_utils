import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IndexPath {
  final int section;
  final int row;

  const IndexPath({required this.section, required this.row});
}

typedef HeaderBuilder = Widget Function(BuildContext context, int section);
typedef FooterBuilder = Widget Function(BuildContext context, int section);
typedef CellBuilder = Widget Function(
    BuildContext context, IndexPath indexPath);

typedef HeaderExtentBuilder = double Function(
    BuildContext context, int section);
typedef FooterExtentBuilder = double Function(
    BuildContext context, int section);
typedef CellExtentBuilder = double Function(
    BuildContext context, IndexPath indexPath);
typedef CellCountInSectionBuilder = int Function(
    BuildContext context, int section);
typedef EmptyPageBuilder = Widget Function(BuildContext context);
typedef ClickCellCallback = void Function(
    BuildContext buildContext, IndexPath indexPath);
typedef ClickHeaderFooterCallback = void Function(
    BuildContext buildContext, int section);

class SectionListView extends StatefulWidget {
  final bool keepAlive;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final bool shrinkWrap;
  final Key? center;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  final int section;
  final HeaderBuilder? headerBuilder;
  final FooterBuilder? footerBuilder;
  final CellBuilder cellBuilder;
  final CellCountInSectionBuilder countInSectionBuilder;
  final HeaderExtentBuilder? headerExtentBuilder;
  final FooterExtentBuilder? footerExtentBuilder;
  final CellExtentBuilder? cellExtentBuilder;
  final EmptyPageBuilder? emptyPageBuilder;
  final ClickCellCallback? onCellClick;
  final ClickHeaderFooterCallback? onHeaderClick;
  final ClickHeaderFooterCallback? onFooterClick;

  const SectionListView(
      {super.key,
      this.keepAlive = false,
      this.section = 1,
      this.headerBuilder,
      this.footerBuilder,
      required this.cellBuilder,
      required this.countInSectionBuilder,
      this.headerExtentBuilder,
      this.footerExtentBuilder,
      this.cellExtentBuilder,
      this.emptyPageBuilder,
      this.onCellClick,
      this.onHeaderClick,
      this.onFooterClick,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.controller,
      this.physics,
      this.primary,
      this.scrollBehavior,
      this.shrinkWrap = false,
      this.center,
      this.anchor = 0.0,
      this.cacheExtent,
      this.semanticChildCount,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.restorationId,
      this.clipBehavior = Clip.hardEdge});

  @override
  State<SectionListView> createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.section == 0) {
      if (widget.emptyPageBuilder != null) {
        return widget.emptyPageBuilder!(context);
      } else {
        return const SizedBox();
      }
    }
    return CustomScrollView(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      scrollBehavior: widget.scrollBehavior,
      shrinkWrap: widget.shrinkWrap,
      center: widget.center,
      anchor: widget.anchor,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      slivers: _buildSlivers(context),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    final List<Widget> list = [];
    for (int i = 0; i < widget.section; i++) {
      //header
      Widget? header = _buildHeader(context, i);
      if (header != null) {
        if (widget.onHeaderClick != null) {
          header = GestureDetector(
            onTap: () {
              widget.onHeaderClick!(context, i);
            },
            child: header,
          );
        }
        list.add(SliverToBoxAdapter(child: header));
      }
      //cells
      list.add(_buildList(context, i));
      //footer
      Widget? footer = _buildFooter(context, i);
      if (footer != null) {
        if (widget.onFooterClick != null) {
          footer = GestureDetector(
            onTap: () {
              widget.onFooterClick!(context, i);
            },
            child: footer,
          );
        }
        list.add(SliverToBoxAdapter(child: footer));
      }
    }
    return list;
  }

  Widget? _buildHeader(BuildContext context, int section) {
    if (widget.headerBuilder != null) {
      if (widget.headerExtentBuilder != null) {
        if (widget.scrollDirection == Axis.horizontal) {
          return SizedBox(
              width: widget.headerExtentBuilder!(context, section),
              child: widget.headerBuilder!(context, section));
        } else {
          return SizedBox(
              height: widget.headerExtentBuilder!(context, section),
              child: widget.headerBuilder!(context, section));
        }
      } else {
        return widget.headerBuilder!(context, section);
      }
    }
    return null;
  }

  Widget _buildList(BuildContext context, int section) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (cxt, row) {
          final indexPath = IndexPath(section: section, row: row);
          final cell = _getCellItem(cxt, indexPath);
          if (widget.onCellClick != null) {
            return GestureDetector(
              child: cell,
              onTap: () {
                widget.onCellClick!(cxt, indexPath);
              },
            );
          } else {
            return cell;
          }
        },
        childCount: widget.countInSectionBuilder(context, section),
      ),
    );
  }

  Widget _getCellItem(BuildContext context, IndexPath indexPath) {
    if (widget.cellExtentBuilder != null) {
      if (widget.scrollDirection == Axis.horizontal) {
        return SizedBox(
          width: widget.cellExtentBuilder!(context, indexPath),
          child: widget.cellBuilder(context, indexPath),
        );
      } else {
        return SizedBox(
          height: widget.cellExtentBuilder!(context, indexPath),
          child: widget.cellBuilder(context, indexPath),
        );
      }
    } else {
      return widget.cellBuilder(context, indexPath);
    }
  }

  Widget? _buildFooter(BuildContext context, int section) {
    if (widget.footerBuilder != null) {
      if (widget.footerExtentBuilder != null) {
        if (widget.scrollDirection == Axis.horizontal) {
          return SizedBox(
              width: widget.footerExtentBuilder!(context, section),
              child: widget.footerBuilder!(context, section));
        } else {
          return SizedBox(
              height: widget.footerExtentBuilder!(context, section),
              child: widget.footerBuilder!(context, section));
        }
      } else {
        return widget.footerBuilder!(context, section);
      }
    }
    return null;
  }
}
