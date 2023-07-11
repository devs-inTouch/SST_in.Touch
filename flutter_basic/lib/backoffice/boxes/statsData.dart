class StatsData {
  final int onlineUsers;
  final int postsDone;
  final int unhandledReports;
  final int unactivatedAccounts;
  final int unhandledReservations;

  StatsData({
    required this.onlineUsers,
    required this.postsDone,
    required this.unhandledReports,
    required this.unactivatedAccounts,
    required this.unhandledReservations,
  });

  factory StatsData.fromJson(Map<String, dynamic> json) {
    return StatsData(
      onlineUsers: json['onlineUsers'],
      postsDone: json['postsDone'],
      unhandledReports: json['unhandledReports'],
      unactivatedAccounts: json['unactivatedAccounts'],
      unhandledReservations: json['unhandledReservations'],
    );
  }
}
