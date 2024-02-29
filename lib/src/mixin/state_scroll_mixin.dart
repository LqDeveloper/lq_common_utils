import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../extensions/context_scroll_extension.dart';

///ScrollView的滚动状态
enum ScrollState {
  ///开始滚动
  start,

  ///正在滚动中
  update,

  ///结束滚动
  end;

  ///滚动状态的ScrollNotification类型
  Type get notificationType {
    switch (this) {
      case ScrollState.start:
        return ScrollStartNotification;
      case ScrollState.update:
        return ScrollUpdateNotification;
      case ScrollState.end:
        return ScrollEndNotification;
    }
  }
}

mixin StateScrollMixin<T extends StatefulWidget> on State<T> {
  ///滚动视图的Viewport
  RenderViewportBase? _viewport;

  RenderViewportBase? get viewport => _viewport;

  ///嵌入到的RenderSliver
  RenderSliver? _renderSliver;

  RenderSliver? get renderSliver => _renderSliver;

  ///是否嵌套在ScrollView中
  bool _isInScrollView = false;

  bool get isInScrollView => _isInScrollView;

  ///嵌入的滚动视图的类型
  ScrollViewType _scrollViewType = ScrollViewType.unknown;

  ScrollViewType get scrollViewType => _scrollViewType;

  ///监听滚动事件
  ScrollNotificationObserverState? _scrollState;

  ///默认是在滚动结束后处理
  List<ScrollState> get observerScrollState => [ScrollState.update];

  ///监听滚动类型
  List<Type> _observerScrollType = [];

  ///当前组件是否展示
  bool _visible = false;

  bool get visible => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setupScrollInfo();
    });
  }

  @override
  void dispose() {
    _scrollState?.removeListener(_scrollNotification);
    _viewport = null;
    _renderSliver = null;
    super.dispose();
  }

  void _setupScrollInfo() {
    //从当前节点向上查找ViewPort
    _viewport = context.findViewport();

    //如果不存在Viewport，就说明这是一个正常的页面，没有嵌套在ScrollView中
    _isInScrollView = context.isInScrollView(_viewport);

    //不存在ViewPort直接返回
    if (!_isInScrollView) {
      return;
    }

    //获取所处于的Sliver的类型
    _renderSliver = context.findAncestorRenderObj<RenderSliver>();

    //更加Sliver类型判断当前处于哪种滚动组件中
    _scrollViewType = ScrollViewType.fromRenderObj(_renderSliver);

    _observerScrollType =
        observerScrollState.map((e) => e.notificationType).toList();

    //当前组件的父组件中必须要有Scaffold 或者ScrollNotificationObserver包裹
    _scrollState = ScrollNotificationObserver.maybeOf(context);
    _scrollState?.addListener(_scrollNotification);
  }

  void _scrollNotification(ScrollNotification notification) {
    //ScrollNotification冒泡通过的Viewport的个数必须为0,才会去响应
    if (notification.depth > 0) {
      return;
    }
    if (notification is ScrollStartNotification &&
        _observerScrollType.contains(ScrollStartNotification)) {
      startScroll(notification);
    } else if (notification is ScrollUpdateNotification &&
        _observerScrollType.contains(ScrollUpdateNotification)) {
      updateScroll(notification);
    } else if (notification is ScrollEndNotification &&
        _observerScrollType.contains(ScrollEndNotification)) {
      endScroll(notification);
    }
  }

  ///开始滚动
  @protected
  @mustCallSuper
  void startScroll(ScrollStartNotification notification) {}

  ///正在滚动
  @protected
  @mustCallSuper
  void updateScroll(ScrollUpdateNotification notification) {
    _handleCustomScrollView(notification: notification);
  }

  ///滚动结束
  @protected
  @mustCallSuper
  void endScroll(ScrollEndNotification notification) {}

  ///当前组件在滚动视图中显示
  @protected
  void sliverAppear() {}

  ///当前组件在滚动视图中隐藏
  @protected
  void sliverDisAppear() {}

  void _handleCustomScrollView({ScrollNotification? notification}) {
    if (_scrollViewType != ScrollViewType.customView) {
      return;
    }
    final visible = (_renderSliver?.geometry?.paintExtent ?? 0) > 10;
    if (visible == _visible) {
      return;
    }
    _visible = visible;
    if (_visible) {
      sliverAppear();
    } else {
      sliverDisAppear();
    }
  }
}
