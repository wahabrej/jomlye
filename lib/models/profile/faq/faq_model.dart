class FaqModel {
    List<Order>? payment;
    List<Order>? order;

    FaqModel({
        this.payment,
        this.order,
    });

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        payment: json["payment"] == null ? [] : List<Order>.from(json["payment"]!.map((x) => Order.fromJson(x))),
        order: json["order"] == null ? [] : List<Order>.from(json["order"]!.map((x) => Order.fromJson(x))),
    );
}

class Order {
    int? id;
    String? question;
    String? answer;
    String? type;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Order({
        this.id,
        this.question,
        this.answer,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        type: json["type"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
