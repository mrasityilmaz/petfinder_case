part of 'bottom_nav_bar.dart';

final class _BottomAppBarPainter extends CustomPainter {
  _BottomAppBarPainter({required this.horizontalPadding, this.borderColor, this.backgroundColor});

  final double horizontalPadding;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor ?? Colors.white;
    final outerPaint = Paint()..color = Colors.transparent;

    final borderPaint = Paint()
      ..color = borderColor ?? Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(horizontalPadding, 20)
      ..lineTo(horizontalPadding, 20)
      ..arcToPoint(
        Offset(horizontalPadding + 20, 0),
        radius: const Radius.circular(25),
      )
      ..lineTo(size.width - horizontalPadding - 20, 0)
      ..arcToPoint(
        Offset(size.width - horizontalPadding, 20),
        radius: const Radius.circular(25),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(horizontalPadding, 20)
      ..close();

    canvas
      ..drawPath(
        Path()
          ..addRRect(
            const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ).resolve(TextDirection.ltr).toRRect(canvas.getDestinationClipBounds()),
          ),
        outerPaint,
      )
      ..drawPath(
        path,
        paint,
      )
      ..drawPath(
        path,
        borderPaint,
      );
  }

  @override
  bool shouldRepaint(_BottomAppBarPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_BottomAppBarPainter oldDelegate) => false;
}
