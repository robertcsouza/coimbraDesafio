class Status {
  String status;
  int id;

  Status({String status, int id}) {
    this.status = status;
    this.id = id;
  }
  asString() {
    return this.status;
  }

  toMap() {
    Map<String, dynamic> map = {"status": this.status};
    return map;
  }
}
