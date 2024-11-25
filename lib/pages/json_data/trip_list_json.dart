
Future getTripListJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "id": 1,
        "order_id": "#1234567",
        "time": "12.40",
        "items": "3",
        "delivery_person": "Barani",
        "order_status":"New",
        "reaching_time": "10mins",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": DateTime.now().toIso8601String(),
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },
      {
        "id": 2,
        "order_id": "#456785",
        "time": "1.40",
        "items": "3",
        "delivery_person": "kumar",
        "order_status":"New",
        "reaching_time": "20mins",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": DateTime.now().toIso8601String(),
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },

        {
        "id": 3,
        "order_id": "#4567851",
        "time": "2.40",
        "items": "3",
        "delivery_person": "Beskey",
        "order_status":"Active",
        "reaching_time": "30mins",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },

       {
        "id": 4,
        "order_id": "#4567852",
        "time": "3.40",
        "items": "3",
        "delivery_person": "Barani",
        "order_status":"Active",
        "reaching_time": "40mins",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },
    ],
    "code": "206",
    "message": "Listed Successfully."
  };

  return result;
}
