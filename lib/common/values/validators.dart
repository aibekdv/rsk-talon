final RegExp passwordPattern =
    RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$');

bool? isValidPhoneNumber(String input) {
  if (input.startsWith('996')) {
    if (input.length == 12) {
      return true;
    }
  } else if (input.startsWith('0')) {
    if (input.length == 10) {
      return true;
    }
  }
  return null;
}
