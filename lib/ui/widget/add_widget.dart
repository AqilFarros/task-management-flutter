part of 'widget.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({super.key, required this.title});

  final String title;

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2100),
        builder: (BuildContext context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: greenColor,
                onPrimary: blackColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: greenColor,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat.yMMMMd().format(picked);
      });
    }
  }

  void _createGoals() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: [
          SubmitButton(
            text: "Cancel",
            onPressed: () {
              _titleController.clear();
              _descriptionController.clear();
              _dateController.clear();
              Navigator.pop(context);
            },
            color: turqoiseColor,
          ),
          SubmitButton(
            onPressed: () {},
            text: "Set a goal",
          ),
        ],
        title: Text(
          widget.title,
          style: semiBold.copyWith(fontSize: heading1),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputText(
              controller: _titleController,
              hintText: "Title",
              icon: Icons.title_rounded,
              textInputType: TextInputType.text,
              validator: titleValidator,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputText(
              controller: _descriptionController,
              hintText: "Description",
              icon: Icons.description,
              textInputType: TextInputType.text,
              validator: titleValidator,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputText(
              controller: _dateController,
              hintText: "Deadline",
              icon: Icons.calendar_today,
              validator: titleValidator,
              onTap: _selectDate,
              readOnly: true,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: semiBold.copyWith(fontSize: heading1),
        ),
        IconButton(
          onPressed: () {
            if (widget.title == "Set a new goal") {
              _createGoals();
            } else {}
          },
          style: IconButton.styleFrom(backgroundColor: greenColor),
          icon: Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
      ],
    );
  }
}
