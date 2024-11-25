Future gettotalearningPageJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "id": 1,
        "orderid": "#123456789",
        "time": "12:30",
        "item": 10,
        "earningstatus": "70",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": DateTime.now().toIso8601String(),
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },
      {
        "id": 2,
        "orderid": "#123456789",
        "time": "12:30",
        "item": 10,
        "earningstatus": "60",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": DateTime.now().toIso8601String(),
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },
      {
        "id": 3,
        "orderid": "#123456789",
        "time": "12:30",
        "item": 10,
        "earningstatus": "60",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },
    ],
    "code": "206",
    "message": "Listed Succesfully."
  };

  return result;
}
