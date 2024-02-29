import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///滚动组件类型
///这里为什么不支持SingleChildScrollView,
///1. SingleChildScrollView不带缓存
///2. SingleChildScrollView+Column可以被ListView替代
enum ScrollViewType {
  ///PageView类型
  pageView,

  ///ListView和SliverList系列
  listView,

  ///GridView和SliverGrid系列
  gridView,

  ///CustomView和NestedScrollView
  customView,

  ///未知滚动类型
  unknown;

  ///找到对应滚动类型的RenderSliver对象
  bool checkSliverType(RenderObject? obj) {
    if (obj == null) {
      return false;
    }
    switch (this) {
      case ScrollViewType.pageView:
        return (obj is RenderSliverFillViewport);
      case ScrollViewType.listView:
        return (obj is RenderSliverList) ||
            (obj is RenderSliverFixedExtentList);
      case ScrollViewType.gridView:
        return (obj is RenderSliverGrid);
      case ScrollViewType.customView:
        return (obj is RenderSliver);
      case ScrollViewType.unknown:
        return false;
    }
  }

  static ScrollViewType fromRenderObj(RenderObject? obj) {
    if (obj == null) {
      return ScrollViewType.unknown;
    }
    if (obj is RenderSliverFillViewport) {
      return ScrollViewType.pageView;
    } else if ((obj is RenderSliverList) ||
        (obj is RenderSliverFixedExtentList)) {
      return ScrollViewType.listView;
    } else if (obj is RenderSliverGrid) {
      return ScrollViewType.gridView;
    } else if (obj is RenderSliver) {
      return ScrollViewType.customView;
    } else {
      return ScrollViewType.unknown;
    }
  }
}

extension ContextScrollExtension on BuildContext {
  ///从子RenderObject 向上找T类型的RenderObject,maxCycleCount向上查找的深度
  T? findAncestorRenderObj<T extends RenderObject>({int maxCycleCount = 10}) {
    final obj = findRenderObject();
    if (obj == null) {
      return null;
    }
    int currentCycleCount = 1;
    RenderObject? parent = obj.parent;
    while (parent != null && currentCycleCount <= maxCycleCount) {
      if (parent is T) {
        return parent;
      }
      parent = parent.parent;
      currentCycleCount++;
    }
    return null;
  }

  ///从子RenderObject 向上找ViewPort,maxCycleCount向上查找的深度
  ///SingleChildScroll的 viewport是_RenderSingleChildViewport类型
  RenderViewportBase? findViewport({int maxCycleCount = 10}) {
    return findAncestorRenderObj<RenderViewportBase>(
        maxCycleCount: maxCycleCount);
  }

  ///从子RenderObject 向上找ViewPort,一直遍历到根节点
  RenderAbstractViewport? findViewportToRoot() {
    return RenderAbstractViewport.maybeOf(findRenderObject());
  }

  ///从父RenderObject 向下查找RenderSliver对象对应的BuildContext
  List<BuildContext> getSliverContexts({required ScrollViewType type}) {
    final List<BuildContext> cxtList = [];
    void visitor(Element element) {
      if (type.checkSliverType(element.findRenderObject())) {
        cxtList.add(element);
        return;
      }
      element.visitChildren(visitor);
    }

    visitChildElements(visitor);
    return cxtList;
  }

  ///从当前RenderObject 向下查找RenderViewportBase
  RenderViewportBase? getChildViewport() {
    RenderViewportBase? viewport;
    void visitor(Element element) {
      if (element.findRenderObject() is RenderViewportBase) {
        viewport = (element.findRenderObject()! as RenderViewportBase);
        return;
      }
      element.visitChildren(visitor);
    }

    visitChildElements(visitor);
    return viewport;
  }

  ///是否位于ScrollView中
  bool isInScrollView(RenderAbstractViewport? viewport) {
    return viewport != null;
  }

  ///是否被SingleChildScrollView包裹,
  ///SingleChildScrollView是没有缓存机制的
  bool isInSingleScrollView(RenderAbstractViewport? viewport) {
    if (!isInScrollView(viewport)) {
      return false;
    }
    return !(viewport is RenderViewport ||
        viewport is RenderShrinkWrappingViewport);
  }

  ///此渲染对象的绘制信息是否脏。这仅在调试模式下设置。
  ///一般来说，渲染对象不需要根据它们是否脏来决定它们的运行时行为，因为它们应该只在布局和绘制之前立即被标记为脏。
  ///（在发布版本中，这会抛出。）它旨在供测试和断言使用。
  /// [debugNeedsPaint] 可能为 false 而 [debugNeedsLayout] 为 true 是可能的（而且确实很常见）。
  ///在这种情况下，渲染对象仍将在下一帧中重新绘制，
  ///因为 [markNeedsPaint] 方法在渲染对象布局之后、绘制阶段之前由框架隐式调用。
  bool debugNeedsPaint(RenderAbstractViewport? viewport) {
    if (!kDebugMode) {
      return false;
    }
    return viewport == null || viewport.debugNeedsPaint;
  }
}
