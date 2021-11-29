class ProjectTabModel {
  String? name;
  int? id;
  List<ProjectTabModel?>? children;
  String? tagIndex;

  ProjectTabModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        children = (json['children'] as List)
            .map((e) => e == null
                ? null
                : new ProjectTabModel.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'children': children,
      };
}
