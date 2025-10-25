class Urls {
  static String baseUrl = "http://35.73.30.144:2008/api/v1";
  static String readProduct = "$baseUrl/ReadProduct";
  static String readProductById = "$baseUrl/ReadProductById";
  static String deleteProductById(String id) => "$baseUrl/DeleteProduct/$id";
  static String createProduct = "$baseUrl/CreateProduct";
  static String updateProductById(String id) => "$baseUrl/UpdateProduct/$id";
}
