
// class PaymentHistoryModel {
//     final PaymentHistory? paymentHistory;

//     PaymentHistoryModel({
//         this.paymentHistory,
//     });

//     factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
//         paymentHistory: json["payment_history"] == null ? null : PaymentHistory.fromJson(json["payment_history"]),
//     );
// }

// class PaymentHistory {
//     final int? currentPage;
//     final List<PaymentHistoryData>? data;
//     final String? firstPageUrl;
//     final int? from;
//     final int? lastPage;
//     final String? lastPageUrl;
//     final List<Link>? links;
//     final dynamic nextPageUrl;
//     final String? path;
//     final int? perPage;
//     final dynamic prevPageUrl;
//     final int? to;
//     final int? total;

//     PaymentHistory({
//         this.currentPage,
//         this.data,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.links,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total,
//     });

//     factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
//         currentPage: json["current_page"],
//         data: json["data"] == null ? [] : List<PaymentHistoryData>.from(json["data"]!.map((x) => PaymentHistoryData.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//     );
// }

// class PaymentHistoryData {
//     final int? id;
//     final int? userId;
//     final int? packageId;
//     final String? paymentGateway;
//     final dynamic transactionId;
//     final String? amount;
//     final String? currency;
//     final String? status;
//     final String? details;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;

//     PaymentHistoryData({
//         this.id,
//         this.userId,
//         this.packageId,
//         this.paymentGateway,
//         this.transactionId,
//         this.amount,
//         this.currency,
//         this.status,
//         this.details,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory PaymentHistoryData.fromJson(Map<String, dynamic> json) => PaymentHistoryData(
//         id: json["id"],
//         userId: json["user_id"],
//         packageId: json["package_id"],
//         paymentGateway: json["payment_gateway"],
//         transactionId: json["transaction_id"],
//         amount: json["amount"],
//         currency: json["currency"],
//         status: json["status"],
//         details: json["details"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );
// }

// class Link {
//     final String? url;
//     final String? label;
//     final bool? active;

//     Link({
//         this.url,
//         this.label,
//         this.active,
//     });

//     factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//     );
// }


class PaymentHistoryModel {
    final PaymentHistory? paymentHistory;

    PaymentHistoryModel({
        this.paymentHistory,
    });

    factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
        paymentHistory: json["payment_history"] == null ? null : PaymentHistory.fromJson(json["payment_history"]),
    );

    Map<String, dynamic> toJson() => {
        "payment_history": paymentHistory?.toJson(),
    };
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

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class PaymentHistoryData {
    final int? id;
    final int? clientId;
    final int? planId;
    final String? isRecurring;
    final dynamic teamLimit;
    final int? teamLimitRemaining;
    final dynamic profileLimit;
    final int? profileLimitRemaining;
    final dynamic postLimit;
    final int? postLimitRemaining;
    final DateTime? purchaseDate;
    final int? price;
    final String? packageType;
    final int? status;
    final DateTime? expireDate;
    final dynamic canceledAt;
    final String? trxId;
    final String? paymentMethod;
    final String? paymentDetails;
    final dynamic billingName;
    final dynamic billingEmail;
    final dynamic billingAddress;
    final dynamic billingCity;
    final dynamic billingState;
    final dynamic billingZipCode;
    final dynamic billingCountry;
    final dynamic billingPhone;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    PaymentHistoryData({
        this.id,
        this.clientId,
        this.planId,
        this.isRecurring,
        this.teamLimit,
        this.teamLimitRemaining,
        this.profileLimit,
        this.profileLimitRemaining,
        this.postLimit,
        this.postLimitRemaining,
        this.purchaseDate,
        this.price,
        this.packageType,
        this.status,
        this.expireDate,
        this.canceledAt,
        this.trxId,
        this.paymentMethod,
        this.paymentDetails,
        this.billingName,
        this.billingEmail,
        this.billingAddress,
        this.billingCity,
        this.billingState,
        this.billingZipCode,
        this.billingCountry,
        this.billingPhone,
        this.createdAt,
        this.updatedAt,
    });

    factory PaymentHistoryData.fromJson(Map<String, dynamic> json) => PaymentHistoryData(
        id: json["id"],
        clientId: json["client_id"],
        planId: json["plan_id"],
        isRecurring: json["is_recurring"],
        teamLimit: json["team_limit"],
        teamLimitRemaining: json["team_limit_remaining"],
        profileLimit: json["profile_limit"],
        profileLimitRemaining: json["profile_limit_remaining"],
        postLimit: json["post_limit"],
        postLimitRemaining: json["post_limit_remaining"],
        purchaseDate: json["purchase_date"] == null ? null : DateTime.parse(json["purchase_date"]),
        price: json["price"],
        packageType: json["package_type"],
        status: json["status"],
        expireDate: json["expire_date"] == null ? null : DateTime.parse(json["expire_date"]),
        canceledAt: json["canceled_at"],
        trxId: json["trx_id"],
        paymentMethod: json["payment_method"],
        paymentDetails: json["payment_details"],
        billingName: json["billing_name"],
        billingEmail: json["billing_email"],
        billingAddress: json["billing_address"],
        billingCity: json["billing_city"],
        billingState: json["billing_state"],
        billingZipCode: json["billing_zip_code"],
        billingCountry: json["billing_country"],
        billingPhone: json["billing_phone"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "plan_id": planId,
        "is_recurring": isRecurring,
        "team_limit": teamLimit,
        "team_limit_remaining": teamLimitRemaining,
        "profile_limit": profileLimit,
        "profile_limit_remaining": profileLimitRemaining,
        "post_limit": postLimit,
        "post_limit_remaining": postLimitRemaining,
        "purchase_date": purchaseDate?.toIso8601String(),
        "price": price,
        "package_type": packageType,
        "status": status,
        "expire_date": "${expireDate!.year.toString().padLeft(4, '0')}-${expireDate!.month.toString().padLeft(2, '0')}-${expireDate!.day.toString().padLeft(2, '0')}",
        "canceled_at": canceledAt,
        "trx_id": trxId,
        "payment_method": paymentMethod,
        "payment_details": paymentDetails,
        "billing_name": billingName,
        "billing_email": billingEmail,
        "billing_address": billingAddress,
        "billing_city": billingCity,
        "billing_state": billingState,
        "billing_zip_code": billingZipCode,
        "billing_country": billingCountry,
        "billing_phone": billingPhone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
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

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
