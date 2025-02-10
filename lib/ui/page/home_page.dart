part of 'page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("10 Februari 2025"),
                Text("New day, new goals."),
                Text("Hi ${_authService.currentUser!.email}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
