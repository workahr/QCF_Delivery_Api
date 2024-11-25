Future getOrderConfirmLocationListJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "pickupItemsCount": 3,
        "orderId": "C234",
        "itemsname1": "Chicken Biryani",
        "itemsqty1": "1",
        "itemsname2": "Chicken Biryani",
        "itemsqty2": "1",
        "itemsname3": "Chicken Biryani",
        "itemsqty3": "1",
        "totalItems": "3",
        "status": 1,
        "active": 1,
        "created_date": null,
        "updated_by": 102,
        "updated_date": null,
      }
    ],
    "code": "206",
    "message": "Listed Successfully."
  };

  return result;
}
