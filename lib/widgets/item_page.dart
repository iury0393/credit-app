import 'package:credit_app/controllers/offset_controller.dart';
import 'package:credit_app/controllers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps {
  rotate,
  scale,
  opacity,
  padding_right,
  rotate_back,
  scale_back,
  opacity_back,
  padding_right_back
}

class ItemPage extends StatefulWidget {
  final Color? color;
  final int? index;
  final String? numberCard;
  final String? name;
  final String imageURL;

  ItemPage({Key? key, this.color, this.index, this.numberCard, this.name, required this.imageURL})
      : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with SingleTickerProviderStateMixin {
  final MultiTween<AniProps> multiTrackTween = MultiTween<AniProps>()
    ..add(AniProps.rotate, Tween(begin: 0.0, end: -0.5), Duration(milliseconds: 300))
    ..add(AniProps.scale, Tween(begin: 1.0, end: 0.5), Duration(milliseconds: 300))
    ..add(AniProps.opacity, Tween(begin: 1.0, end: 0.0), Duration(milliseconds: 300))
    ..add(AniProps.padding_right, Tween(begin: 0.0, end: 20.0), Duration(milliseconds: 300))
    ..add(AniProps.rotate_back, Tween(begin: -0.5, end: 0.0), Duration(milliseconds: 300))
    ..add(AniProps.scale_back, Tween(begin: 0.5, end: 1.0), Duration(milliseconds: 300))
    ..add(AniProps.opacity_back, Tween(begin: 0.0, end: 1.0), Duration(milliseconds: 300))
    ..add(AniProps.padding_right_back, Tween(begin: 20.0, end: 0.0), Duration(milliseconds: 300));

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OffsetController>(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: RotatedBox(
            quarterTurns: 1,
            child: Image.network(
              widget.imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 10), blurRadius: 15)],
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue),
      ),
      builder: (BuildContext context, OffsetController value, Widget? child) {
        int currentIndex = Provider.of<PageControllerApp>(context, listen: false).index;
        print(currentIndex);
        print(widget.index);
        return Stack(
          children: <Widget>[
            PlayAnimation<MultiTweenValues<AniProps>>(
              duration: multiTrackTween.duration,
              tween: multiTrackTween,
              child: child,
              builder: (context, child, value) {
                return Positioned(
                  top: MediaQuery.of(context).size.height / 4,
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width - 90,
                  child: Transform.rotate(
                    angle: currentIndex > widget.index! || currentIndex < widget.index!
                        ? value.get(AniProps.rotate)
                        : value.get(AniProps.rotate_back),
                    child: Transform.scale(
                      child: Opacity(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: currentIndex > widget.index! || currentIndex < widget.index!
                                  ? value.get(AniProps.padding_right)
                                  : value.get(AniProps.padding_right_back)),
                          child: child,
                        ),
                        opacity: currentIndex > widget.index! || currentIndex < widget.index!
                            ? value.get(AniProps.opacity)
                            : value.get(AniProps.opacity_back),
                      ),
                      scale: currentIndex > widget.index! || currentIndex < widget.index!
                          ? value.get(AniProps.scale)
                          : value.get(AniProps.scale_back),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
