void main(List<String> args) {
  // 변수 선언
  int age = 20;
  String name = "김조은";

// $변수면 : 문자열 내의 변수값을 지정
  print("age : $age");
  print("name : $name");

  // 실수
  double weight = 45.56;
  double height = 170.23;
  print("weight : $weight");
  print("height : $height");

  // 불리언
  bool check = false;
  print("check : $check");

  // 널 허용 타입 (Nullable : ?)
  int? data = null;
  print("data : $data");

  // 널 허용 타입에 ! 사용
  data = 10;
  print("data (Not Null) : ${data}"); // data 가 null 이 아님을 보장(단언)
  int? data2;
  print("data (Not Null) : ${data2}"); // null 인 데이터에는 ! 사용하면 에러

  // 상수
  // const : 선언과 동시에 초기화해야한다.
  // final : 선언 후 초기화 가능, 값 변경 불가
  const PI = 3.141592;
  final String systemCode;
  systemCode = "SYS0001";
  // systemCode = "ERR0001";  // 상수는 값을 변경할 수 없음

  print("PI : $PI");
  print("systemCode : $systemCode");
}
