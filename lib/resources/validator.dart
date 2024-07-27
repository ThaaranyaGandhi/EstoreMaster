class Validator {

  static String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  static validateNonNull(String? value, {String? label}){

    return value==null || value.trim().isEmpty 
      ? '${label ?? 'Field' } is required'
      : null;
  }

  static validateEmail(String? value, {String? label}){
    RegExp emailRegExp = RegExp(emailRegex);

    return value==null || value.trim().isEmpty 
      ? '${label ?? 'Field' } is required'
      : !emailRegExp.hasMatch(value) 
      ? 'Invalid Email Address'
      : null;
  }

  static validatePassword(String? value, {String? label}){

    return value==null || value.trim().isEmpty 
      ? '${label ?? 'Field' } is required'
      : value.length<8
      ? 'Password should have atleast 8 characters'
      : null;
  }

}