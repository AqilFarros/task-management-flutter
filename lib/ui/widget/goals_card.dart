part of "widget.dart";

class GoalsCard extends StatefulWidget {
  const GoalsCard({super.key});

  @override
  State<GoalsCard> createState() => _GoalsCardState();
}

class _GoalsCardState extends State<GoalsCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultMargin),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - (80 + 2 * defaultMargin),
            padding: const EdgeInsets.all(defaultMargin),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(defaultMargin),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (newbool) {
                    setState(() {
                      isChecked = newbool!;
                    });
                  },
                  activeColor: whiteColor,
                  checkColor: redColor,
                  side: BorderSide(
                    strokeAlign: 10,
                    color: whiteColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "JUDUL DARI SEBUAH GOALS",
                        style: regular.copyWith(
                          fontSize: heading2,
                          color: whiteColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Deskripsi dari sebuah goals",
                        style: regular.copyWith(
                          color: whiteColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 70,
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(defaultMargin),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_sharp, color: whiteColor, size: 30),
                Text(
                  "On going",
                  style: regular.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
