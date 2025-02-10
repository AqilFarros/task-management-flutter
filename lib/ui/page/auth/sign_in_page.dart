part of '../page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        await _authService.signIn(email, password);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );

          successSnackbar(context: context, message: "Sign in success.");
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          dangerSnackbar(context: context, message: e.message.toString());
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
        child: Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                    "Welcome Back",
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
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password",
                        style: medium.copyWith(
                          fontSize: heading3,
                          color: greenColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                          color: greenColor,
                        )
                      : SubmitButton(
                          text: "Sign in",
                          onPressed: _signIn,
                        ),
                  const SizedBox(
                    height: defaultMargin * 2,
                  ),
                  Text(
                    "Or sign in with",
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
                        "Haven't has an account?",
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
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
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
