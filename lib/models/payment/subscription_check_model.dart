class SubscriptionCheckModel {
    final bool? isSubscribed;
    final String? message;

    SubscriptionCheckModel({
        this.isSubscribed,
        this.message,
    });

    factory SubscriptionCheckModel.fromJson(Map<String, dynamic> json) => SubscriptionCheckModel(
        isSubscribed: json["is_subscribed"],
        message: json["message"],
    );
}
