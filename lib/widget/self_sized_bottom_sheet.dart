import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class SelfSizedBottomSheet extends StatefulWidget {
  const SelfSizedBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  State<SelfSizedBottomSheet> createState() => _SelfSizedBottomSheetState();
}

class _SelfSizedBottomSheetState extends State<SelfSizedBottomSheet> {
  final _bottomSheetContentKey = GlobalKey();

  var _wasFirstFrame = false;
  var _bottomSheetContentHeight = 4 * (kMinInteractiveDimension + 8) + 16 * 2;

  @override
  void initState() {
    super.initState();

    RendererBinding.instance.deferFirstFrame();
  }

  void _handleChangesSafe() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.postFrameCallbacks) {
      _handleChanges();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _handleChanges();
      });
    }
  }

  void _handleChanges() {
    if (!_wasFirstFrame) {
      RendererBinding.instance.allowFirstFrame();
      _wasFirstFrame = true;
    }

    final height = _bottomSheetContentKey.currentContext?.size?.height;

    if (height != null && height != _bottomSheetContentHeight) {
      setState(() {
        _bottomSheetContentHeight = height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _handleChangesSafe();

    const borderRadius = BorderRadius.vertical(top: Radius.circular(16));
    final theme = Theme.of(context);
    final padding = MediaQuery.paddingOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxChildSize = _bottomSheetContentHeight / constraints.maxHeight;
        final minChildSize =
            (padding.bottom + kBottomNavigationBarHeight) /
            constraints.maxHeight;

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(
            context,
          ).copyWith(physics: const ClampingScrollPhysics()),
          child: DraggableScrollableSheet(
            maxChildSize: maxChildSize,
            initialChildSize: maxChildSize,
            minChildSize: minChildSize,
            expand: false,
            snap: true,
            snapSizes: [minChildSize, maxChildSize],
            shouldCloseOnMinExtent: false,
            builder: (context, scrollController) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  boxShadow: kElevationToShadow[24],
                  borderRadius: borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: NotificationListener<SizeChangedLayoutNotification>(
                    onNotification: (n) {
                      _handleChangesSafe();

                      return false;
                    },
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: KeyedSubtree(
                        key: _bottomSheetContentKey,
                        child: SizeChangedLayoutNotifier(child: widget.child),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
