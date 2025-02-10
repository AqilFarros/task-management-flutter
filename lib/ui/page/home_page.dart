part of 'page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final date = DateFormat.MMMMEEEEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: turqoiseColor,
                  child: Icon(
                    Icons.person,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                Text(
                  _authService.currentUser.email,
                  style: medium.copyWith(color: turqoiseColor),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: turqoiseColor,
                  child: Icon(
                    Icons.check,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                Text(
                  _authService.currentUser.email,
                  style: medium.copyWith(color: turqoiseColor),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            color: greenColor,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: semiBold.copyWith(
                    fontSize: heading1,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(defaultMargin),
                      ),
                      child: Text(
                        "2 goals remaining",
                        style: regular.copyWith(color: redColor),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(defaultMargin),
                      ),
                      child: Text(
                        "10 daily tasks remaining",
                        style: regular.copyWith(color: yellowColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.45),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultMargin),
                child: Column(
                  children: [
                    Text("HI"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
