part of "widget.dart";

class GoalsCard extends StatefulWidget {
  const GoalsCard({
    super.key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.priority,
    required this.status,
    required this.goalId,
  });

  final String title;
  final String description;
  final String deadline;
  final String priority;
  final String status;
  final String goalId;

  @override
  State<GoalsCard> createState() => _GoalsCardState();
}

class _GoalsCardState extends State<GoalsCard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String>? priority;
  String? selectedPriority;

  @override
  void initState() {
    priority = ['Low', 'Medium', 'High'];
    selectedPriority = priority![0];
    super.initState();
  }

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

  void _updateGoal() async {
    if (mounted) Navigator.pop(context);

    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    _dateController.text = widget.deadline;
    selectedPriority = widget.priority;

    void storeGoals() async {
      if (_formKey.currentState!.validate()) {
        try {
          await GoalService().updateGoal(
            goalId: widget.goalId,
            title: _titleController.text,
            description: _descriptionController.text,
            deadline: _dateController.text,
            priority: selectedPriority!,
          );

          if (mounted) {
            successSnackbar(
                context: context, message: "Successfully updated a goal.");
          }
        } catch (e) {
          if (mounted) {
            dangerSnackbar(context: context, message: e.toString());
          }
        } finally {
          _dateController.clear();
          _descriptionController.clear();
          _titleController.clear();
          setState(() {
            selectedPriority = priority![0];
          });
          if (mounted) {
            Navigator.pop(context);
          }
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
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
                onPressed: () {
                  storeGoals();
                },
                text: "Edit a goal",
              ),
            ],
            title: Text(
              widget.title,
              style: semiBold.copyWith(fontSize: heading1),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputText(
                    controller: _titleController,
                    hintText: "Title",
                    icon: Icons.title_rounded,
                    textInputType: TextInputType.text,
                    validator: titleValidator,
                  ),
                  const SizedBox(height: defaultMargin),
                  InputText(
                    controller: _descriptionController,
                    hintText: "Description",
                    icon: Icons.description,
                    textInputType: TextInputType.text,
                    validator: titleValidator,
                  ),
                  const SizedBox(height: defaultMargin),
                  InputText(
                    controller: _dateController,
                    hintText: "Deadline",
                    icon: Icons.calendar_today,
                    validator: titleValidator,
                    onTap: _selectDate,
                    readOnly: true,
                  ),
                  const SizedBox(height: defaultMargin),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: selectedPriority,
                      underline: Container(
                        height: 1,
                        color: greenColor,
                      ),
                      items: priority!.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setDialogState(() {
                          setState(() {
                            selectedPriority = value!;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateStatus(String status) async {
    await GoalService().updateStatus(goalId: widget.goalId, status: status);
    if (mounted) {
      if (status == "hasn't started") {
        successSnackbar(
            context: context, message: "Don't forget to achive your goal!");
      } else if (status == "on going") {
        successSnackbar(
            context: context, message: "Keep it up, you're doing great!");
      } else {
        successSnackbar(
            context: context,
            message: "Congratulation, you have done one goal!");
      }
      Navigator.pop(context);
    }
  }

  void _deleteGaol() async {
    await GoalService().deleteGoal(goalId: widget.goalId);
    if (mounted) {
      successSnackbar(
          context: context, message: "Successfully, deleted a goal!");
      Navigator.pop(context);
    }
  }

  void _detailGoal() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: [
          widget.status != "hasn't started"
              ? SubmitButton(
                  text: "Hasn't started",
                  onPressed: () {
                    _updateStatus("hasn't started");
                  },
                  color: redColor,
                )
              : const SizedBox(),
          widget.status != "on going"
              ? SubmitButton(
                  text: "On going",
                  onPressed: () {
                    _updateStatus("on going");
                  },
                  color: yellowColor,
                )
              : const SizedBox(),
          widget.status != "done"
              ? SubmitButton(
                  text: "Done",
                  onPressed: () {
                    _updateStatus("done");
                  },
                  color: greenColor,
                )
              : const SizedBox(),
        ],
        title: Text(
          widget.title,
          style: semiBold.copyWith(fontSize: heading1),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 5),
                Text(widget.deadline),
              ],
            ),
            const SizedBox(height: defaultMargin),
            Text(
              widget.description,
              style: regular,
            ),
            const SizedBox(height: defaultMargin),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SubmitButton(
                  text: "Edit goal",
                  onPressed: () {
                    _updateGoal();
                  },
                  color: yellowColor,
                ),
                const SizedBox(width: 5),
                SubmitButton(
                  text: "Delete goal",
                  onPressed: () {
                    _deleteGaol();
                  },
                  color: redColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _detailGoal();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        child: Row(
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width - (80 + 2 * defaultMargin),
              padding: const EdgeInsets.all(defaultMargin),
              decoration: BoxDecoration(
                color: widget.priority == 'High'
                    ? redColor
                    : widget.priority == 'Medium'
                        ? yellowColor
                        : greenColor,
                borderRadius: BorderRadius.circular(defaultMargin),
              ),
              child: Row(
                children: [
                  widget.status == 'done'
                      ? Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(defaultMargin),
                            border: Border.all(color: whiteColor),
                          ),
                          child: Icon(
                            Icons.check,
                            color: widget.priority == 'High'
                                ? redColor
                                : widget.priority == 'Medium'
                                    ? yellowColor
                                    : greenColor,
                          ),
                        )
                      : Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(defaultMargin),
                            border: Border.all(color: whiteColor),
                          ),
                        ),
                  const SizedBox(width: defaultMargin),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: regular.copyWith(
                            fontSize: heading1,
                            color: whiteColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.description,
                          style: regular.copyWith(
                            fontSize: description,
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
                color: widget.priority == 'High'
                    ? redColor
                    : widget.priority == 'Medium'
                        ? yellowColor
                        : greenColor,
                borderRadius: BorderRadius.circular(defaultMargin),
              ),
              child: widget.status == 'hasn\'t started'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_circle_outline_rounded,
                            color: whiteColor, size: 30),
                        Text(
                          "not yet",
                          style: regular.copyWith(color: whiteColor),
                        ),
                      ],
                    )
                  : widget.status == 'on going'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_sharp,
                                color: whiteColor, size: 30),
                            Text(
                              "On going",
                              style: regular.copyWith(color: whiteColor),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: whiteColor, size: 30),
                            Text(
                              "Done",
                              style: regular.copyWith(color: whiteColor),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
