class Test{
  final String name;
  final String? name4;
  final List<String> name6;

  Test({required this.name,required this.name6, this.name4});

  @override
  String toString() {
    return 'Test{name: $name, name4: $name4, name6: $name6}';
  }
}

