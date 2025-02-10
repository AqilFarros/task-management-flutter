part of "../page.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await _authService.signUp(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );

          successSnackbar(context: context, message: "Sign up success.");
        }
      } catch (e) {
        if (mounted) {
          dangerSnackbar(context: context, message: e.toString());
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultMargin),
                      image: const DecorationImage(
                        image: AssetImage("asset/image/banner.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    "Welcome To Our App",
                    style: semiBold.copyWith(
                      fontSize: heading1,
                      color: greenColor,
                    ),
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    "Ensuring your duties, excellent management,\nand a perfect life.",
                    style: regular.copyWith(
                        fontSize: description, color: grayColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: defaultMargin * 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          hintText: "First Name",
                          icon: Icons.person,
                          controller: firstNameController,
                          textInputType: TextInputType.name,
                          validator: firstNameValidator,
                        ),
                      ),
                      const SizedBox(
                        width: defaultMargin,
                      ),
                      Expanded(
                        child: InputText(
                          hintText: "Last Name",
                          icon: Icons.person,
                          controller: lastNameController,
                          textInputType: TextInputType.name,
                          validator: lastNameValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  InputText(
                    hintText: "Email",
                    icon: Icons.email,
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  InputText(
                    hintText: "Password",
                    icon: Icons.lock,
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  InputText(
                    hintText: "Confirmation Password",
                    icon: Icons.lock,
                    controller: confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    validator: (String? value) {
                      return confirmPasswordValidator(
                          value, passwordController);
                    },
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                          color: greenColor,
                        )
                      : SubmitButton(
                          text: "Sign up",
                          onPressed: _signUp,
                        ),
                  const SizedBox(
                    height: defaultMargin * 2,
                  ),
                  Text(
                    "Or sign up with",
                    style: medium.copyWith(
                      fontSize: description,
                      color: grayColor,
                    ),
                  ),
                  const SizedBox(
                    height: defaultMargin * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AuthIcon(
                        text: "Google",
                        icon: Icons.email,
                        color: gmailColor,
                      ),
                      AuthIcon(
                        text: "Facebook",
                        icon: Icons.facebook,
                        color: facebookColor,
                      ),
                      AuthIcon(
                        text: "Apple",
                        icon: Icons.apple,
                        color: appleColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultMargin * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: medium.copyWith(
                          fontSize: heading3,
                          color: grayColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: semiBold.copyWith(
                            fontSize: heading3,
                            color: greenColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
