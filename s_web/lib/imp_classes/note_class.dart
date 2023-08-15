import 'package:hive/hive.dart';
part 'note_class.g.dart';

@HiveType(typeId: 0)
class Note{
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  String _type="note";
  Note({required this.content,required this.title});
}
