String? customValidator(String? value, String field) {
  if (value == null || value.isEmpty || value.trim().isEmpty) {
    return 'Por favor ingresa tu $field';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().isEmpty) {
    return 'Por favor ingresa tu correo';
  }
  final emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  if (!emailRegExp.hasMatch(value)) {
    return 'Por favor ingresa un correo válido';
  }
  return null;
}

String? dniValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().isEmpty) {
    return 'Por favor ingresa tu DNI';
  }
  final dniRegExp = RegExp(
    r'^\d{8}$',
  );
  if (!dniRegExp.hasMatch(value)) {
    return 'Por favor ingresa un DNI válido';
  }
  return null;
}

String? birthDateValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().isEmpty) {
    return 'Por favor ingresa tu fecha de nacimiento';
  }
  final birthDateRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2}$',
  );
  if (!birthDateRegExp.hasMatch(value)) {
    return 'Por favor ingresa una fecha de nacimiento válida';
  }
  return null;
}
