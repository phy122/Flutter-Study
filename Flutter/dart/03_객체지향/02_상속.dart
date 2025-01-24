class Animal {
  void makeSound() {
    print('Some generic sound');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof! Woof!');
  }
}

void main() {
  var dog = Dog();
  dog.makeSound(); // 출력: Woof! Woof!
}
