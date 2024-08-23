class Keys {
  //Create Singleton class instance
  static final Keys _keys = Keys._internal();

  //Private constructor
  Keys._internal();

  //Factory constructor
  factory Keys() {
    return _keys;
  }

  //Define keys
  static const taskKey = 'tasks';
}
