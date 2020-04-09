class Utils{
  static String getUsername(
      String email
      ){

    return 'Koona:${email.split('@')[0]}';

  }
  static String getCode(
      String name
      ){
    List<String> split = name.split(" ");
    String initial1 = split[0][0].toUpperCase();
    String initial2 = split [1][0].toUpperCase();
    return initial1 + "." + initial2;
  }
}