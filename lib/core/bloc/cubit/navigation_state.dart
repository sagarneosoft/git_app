part of 'navigation_cubit.dart';

class NavigationState {
  final int index;
  NavigationState({
    required this.index,
  });

  factory NavigationState.initial() {
    return NavigationState(index: 0);
  }

  NavigationState copyWith({
    int? index,
  }) {
    return NavigationState(
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'NavigationState(index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationState && other.index == index;
  }

  @override
  int get hashCode => index.hashCode;
}
