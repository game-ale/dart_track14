group('FeatureName', () {
  test('should do something', () async {
    // Arrange
    when(() => mock.method()).thenAnswer((_) async => result);

    // Act
    final res = await usecase();

    // Assert
    expect(res, result);
    verify(() => mock.method()).called(1);
  });
});
