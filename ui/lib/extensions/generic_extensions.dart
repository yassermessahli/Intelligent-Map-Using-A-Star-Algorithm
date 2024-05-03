extension GenericExt<T> on T {
  T? nullIfEqualTo(T other) {
    return this == other ? null : this;
  }
}