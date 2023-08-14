final emailValidation = RegExp(r'\w*@\w*.\w*');
final passwordValidation = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{12,16}$');
