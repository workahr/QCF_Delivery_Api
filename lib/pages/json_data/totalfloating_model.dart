Future gettotalfloatingPageJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "id": 1,
        "orderid": "#123456789",
        "time": "12:30",
        "item": '10',
        "earningstatus": "605",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": null,
        "updated_by": 102,
        "updated_date": null
      },
      {
        "id": 2,
        "orderid": "#123456789",
        "time": "12:30",
        "item": '10',
        "earningstatus": "1100",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": null,
        "updated_by": 102,
        "updated_date": null
      },
    ],
    "code": "206",
    "message": "Listed Succesfully."
  };

  return result;
}
