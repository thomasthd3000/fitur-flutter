class API {
  //static const hostConnect = "http://192.168.43.87/infobyteapi";

  //static const hostConnect = "http://192.168.10.34/infobyteapi";

  // static const hostConnectLive =
  //     "https://mobileapps.swa-jkt.com:8081/infobyteapi";

  // ANDROID SIMULATOR
  static const hostConnectLive = "http://192.168.59.87/infobyteapi";

  // IOS SIMULATOR
  //static const hostConnectLive = "http://127.0.0.1/infobyteapi";

  static const getAllInfo = "$hostConnectLive/info/allinfo.php";
  static const searchInfo = "$hostConnectLive/info/search.php";
  static const login = "$hostConnectLive/user/login.php";
  static const getDetail = "$hostConnectLive/info/detail.php";
  static const getUrlWeb = "$hostConnectLive/info/getURL.php";

  //favorite
  static const validateFavorite = "$hostConnectLive/favorite/validate_fav.php";
  static const addFavorite = "$hostConnectLive/favorite/add_fav.php";
  static const deleteFavorite = "$hostConnectLive/favorite/del_fav.php";
  static const readFavorite = "$hostConnectLive/favorite/allfav.php";
  static const searchFavorite = "$hostConnectLive/favorite/search_fav.php";

  //agreement
  static const getAgreement = "$hostConnectLive/handbook/getStatusHandbook.php";
  static const setAgreement = "$hostConnectLive/handbook/setStatusHandbook.php";
  static const listAgreement = "$hostConnectLive/handbook/listHandbook.php";

  static const getAllPost = "https://jsonplaceholder.typicode.com/posts";

  //versions
  static const getVersions = "$hostConnectLive/versions/versions.php";
}
