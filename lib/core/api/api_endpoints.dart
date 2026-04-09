class EndPoints {
  static const String register = "/register";
  static const String login = "/login";
  static const String verifyOtp = "/verify-otp";
  static const String resendOtp = "/resend-otp";
  static const String forgotPassword = '/forgot/password';
  static const String forgotVerifyOtp = '/forgot/verify-otp';
  static const String forgotResendOtp = '/forgot/resend-otp';
  static const String forgotResetPassword = '/forgot/reset-password';
  static const String logout = "/logout";
  static const String profile = "/profile";
  static const String updateProfile = "/updateProfile";
  static const String terms = "/terms";
  static const String aboutUs = "/about-us";
  static const String faq = "/faq";
  static const String categories = "/categories";
  static const String recipes = "/recipes";
  static const String recipeTypes = "/recipe-types";
  static const String materials = "/materials";
  static const String materialFamilies = "/material-families";
  static const String banners = "/banners";
  static const String welcomeScreens = "/welcome-screens";
  static const String supplierMaterials = "/supplier-materials";
  static const String suppliers = "/suppliers";
  static String categoryItems(int id) => "/category-items/$id";
  
  // Chat
  static const String chats = "/chats";
  static String chatMessages(int id) => "/chats/$id/messages";
}
