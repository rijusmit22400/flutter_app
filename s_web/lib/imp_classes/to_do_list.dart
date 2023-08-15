import 'package:hive/hive.dart';
part 'to_do_list.g.dart';

@HiveType(typeId: 1)
class to_do_list{
  @HiveField(0)
  String title;
  @HiveField(1)
  List item;
  @HiveField(2)
  List status;
  @HiveField(3)
  String _type="list";
  to_do_list({required this.title,required this.item,required this.status});
}
