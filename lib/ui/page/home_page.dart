part of 'page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final GoalService _goalService = GoalService();
  final date = DateFormat.MMMMEEEEd().format(DateTime.now());
  late Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    userData = _authService.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
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
                  FutureBuilder(
                      future: userData,
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "Hi, ${snapshot.data!['first_name']} ${snapshot.data!['last_name']} 👋",
                            style: bold.copyWith(
                              fontSize: heading1,
                              color: whiteColor,
                            ),
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date,
                        style: semiBold.copyWith(
                          fontSize: heading2,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(
                        height: defaultMargin,
                      ),
                      StreamBuilder(
                        stream: _goalService.getGoals(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container();
                          }

                          int goalCount = snapshot.data!.docs
                              .where((doc) => doc['status'] != 'done')
                              .length;

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.circular(defaultMargin),
                            ),
                            child: Text(
                              "$goalCount goals remaining",
                              style: regular.copyWith(color: redColor),
                            ),
                          );
                        },
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
                          "10 daily habits remaining",
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
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: turqoiseColor,
                          borderRadius: BorderRadius.circular(defaultMargin),
                        ),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: whiteColor,
                          unselectedLabelColor: blackColor.withOpacity(0.5),
                          indicator: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(defaultMargin),
                          ),
                          tabs: [
                            Tab(
                              child: Text(
                                "Goals",
                                style: medium.copyWith(fontSize: heading1),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Habits",
                                style: medium.copyWith(fontSize: heading1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: defaultMargin,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                const AddWidget(title: "Set a new goal"),
                                const SizedBox(
                                  height: defaultMargin,
                                ),
                                StreamBuilder(
                                    stream: _goalService.getGoals(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: greenColor,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text("Error: ${snapshot.error}"),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.docs.isEmpty) {
                                        return const Center(
                                          child: Text("No goals found."),
                                        );
                                      } else {
                                        return Expanded(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: snapshot.data!.docs
                                                    .where((doc) =>
                                                        doc['status'] != 'done')
                                                    .map(
                                                      (e) => GoalsCard(
                                                        deadline: e['deadline'],
                                                        description:
                                                            e['description'],
                                                        goalId: e.id,
                                                        priority: e['priority'],
                                                        status: e['status'],
                                                        title: e['title'],
                                                      ),
                                                    )
                                                    .toList() +
                                                snapshot.data!.docs
                                                    .where((doc) =>
                                                        doc['status'] == 'done')
                                                    .map((e) => GoalsCard(
                                                          deadline:
                                                              e['deadline'],
                                                          description:
                                                              e['description'],
                                                          goalId: e.id,
                                                          priority:
                                                              e['priority'],
                                                          status: e['status'],
                                                          title: e['title'],
                                                        ))
                                                    .toList(),
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                            Column(
                              children: [
                                AddWidget(title: "Build a new habit"),
                                const SizedBox(
                                  height: defaultMargin,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
