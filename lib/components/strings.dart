
RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');

//password must contain minimum eight characters, at least one letter and one number:
RegExp passwordRexExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$');

RegExp specialCharRexExp = RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])');