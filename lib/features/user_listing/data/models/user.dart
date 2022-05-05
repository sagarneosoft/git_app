class User{
  final int id;
  final String name;
  final String avatar;
  bool isSelected;


  User({required this.id,required this.name, required this.avatar, this.isSelected =false});
  @override
  String toString() {
    return 'ID: $id Name: $name,Avatar $avatar , isSelected: $isSelected';
  }
}