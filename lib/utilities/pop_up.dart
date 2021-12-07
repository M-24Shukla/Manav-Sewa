/*
void pop_up(CalendarTapDetails cd) {




  String msg = 'Do you want to make a booking?'.toUpperCase();
  bool flag = true;

  final dt = cd.date;
  final before = DateTime.now().subtract(Duration(days: 1));
  final after = DateTime.now().add(Duration(days: 90));
  if (dt.compareTo(before) == -1) {
    msg = "You cannot book a slot before today!".toUpperCase();
    flag = !flag;
  }
  else if (dt.compareTo(after) == 1) {
    List<String> months= ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];

    msg = "You cannot book a slot after ${after.day}/${months[after.month-1]}!".toUpperCase();
    flag = !flag;
  }
  else if (dt_set.contains(dt)) {
    msg = "This slot is already booked!".toUpperCase();
    flag = !flag;
  }
  String name = "Payment to :";
  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
    String dropdownvalue = 'Apple';
    var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
//            color: Colors.red,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
//                  mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        msg,
                        style: TextStyle(
                          fontSize: 19,

                        ),
                      ),
                      SizedBox(height: 20.0,),
                      if (flag) ...[
                        // empty slot
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            // email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Name'),
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            // email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Mobile No.'),
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            // email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Address'),
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            // email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Email-ID'),
                        ),
                        DropdownButton(
                          value: dropdownvalue,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items:items.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(items)
                            );
                          }
                          ).toList(),
                          onChanged: (String newValue){
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                        ),
                        yesNoRow(cd, context),

                      ]
                      else ...[
                        RoundedButton(
                          label: "Ok",
                          colour: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 100.0,
                        )
                      ]
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }, settings: null));
}

 */