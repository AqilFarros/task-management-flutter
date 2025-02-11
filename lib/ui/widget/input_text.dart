part of 'widget.dart';

class InputText extends StatefulWidget {
  const InputText({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.textInputType,
    this.textInputAction,
    this.isPassword = false,
    required this.validator,
    this.onTap,
    this.readOnly,
  });

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? isPassword;
  final Function validator;
  final Function? onTap;
  final bool? readOnly;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultMargin),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultMargin),
            borderSide: BorderSide(color: greenColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultMargin),
            borderSide: BorderSide(color: redColor),
          ),
          prefixIcon: Icon(widget.icon, color: blackColor),
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure == true
                      ? Icon(
                          Icons.visibility_off,
                          color: blackColor,
                        )
                      : Icon(
                          Icons.visibility,
                          color: blackColor,
                        ),
                )
              : const SizedBox(),
          hintText: widget.hintText,
          hintStyle: regular.copyWith(
            fontSize: description,
            color: grayColor,
          ),
        ),
        cursorColor: blackColor,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        obscureText: widget.isPassword == true ? isObscure : false,
        validator: widget.validator as String? Function(String?)?,
        onTap: widget.onTap as void Function()?,
        readOnly: widget.readOnly ?? false,
      ),
    );
  }
}
