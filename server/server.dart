void main(List<String> args) {
  Dog dog = new Dog('PitBull', 'Bark', breedName: 'German Shepard');
  dog.electricVariant('Nigeria');
  dog.displayLanguage();
  print(dog.displayName);
}

mixin Unknown {
  void electricVariant(String country) {
    print('This is an electric variant ${country}');
  }
}

abstract class AllFunction {

  
  void callBack(int arg1, int arg2);
}

abstract class Animal with Unknown implements AllFunction {
  final String animalName;
  final String language;
  Animal({required this.animalName, required this.language});

  setAnimalLanguage(String language) {
    this.language;
  }

  void displayLanguage();
}

class Dog extends Animal {
  final String breedName;

  Dog(String anmialName, String languuage, {required this.breedName}) : super(animalName: anmialName, language: languuage);

  get displayName => this.breedName;

  @override
  void displayLanguage() {
    print(this.language);
  }
  
  @override
  void callBack(int arg1, int arg2) {
   
  }
  

}
