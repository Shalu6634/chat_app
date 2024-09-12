class UserModal {
  String? name, email, password, phone, token, image;

  UserModal({
    required this.name,
    required this.email,
    // required this.password,
    required this.phone,
    required this.token,
    required this.image,
  });

  factory UserModal.fromMap(Map m1)
  {
    return UserModal(name: m1['name'],
        email: m1['email'],
        // password: m1['password'],
        phone: m1['phone'],
        token: m1['token'],
        image: m1['image']);
  }

  UserModal toMap(UserModal user) {
    return UserModal(
        name:user.name,
        email: user.email,
        // password: user.password,
        phone: user.phone,
        token: user.token,
        image: user.image);
  }
}
