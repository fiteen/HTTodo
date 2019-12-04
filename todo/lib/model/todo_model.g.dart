part of 'todo_model.dart';
Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(json['name'] as String,
      parent: json['parent'] as String,
      id: json['id'] as String,
      isCompleted: json['completed'] as int,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic> {
  'id': instance.id,
  'parent': instance.parent,
  'name': instance.name,
  'completed': instance.isCompleted 
};