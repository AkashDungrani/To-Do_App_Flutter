class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
 

  Task(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
     });

  Task.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    note = data['note'];
    isCompleted = data['isCompleted'];
    date = data['date'];
    startTime = data['startTime'];
    endTime = data['endTime'];
    color = data['color'];
  
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    
    return data;
  }
}
