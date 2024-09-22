class OrderOption {
  final String orderBy;
  final String order;

  OrderOption({
    required this.orderBy,
    required this.order,
  });
}

List<OrderOption> orderOptions = [
  OrderOption(orderBy: "number", order: "asc"),
  OrderOption(orderBy: "number", order: "desc"),
  OrderOption(orderBy: "name", order: "asc"),
  OrderOption(orderBy: "name", order: "desc"),
];