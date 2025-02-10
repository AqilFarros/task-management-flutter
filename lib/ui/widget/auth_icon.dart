part of 'widget.dart';

class AuthIcon extends StatelessWidget {
  const AuthIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
  });

  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultMargin),
        color: Colors.transparent,
        border: Border.all(color: color),
      ),
      child: Icon(
        icon,
        size: 32,
        color: color,
      ),
    );
  }
}
