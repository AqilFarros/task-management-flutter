part of 'widget.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  final String text;
  final Function onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: color ?? greenColor,
        ),
        child: Text(
          text,
          style: medium.copyWith(
            fontSize: heading3,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
