import 'package:flutter/widgets.dart';

extension ScrollNotificationExtension on ScrollNotification {
  ///最小的滚动距离
  double get minScrollExtent => metrics.minScrollExtent;

  ///最大的滚动距离
  double get maxScrollExtent => metrics.maxScrollExtent;

  ///当前的滚动距离
  double get pixels => metrics.pixels;

  ///显示在屏幕的中主轴方向的大小
  double get viewportDimension => metrics.viewportDimension;

  ///列表中所有内容加起来的高度
  double get fullScrollExtent => extentBefore + extentInside + extentAfter;

  ///滚动方向
  Axis get axis => metrics.axis;

  ///是否超出了minScrollExtent-maxScrollExtent范围
  bool get outOfRange => metrics.outOfRange;

  ///是否位于边界，主轴的start或者end
  bool get atEdge => metrics.atEdge;

  ///滚动屏幕的大小
  double get extentBefore => metrics.extentBefore;

  ///显示在屏幕中的大小
  double get extentInside => metrics.extentInside;

  ///未显示在屏幕中的大小
  double get extentAfter => metrics.extentAfter;

  ///是否可以滚动，内容是否大于viewportDimension的
  bool get canScroll => (fullScrollExtent > viewportDimension);

  String get desc {
    return '''
    minScrollExtent:   $minScrollExtent
    maxScrollExtent:   $maxScrollExtent
    pixels:            $pixels
    viewportDimension: $viewportDimension
    fullScrollExtent:  $fullScrollExtent  
    axis:              $axis
    outOfRange:        $outOfRange
    atEdge:            $atEdge
    extentBefore:      $extentBefore
    extentInside:      $extentInside
    extentAfter:       $extentAfter
    canScroll:         $canScroll
    ''';
  }
}
