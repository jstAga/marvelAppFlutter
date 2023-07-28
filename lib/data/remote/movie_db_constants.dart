class MovieDbConstants {
  static const baseUrl = "https://api.themoviedb.org/3";
  static const apiKey = "db4f25ed06d95e5c2ca4d4695470a0dd";
  static const baseImage = "https://image.tmdb.org/t/p/w500";

  static const getToken = "/authentication/token/new?";
  static const postValidateUser = "/authentication/token/validate_with_login?";
  static const postSession = "/authentication/session/new?";
  static const accountInfo = "/account?";

  static const getMovies = "/movie/popular";
  static const searchMovie = "/search/movie";
  static const movieDetails = "/movie/";
}

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return "movie";
      case MediaType.tv:
        return "tv";
    }
  }
}