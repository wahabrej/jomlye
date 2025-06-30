
class PaymentHistoryModel {
    final PaymentHistory? paymentHistory;

    PaymentHistoryModel({
        this.paymentHistory,
    });

    factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
        paymentHistory: json["payment_history"] == null ? null : PaymentHistory.fromJson(json["payment_history"]),
    );
}

class PaymentHistory {
    final int? currentPage;
    final List<PaymentHistoryData>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    PaymentHistory({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<PaymentHistoryData>.from(json["data"]!.map((x) => PaymentHistoryData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );
}

class PaymentHistoryData {
    final int? id;
    final int? userId;
    final int? packageId;
    final String? paymentGateway;
    final dynamic transactionId;
    final String? amount;
    final String? currency;
    final String? status;
    final String? details;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    PaymentHistoryData({
        this.id,
        this.userId,
        this.packageId,
        this.paymentGateway,
        this.transactionId,
        this.amount,
        this.currency,
        this.status,
        this.details,
        this.createdAt,
        this.updatedAt,
    });

    factory PaymentHistoryData.fromJson(Map<String, dynamic> json) => PaymentHistoryData(
        id: json["id"],
        userId: json["user_id"],
        packageId: json["package_id"],
        paymentGateway: json["payment_gateway"],
        transactionId: json["transaction_id"],
        amount: json["amount"],
        currency: json["currency"],
        status: json["status"],
        details: json["details"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class Link {
    final String? url;
    final String? label;
    final bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );
}
