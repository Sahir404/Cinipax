import 'package:cinepax_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

class CongratsCard extends StatefulWidget {
  @override
  State<CongratsCard> createState() => _CongratsCardState();
}

class _CongratsCardState extends State<CongratsCard> {
  var allDone = false;

  @override
  void initState() {
    print('called initState');
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        allDone = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('congrats build called');

    return AnimatedPositioned(
      left: 40,
      right: 40,
      top: allDone ? 140 : -420,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      child: RepaintBoundary(
        child: Card(
          shape: const CircleBorder(),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 130, left: 50, right: 50, bottom: 110),
            child: _CardContents(),
          ),
        ),
      ),
    );
  }
}

class _CardContents extends StatefulWidget {
  @override
  State<_CardContents> createState() => _CardContentsState();
}

class _CardContentsState extends State<_CardContents>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTransition(
          scale: CurvedAnimation(
            curve: const Interval(
              0.2,
              0.6,
              curve: Curves.elasticOut,
            ),
            parent: _controller,
          ),
          child: SizedBox(
            height: 60,
            child: Image.asset('assets/images/congrats_image.png'),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Congratulations!',
          style: kHeadlineMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: TrackedOutText(
            'Your ticket booking has been done successfully, you can download the ticket.',
            CurvedAnimation(
              curve: const Interval(0.45, 0.7),
              parent: _controller,
            ),
            textAlign: TextAlign.center,
            style: kHeadlineSmall.copyWith(
              color: kPrimaryColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class TrackedOutText extends StatefulWidget {
  final String text;
  final List<TextSpan> _slices;
  final List<TextSpan> _slicesTransparent;
  final Animation<double> progress;
  final TextAlign textAlign;
  final TextStyle style;

  TrackedOutText(
    this.text,
    this.progress, {
    required this.textAlign,
    required this.style,
  })  : _slices = _generateSlices(text, style, false).toList(growable: false),
        _slicesTransparent =
            _generateSlices(text, style, true).toList(growable: false);

  static Iterable<TextSpan> _generateSlices(
      String text, TextStyle style, bool transparent) sync* {
    const step = 3;
    var i = 0;
    for (; i < text.length - step; i += step) {
      yield TextSpan(
        text: text.substring(i, i + step),
        style: transparent ? style.apply(color: Colors.transparent) : null,
      );
    }
    yield TextSpan(
      text: text.substring(i),
      style: transparent ? style.apply(color: Colors.transparent) : null,
    );
  }

  @override
  _TrackedOutTextState createState() => _TrackedOutTextState();
}

class _TrackedOutTextState extends State<TrackedOutText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.progress,
      builder: (context, child) {
        return Text.rich(
          TextSpan(
            children: [
              for (var i = 0; i < widget._slices.length; i++)
                (i / widget._slices.length < widget.progress.value)
                    ? widget._slices[i]
                    : widget._slicesTransparent[i],
            ],
          ),
          textAlign: widget.textAlign,
          style: widget.style,
        );
      },
    );
  }
}
