class Session {
  final String access;
  final String refresh;

  Session({
    required this.access,
    required this.refresh,
  });

  Session copyWith({
    String? access,
    String? refresh,
  }) {
    return Session(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  @override
  String toString() => 'Session(access: $access, refresh: $refresh)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Session &&
        other.access == access &&
        other.refresh == refresh;
  }

  @override
  int get hashCode => access.hashCode ^ refresh.hashCode;
}
