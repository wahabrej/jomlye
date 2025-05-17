import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/models/home/home_data_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/filter_blog_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/movie/filter_movie_list_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/movie/movie_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/movie/movie_list_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/tv_shows/tv_show_filter_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/tv_shows/tv_shows_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/tv_shows/tv_shows_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class HomeController extends GetxController {
    final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  var currentIndex = 0.obs;
  final RxString selectedTitle = RxString(""); 

  //* Top Artist
  final RxBool isViewAllSearchEnable = RxBool(false);
  final TextEditingController viewAllTextEditingController = TextEditingController();
  final RxBool isTopArtistSearchSuffixShow = RxBool(false);
  //* blog
  final RxString selectedBlogGenre = RxString("");
  final RxString selectedBlogCategories = RxString("");
  final RxString selectedBlogCategoryId = RxString("");
  final RxString selectedBlogYear = RxString("");
  final RxString selectedBlogLanguage = RxString("");

    void blogFilterValueReset(){
    selectedBlogCategories.value ="";
    selectedBlogYear.value = "";
    selectedBlogLanguage.value = "";
  }

  //* Tv Channel
      final RxList tvChannelCategoriesList =
      RxList(["News", "Drama", "Songs", "Game", "Movies","Sports", "Cricket", "Football"]);
  final RxString selectedTvChannelCategories = RxString("");
  final RxString selectedTvChannelsSort = RxString("");

      void tvChannelsFilterValueReset(){
    selectedBlogLanguage.value = "";
    // selectedArtistsSort.value = "";
  }

  final RxList<Map<String, dynamic>> recentPlayedMovies =
      RxList<Map<String, dynamic>>([
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
  ]);
  
  final RxList blogBulletPointList = RxList([
    "Sed mattis risus vel lectus faucibus, lobortis tristique dolor consequat.",
    "Praesent interdum mauris sit amet sapien rutrum, non pellentesque urna fermentum.",
    "Morbi ultricies lectus eget erat lobortis, ut semper sapien porttitor.",
    "Quisque quis purus sit amet augue imperdiet elementum id fringilla augue.",
  ]);

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  //!blog
  final TextEditingController addCommentTextEditingController = TextEditingController();


  //!Common Search
  final TextEditingController searchTextEditingController = TextEditingController();
  final RxBool isSearchSuffixIconShow = RxBool(false);
  //! Cast details screen
  final RxInt selectedIndex = RxInt(0); // Default selected index
  final List<String> tabs = ["Movies", "Personal Information"];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
  final RxDouble lowerValue = RxDouble(0);
  final RxDouble upperValue = RxDouble(0);

  //!Home Api implement
  //*Home
  final Rx<HomeDataModel?> homeDataModel = Rx<HomeDataModel?>(null);
  final RxList<NewReleaseMovie> sliderList = RxList<NewReleaseMovie>([]);
  final RxList<Genre> genreList = RxList<Genre>([]);
  final RxList<NewReleaseMovie> newReleaseMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> trendingMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> recommendedMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> popularTvShowsList = RxList<NewReleaseMovie>([]);
  final RxList<FeaturedTvChannel> featuredTvChannelsList = RxList<FeaturedTvChannel>([]);
  final RxList<NewReleaseMovie> tvShowsList = RxList<NewReleaseMovie>([]);
  final RxList<TopArtist> topArtistsList = RxList<TopArtist>([]);
  final RxList<LatestBlog> latestBlogsList = RxList<LatestBlog>([]);
   final RxBool isHomePageLoading = RxBool(false);
  Future<void> getHomePage() async {
    try {
      isHomePageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuHome,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
         homeDataModel.value = HomeDataModel.fromJson(response.data);
        sliderList.clear();
        genreList.clear();
        newReleaseMoviesList.clear();
        trendingMoviesList.clear();
        recommendedMoviesList.clear();
        popularTvShowsList.clear();
        featuredTvChannelsList.clear();
        tvShowsList.clear();
        topArtistsList.clear();
        latestBlogsList.clear();
        sliderList.addAll(homeDataModel.value!.slider!);
        genreList.addAll(homeDataModel.value!.genres!);
        newReleaseMoviesList.addAll(homeDataModel.value!.newReleaseMovies!);
        trendingMoviesList.addAll(homeDataModel.value!.trendingMovies!);
        recommendedMoviesList.addAll(homeDataModel.value!.recommendedMovies!);
        popularTvShowsList.addAll(homeDataModel.value!.popularTvShows!);
        featuredTvChannelsList.addAll(homeDataModel.value!.featuredTvChannels!);
        tvShowsList.addAll(homeDataModel.value!.tvShows!);
        topArtistsList.addAll(homeDataModel.value!.topArtists!);
        latestBlogsList.addAll(homeDataModel.value!.latestBlogs!);
         await spController.savePrivacyPolicy(homeDataModel.value!.privacyPolicy);
         await spController.savePaymentPolicy(homeDataModel.value!.paymentPolicy);
         await spController.saveTermsAndCondition(homeDataModel.value!.termsAndConditions);
        Get.find<GlobalController>().privacyPolicyUrl.value =
            await spController.getPrivacyPolicy() ?? "";
        Get.find<GlobalController>().paymentPolicyUrl.value =
            await spController.getPaymentPolicy() ?? "";
        Get.find<GlobalController>().termsAndConditionUrl.value =
            await spController.getTermsAndCondition() ?? "";
        isHomePageLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isHomePageLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(
              title: ksError.tr,
              message: response.message.toString(),
              color: cPrimaryColor2);
        } else {
          showSnackBar(
              title: ksError.tr,
              message: errorModel.errors[0].message,
              color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isHomePageLoading.value = false;
      ll('getHomePage error: $e');
    }
  }

  final RxInt selectedMovieServer = RxInt(0);
  //!Movie
  final RxInt selectedCategoryId = RxInt(-1);
  final RxString selectedCategory = RxString("");
  final RxInt selectedCountryId = RxInt(-1);
  final RxString selectedCountry = RxString("");
  final RxInt selectedGenreId = RxInt(-1);
  final RxString selectedGenre = RxString("");
  final RxInt selectedLanguageId = RxInt(-1);
  final RxString selectedLanguage = RxString("");
  final RxInt selectedSortId = RxInt(-1);
  final RxString selectedSort = RxString("");
  final RxString selectedYear = RxString("");
  final RxBool isApplyClicked = RxBool(false);
  // all movie api implement
  final RxBool isMovieListLoading = RxBool(false);
  final Rx<MovieListModel?> movieListModel = Rx<MovieListModel?>(null);
  final RxList<MovieData?> movieList = RxList<MovieData?>([]);
  final RxList<MovieData?> temporaryMovieList = RxList<MovieData?>([]);
  final RxList<Categories?> movieCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> movieCountryList = RxList<Countries?>([]);
  final RxList<Countries?> movieLanguageList = RxList<Countries?>([]);
  final RxList<Countries?> movieGenreList = RxList<Countries?>([]);
  final RxList<int> movieYearList = RxList<int>([]);
  final RxMap<String, String> movieSort = RxMap<String, String>();
  Future<void> getMovieList({required String movieType}) async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovies?type=$movieType",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieList.clear();
        temporaryMovieList.clear();
        movieCategoryList.clear();
        movieCountryList.clear();
        movieLanguageList.clear();
        movieGenreList.clear();
        movieYearList.clear();
        MovieListModel movieListModel = MovieListModel.fromJson(response.data);
        movieList.addAll(movieListModel.movies!.data!);
        temporaryMovieList.addAll(movieListModel.movies!.data!);
        movieCategoryList.addAll(movieListModel.filter!.categories!);
        movieCountryList.addAll(movieListModel.filter!.country!);
        movieLanguageList.addAll(movieListModel.filter!.languages!);
        movieGenreList.addAll(movieListModel.filter!.genre!);
        movieYearList.addAll(movieListModel.filter!.year!);
        movieSort.value = movieListModel.filter!.sort!;
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isMovieListLoading.value = false;
      ll('getMovieList error: $e');
    }
  }

  final Rx<FilterMovieListModel?> filterMovieListModel = Rx<FilterMovieListModel?>(null);
  Future<void> getFilterMovieList() async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovieFilter?string=&category_id=${selectedCategoryId.value!=-1 ? selectedCategoryId.value.toString():""}&genre=${selectedGenreId.value!=-1 ? selectedGenreId.value.toString():""}&country_id=${selectedCountryId.value!=-1 ? selectedCountryId.value.toString():""}&year=${selectedYear.value.toString()}&language_id=${selectedLanguageId.value!=-1 ? selectedLanguageId.value.toString():""}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieList.clear();
        FilterMovieListModel filterMovieListModel = FilterMovieListModel.fromJson(response.data);
        movieList.addAll(filterMovieListModel.movies!.data!);
        Get.back();
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isMovieListLoading.value = false;
      ll('getFilterMovieList error: $e');
    }
  }

    // movie details api implement
  final RxBool isMovieDetailsLoading = RxBool(false);
  final Rx<MovieDetailsModel?> movieDetailsModel = Rx<MovieDetailsModel?>(null);
  final Rx<MovieDetails?> movieDetailsData = Rx<MovieDetails?>(null);
  final RxList<Server?> movieServerList = RxList<Server?>([]);
  final RxList<Cast?> movieCastList = RxList<Cast?>([]);
  final RxList<Cast?> movieDirectorList = RxList<Cast?>([]);
  final RxList<Cast?> movieWriterList = RxList<Cast?>([]);
  final RxList<MovieDetails> relatedMovieList = RxList<MovieDetails>([]);
  final RxList<MovieDetails> recommendedMovieList = RxList<MovieDetails>([]);
  final RxList<int> playlistIdsList = RxList<int>([]);
  Future<void> getMovieDetails({required String movieId}) async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovieDetails?id=$movieId&user_id=${userId.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieServerList.clear();
        movieCastList.clear();
        movieDirectorList.clear();
        movieWriterList.clear();
        relatedMovieList.clear();
        recommendedMovieList.clear();
        playlistIdsList.clear();
        MovieDetailsModel movieDetailsModel = MovieDetailsModel.fromJson(response.data);
        movieDetailsData.value = movieDetailsModel.details;
        movieServerList.addAll(movieDetailsModel.server!);
        movieCastList.addAll(movieDetailsModel.cast!);
        movieDirectorList.addAll(movieDetailsModel.cast!);
        movieWriterList.addAll(movieDetailsModel.writer!);
        relatedMovieList.addAll(movieDetailsModel.relatedMovie!);
        recommendedMovieList.addAll(movieDetailsModel.recommendedMovie!);
        playlistIdsList.addAll(movieDetailsModel.playlistIds!);
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isMovieListLoading.value = false;
      ll('getMovieDetails error: $e');
    }
  }

    //!Tv Shows
    //tv shows api implement
  final RxBool isTvShowLoading = RxBool(false);
  final Rx<TvShowsModel?> tvShowsModel = Rx<TvShowsModel?>(null);
  final RxList<TvShowData?> tvShowList = RxList<TvShowData?>([]);
  final RxList<Categories?> tvShowsCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> tvShowCountryList = RxList<Countries?>([]);
  final RxList<Countries?> tvShowLanguageList = RxList<Countries?>([]);
  final RxList<Countries?> tvShowGenreList = RxList<Countries?>([]);
  final RxList<int> tvShowYearList = RxList<int>([]);
  final RxMap<String, String> tvShowSort = RxMap<String, String>();
  Future<void> getTvShows() async {
    try {
      isTvShowLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuTvShows,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        tvShowList.clear();
        tvShowsCategoryList.clear();
        tvShowCountryList.clear();
        tvShowLanguageList.clear();
        tvShowGenreList.clear();
        tvShowYearList.clear();
        TvShowsModel tvShowsModel = TvShowsModel.fromJson(response.data);
        tvShowList.addAll(tvShowsModel.shows!.data!);
        tvShowsCategoryList.addAll(tvShowsModel.filter!.categories!);
        tvShowCountryList.addAll(tvShowsModel.filter!.country!);
        tvShowLanguageList.addAll(tvShowsModel.filter!.languages!);
        tvShowGenreList.addAll(tvShowsModel.filter!.genre!);
        tvShowYearList.addAll(tvShowsModel.filter!.year!);
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isTvShowLoading.value = false;
      ll('getTvShows error: $e');
    }
  }

  final RxBool isTvShowDetailsLoading = RxBool(false);
  final Rx<TvShowDetailsModel?> tvShowDetailsModel = Rx<TvShowDetailsModel?>(null);
  final Rx<TvShows?> tvShowDetailsData = Rx<TvShows?>(null);
  final RxList<Season?> tvShowsSeasonList = RxList<Season?>([]);
  final RxList<Episode?> tvShowEpisodeList = RxList<Episode?>([]);
  Future<void> getTvShowDetails({required int showId}) async {
    try {
      isTvShowLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuTvShowDetails?id=$showId",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        tvShowsSeasonList.clear();
        tvShowEpisodeList.clear();
        TvShowDetailsModel tvShowDetailsModel = TvShowDetailsModel.fromJson(response.data);
        tvShowDetailsData.value =  tvShowDetailsModel.shows;
        tvShowsSeasonList.addAll(tvShowDetailsModel.shows!.seasons!);
        if(tvShowsSeasonList.isNotEmpty){
        tvShowEpisodeList.addAll(tvShowDetailsModel.shows!.seasons![0].episodes!);
        }
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isTvShowLoading.value = false;
      ll('getTvShows error: $e');
    }
  }


  final Rx<TvShowFilterModel?> tvShowFilterModel = Rx<TvShowFilterModel?>(null);
  Future<void> getTvShowFilter() async {
    try {
      isTvShowLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuTvShowFilter?string=&category_id=${selectedCategoryId.value!=-1 ? selectedCategoryId.value.toString():""}&genre=${selectedGenreId.value!=-1 ? selectedGenreId.value.toString():""}&country_id=${selectedCountryId.value!=-1 ? selectedCountryId.value.toString():""}&year=${selectedYear.value.toString()}&language_id=${selectedLanguageId.value!=-1 ? selectedLanguageId.value.toString():""}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        tvShowList.clear();
        TvShowFilterModel tvShowFilterModel = TvShowFilterModel.fromJson(response.data);
        tvShowList.addAll(tvShowFilterModel.details!.data!);
        Get.back();
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isTvShowLoading.value = false;
      ll('getTvShowFilter error: $e');
    }
  }

   //!Top Artist
 //Artist api implement
 final RxInt selectedMovieIndustryId = RxInt(-1);
   final RxBool isArtistLoading = RxBool(false);
   final Rx<ArtistModel?> artistModel = Rx<ArtistModel?>(null);
  final RxList<ArtistData> artistList = RxList<ArtistData>([]);
  final RxList<ArtistCountry> artistCountryList = RxList<ArtistCountry>([]);
  final RxList<MovieIndustry> artistMovieIndustryList = RxList<MovieIndustry>([]);
  Future<void> getArtistList() async {
    try {
      isArtistLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuArtist?name=${viewAllTextEditingController.text}&country=${selectedCountryId.value==-1 ? "" : selectedCountryId.value.toString()}&movie_industry=${selectedMovieIndustryId.value==-1 ? "" : selectedMovieIndustryId.value.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        artistList.clear();
        artistCountryList.clear();
        artistMovieIndustryList.clear();
        ArtistModel artistModel = ArtistModel.fromJson(response.data);
        artistList.addAll(artistModel.artists!.data!);
        artistCountryList.addAll(artistModel.filter!.countries!);
        artistMovieIndustryList.addAll(artistModel.filter!.movieIndustries!);
        isArtistLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isArtistLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isArtistLoading.value = false;
      ll('getArtistList error: $e');
    }
  }

   //Artist details api implement
   final RxBool isArtistDetailsLoading = RxBool(false);
   final Rx<ArtistDetailsModel?> artistDetailsModel = Rx<ArtistDetailsModel?>(null);
  final Rx<Details?> artistDetailsData = Rx<Details?>(null);
  final RxList<Movie> artistMovieList = RxList<Movie>([]);
  Future<void> getArtistDetails([int? id]) async {
    try {
      isArtistDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuArtistDetails?id=${id.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        ArtistDetailsModel artistDetailsModel = ArtistDetailsModel.fromJson(response.data);
        artistMovieList.clear();
        artistMovieList.addAll(artistDetailsModel.movies!);
        artistDetailsData.value = artistDetailsModel.details;
        isArtistDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isArtistDetailsLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isArtistDetailsLoading.value = false;
      ll('getArtistDetails error: $e');
    }
  }

   //!Blogs
 //blog api implement
   final RxBool isBlogLoading = RxBool(false);
   final Rx<BlogModel?> blogModel = Rx<BlogModel?>(null);
  final Rx<Blogs?> blogs = Rx<Blogs?>(null);
  final RxList<Categories> blogCategoryList = RxList<Categories>([]);
  final RxList<BlogData> blogList = RxList<BlogData>([]);
  final RxList<int> blogYearList = RxList<int>([]);
  Future<void> getBlogList() async {
    try {
      isBlogLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuBlogs,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        BlogModel blogModel = BlogModel.fromJson(response.data);
        blogCategoryList.clear();
        blogYearList.clear();
        blogList.clear();
        blogs.value = blogModel.blogs;
        blogList.addAll(blogModel.blogs!.data!);
        ll("The blog filter category data is ${blogModel.filter!.categories}");
        ll("The blog filter category data length is ${blogModel.filter!.categories!.length}");
        blogCategoryList.addAll(blogModel.filter!.categories!);
        blogYearList.addAll(blogModel.filter!.year!);
        isBlogLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isBlogLoading.value = false;
      ll('getBlogList error: $e');
    }
  }


  //blog api implement
  final RxBool isBlogFilterLoading = RxBool(false);
  final Rx<FilterBlogModel?> filterBlogModel = Rx<FilterBlogModel?>(null);
  Future<void> getBlogFilterList() async {
    try {
      isBlogFilterLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuBlogFilter?string=&category_id=${selectedBlogCategoryId.value.toString()}&year=${selectedBlogYear.value.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        FilterBlogModel filterBlogModel = FilterBlogModel.fromJson(response.data);
        blogList.clear();
        blogList.addAll(filterBlogModel.details!.data!);
        isBlogFilterLoading.value = false;
        Get.back();
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogFilterLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isBlogFilterLoading.value = false;
      ll('getBlogFilterList error: $e');
    }
  }

  //blog details api implement
   final RxBool isBlogDetailsLoading = RxBool(false);
   final Rx<BlogDetailsModel?> blogDetailsModel = Rx<BlogDetailsModel?>(null);
  final Rx<Detailes?> blogDetails = Rx<Detailes?>(null);
  final Rx<Categories?> blogCategories = Rx<Categories?>(null);
  final RxList<Detailes> latestBlogList = RxList<Detailes>([]);
  Future<void> getBlogDetails([int? id]) async {
    try {
      isBlogDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuBlogDetails?id=${id.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        latestBlogList.clear();
        BlogDetailsModel blogDetailsModel = BlogDetailsModel.fromJson(response.data);
        blogDetails.value = blogDetailsModel.details;
        blogCategories.value = blogDetailsModel.category;
        latestBlogList.addAll(blogDetailsModel.latestBlogs!);
        isBlogDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogDetailsLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isBlogDetailsLoading.value = false;
      ll('getBlogDetails error: $e');
    }
  }

  //!reset bottom nav bar data
  void resetBottomSheetData(){
  selectedCategoryId.value = -1;
  selectedCountryId.value = -1;
  selectedGenreId.value = -1;
  selectedLanguageId.value = -1;
  selectedSortId.value = -1;
  selectedYear.value = "";
  selectedMovieIndustryId.value = -1;
  selectedCategory.value = "";
  selectedGenre.value = "";
  selectedCountry.value = "";
  selectedLanguage.value = "";
  isApplyClicked.value = false;
  }

}
