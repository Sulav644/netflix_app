import '../../domain/netflix_data.dart';

extension ListExtension on List<String> {
  List<String> capitalizeList() {
    final list = List.generate(
        length,
        (index) => this[index]
            .toString()
            .split(" ")
            .map((e) => e.contains('^')
                ? e.toUpperCase()
                : e[0].toUpperCase() + e.substring(1))
            .toString()
            .replaceAll(RegExp(r'[(,^)]'), ""));
    return list;
  }
}

extension ListExtensionNew on List<List> {
  List<List> capitalizeAndTrimListNew() {
    List<List> list = List.generate(
        length,
        (index) => this[index]
            .map((e) => e
                .toString()
                .split(" ")
                .map((i) => i == e.toString().split(" ")[1]
                    ? "${i[0].toUpperCase()}${i.substring(1)}/"
                    : i[0].toUpperCase() + i.substring(1))
                .toString()
                .replaceAll(RegExp(r'[(,)]'), ""))
            .toList()).toList();

    return list;
  }
}

extension ListExtensionOne on List<List> {
  List<List> capitalizeAndTrimListOne() {
    List<List> list = List.generate(
        length,
        (index) => this[index]
            .map((e) =>
                e.toString()[0].toUpperCase() + e.toString().substring(1))
            .toList()).toList();

    return list;
  }
}

class Images {
  List<MovieDetail> nowPlaying;
  List<MovieDetail> popularSeries;
  List<MovieDetail> animes;
  List<MovieDetail> tvComedies;
  Images(
      {required this.nowPlaying,
      required this.popularSeries,
      required this.animes,
      required this.tvComedies});
}

class ContentDescription {
  String description;
  String director;
  List<String> writers;
  List<String> stars;
  ContentDescription(
      {required this.description,
      required this.director,
      required this.writers,
      required this.stars});
}

List directors = [
  "james cameron",
  "rick jaffa",
  "christopher nolan",
  "james mangold",
  "kirsten biyer",
  "amanda silver",
  "michael chabon",
  "achiva goldsman",
  "patrick stewart",
  "michalle hurd",
  "alison pill",
  "j.j. abrams",
  "jeffrey lieber",
  "daemon lindelof",
  "george garcia",
  "josh holloway"
].capitalizeList();
List writers = [
  [
    "james cameron",
    "rick jaffa",
    "amanda silver",
  ],
  [
    "christopher nolan",
    "james mangold",
    "kirsten biyer",
  ],
  [
    "michael chabon",
    "patrick stewart",
    "achiva goldsman",
  ],
  [
    "michalle hurd",
    "alison pill",
    "j.j. abrams",
  ],
  [
    "jeffrey lieber",
    "daemon lindelof",
    "george garcia",
  ],
  [
    "christopher nolan",
    "james mangold",
    "george garcia",
  ]
].capitalizeAndTrimListNew();

String description =
    "Set almost 100 years after Captain Kirk's 5-year mission, a new generation of Starfleet officers sets off in the U.S.S. Enterprise-D on its own mission to go where no one has gone before.";
String descriptionTwo =
    "A chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine with a former student in order to secure his family's future.";
String descriptionThree =
    "Two F.B.I. Agents, Fox Mulder the believer and Dana Scully the skeptic, investigate the strange and unexplained, while hidden forces work to impede their efforts.";
String descriptionFour =
    "An F.B.I. agent is forced to work with an institutionalized scientist and his son in order to rationalize a brewing storm of unexplained phenomena.";
String descriptionFive =
    "The survivors of a plane crash are forced to work together in order to survive on a seemingly deserted tropical island.";
List stars = [
  ["sam worthington", "zoe saldana", "sigourne weaver"],
  ["kristen biyer", "patrick stewart", "alison pill"],
  ["rick jaffa", "amanda silver", "achiva goldsman"],
  ["michalle hurd", "daemon lindelof", "george garcia"],
  ["j.j. abrams", "jeffrey lieber", "michalle hurd"],
  ["zoe saldana", "jeffrey lieber", "achiva goldsman"]
].capitalizeAndTrimListNew();

MovieContentDescription movieContentDescription = MovieContentDescription(
    description: description,
    director: directors[0],
    writers: writers[0],
    stars: stars[0]);
List titles = [
  "avatar: the way of water",
  "breaking bad",
  "stars wars: the mandalorian",
  "the witcher",
  "game of thrones",
  "black mirror",
  "dare devil",
  "dark",
  "mind hunter",
  "money heist",
  "narcos",
  "stranger things",
  "the boys",
  "extraction",
  "the haunting of the hill house",
  "the queen's gambit",
  "wednesday",
  "attack on titan",
  "black mirror",
  "bleach",
  "blue lock",
  "death note",
  "howl's moving castle",
  "monster",
  "naruto",
  "spirited",
  "the legend of the vox machina",
  "tokyo revengers",
  "black mirror",
  "your name",
  "extraordinary: attorney woo",
  "friends",
  "ginny & georgia",
  "how i met your father",
  "modern family",
  "night court",
  "shrinking",
  "ted lasso",
  "the 90's show",
  "the big bang theory",
  "the office",
  "the white lotus",
].capitalizeList();
List genres = [
  ["action", "adventure", "fantacy"],
  ["crime", "drama", "thriller"],
  ["adventure", "crime", "fantacy"],
  ["fantacy", "adventure", "drama"],
  ["sci-fi", "crime", "action"],
  ["comedy", "action", "horror"],
  ["thriller", "horror", "sci-fi"],
  ["mystery", "crime", "adventure"],
  ["horror", "mystery", "thriller"],
  ["action", "thriller", "mystery"],
  ["crime", "sci-fi", "comedy"],
  ["adventure", "comedy", "fantacy"],
  ["fantacy", "action", "drama"],
  ["sci-fi", "adventure", "action"],
  ["comedy", "crime", "horror"],
  ["thriller", "horror", "sci-fi"],
  ["mystery", "mystery", "adventure"],
  ["horror", "thriller", "thriller"],
  ["action", "sci-fi", "mystery"],
  ["crime", "comedy", "comedy"],
  ["adventure", "action", "fantacy"],
  ["fantacy", "adventure", "drama"],
  ["sci-fi", "thriller", "action"],
  ["comedy", "crime", "horror"],
  ["thriller", "horror", "sci-fi"],
  ["mystery", "action", "adventure"],
  ["horror", "comedy", "thriller"],
  ["action", "sci-fi", "mystery"],
  ["crime", "comedy", "fantacy"],
  ["adventure", "crime", "mystery"],
  ["fantacy", "thriller", "sci-fi"],
  ["sci-fi", "adventure", "drama"],
  ["comedy", "action", "adventure"],
  ["thriller", "crime", "horror"],
  ["mystery", "horror", "action"],
  ["horror", "comedy", "sci-fi"],
  ["action", "horror", "comedy"],
  ["crime", "sci-fi", "horror"],
  ["adventure", "fantacy", "action"],
  ["fantacy", "thriller", "horror"],
  ["sci-fi", "adventure", "drama"],
  ["comedy", "action", "adventure"]
].capitalizeAndTrimListOne();
List imgUrls = [
  "https://w0.peakpx.com/wallpaper/771/901/HD-wallpaper-avatar-the-way-of-water-2-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/796/421/HD-wallpaper-breaking-bad-heisenberg-say-my-name-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/356/132/HD-wallpaper-tv-show-the-mandalorian-baby-yoda-grogu-star-wars-star-wars-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/134/238/HD-wallpaper-the-witcher-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/595/983/HD-wallpaper-game-of-thrones-amoled-black-game-games-season-show-throne-thrones-tv-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/320/983/HD-wallpaper-black-mirror-smiley-broken-cracked-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/300/721/HD-wallpaper-daredevil-portrait-daredevil-superheroes-artwork-behance-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/602/919/HD-wallpaper-dark-netflix-serie-dark-netflix-serie-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/708/286/HD-wallpaper-tv-show-mindhunter-mindhunter-tv-show-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/652/445/HD-wallpaper-tv-show-la-casa-de-papel-la-casa-de-papel-money-heist-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/133/862/HD-wallpaper-narcos-pablo-escobar-pablo-escobar-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/115/845/HD-wallpaper-stranger-things-3-demogorgon-netflix-stranger-things-stranger-things-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/623/959/HD-wallpaper-squid-game-squid-games-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/57/861/HD-wallpaper-extraction-movie-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/361/225/HD-wallpaper-hill-house-netflix-the-haunting-of-hill-house-haunting-of-hill-house-horror-residencia-hill-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/581/591/HD-wallpaper-the-day-after-tomorrow-thumbnail.jpg",
  "https://w0.peakpx.com/wallpaper/305/688/HD-wallpaper-netflix-wednesday-2022-thumbnail.jpg",
  "https://m.media-amazon.com/images/M/MV5BMGY3Mzg3M2UtNzYxNi00ZDYzLTlhMTQtMjkzZTA2MWQ4NjA0XkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_FMjpg_UX1000_.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE4WagbxcmpFexVkl-Qt7k13vpNUrUUpqVow&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPbicxJ7CKsr0I0sRTZH9OBae5ykKHhT_Hlw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtHGZjlz6sKTAJ3ibzL8_D1SJrYTo23EpYJw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSF1H9I54cpkmnbtfRQ7PWITJUVP3eLTmnFVA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZWpa6KUf3Nk07KLWZQnDAlgNrVw1_dGFdsw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo68Zdcl0f0cdHNObKA1Db2JrPNfD2ZB-xYA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTeyZlxmStOAwGbEq6RcwngwVxtH3qsYZvkg&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv2i9wnY1ShOnAP4rhZzsRfaZIV1Jh6fITAQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpsYDn0hDW_DdNzCvvceICCCPXQfJ-PsG7Zg&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne_9ShgIKE_HoamJk4n6zMsHmUUKGROpSnA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKCbn0oqILZS7Bzvs0e-o5eHmm6ql1qvxyVQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZLiyP5z3YI3avmlERF3tIcEsRDci8TofVBw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_RWRP8pIsN3IxVQuU9EQt-bEbikJnOksvmQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToeDle-SnUXU4rhaxUBemjA8H3fLwUv-ZW1g&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu5Hcvpnm2MDb_8ktWKLs5sC_jVmyyb5SR1w&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSgNQ14tkSrfitw1brewb1IukUm7TpVxe2jQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyOXSXPdvBW2O0KQu4bzSc2tRzXK-64AR9oA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOcFrmAz9YJkIWMqYUpsK5VWre7_Mxx0SSCQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9eZr8LAy6e0NoB_kzGdVd3hgFkk-PRrlM2g&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxpDhASWpj4nJZB3IdL_cazqujniCVSIgMOA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEzhD0mNzo-ATYMfhN5QV7-HmCFdMAlxmcHw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCXyLqYBYoeKGMY9NpTM9iphGjhaOjs_XPhA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-AR-fhYSOMX6oq9qkOdcA4lNGHuMCzs9lvA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzIoIFHMt1TVmcavTc58N8SJYlE24zBt3gZg&usqp=CAU"
];
List<MovieDetail> nowPlaying = [
  MovieDetail(
    imgUrl: imgUrls[0],
    title: titles[0],
    genre: genres[0],
    movieContentDescription: MovieContentDescription(
        description: description,
        director: directors[0],
        writers: writers[0],
        stars: stars[0]),
  ),
  MovieDetail(
      imgUrl: imgUrls[1],
      title: titles[1],
      genre: genres[1],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[1],
          writers: writers[1],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[2],
      title: titles[2],
      genre: genres[2],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[2],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[3],
      title: titles[3],
      genre: genres[3],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[3],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[4],
      title: titles[4],
      genre: genres[4],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[4],
          writers: writers[5],
          stars: stars[4]))
];
List<MovieDetail> popularSeries = [
  MovieDetail(
      imgUrl: imgUrls[5],
      title: titles[5],
      genre: genres[5],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[5],
          writers: writers[0],
          stars: stars[5])),
  MovieDetail(
      imgUrl: imgUrls[6],
      title: titles[6],
      genre: genres[6],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[6],
          writers: writers[1],
          stars: stars[0])),
  MovieDetail(
      imgUrl: imgUrls[7],
      title: titles[7],
      genre: genres[7],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[7],
          writers: writers[2],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[8],
      title: titles[8],
      genre: genres[8],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[8],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[9],
      title: titles[9],
      genre: genres[9],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[9],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[10],
      title: titles[10],
      genre: genres[10],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[10],
          writers: writers[5],
          stars: stars[4])),
  MovieDetail(
      imgUrl: imgUrls[11],
      title: titles[11],
      genre: genres[11],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[11],
          writers: writers[0],
          stars: stars[5])),
  MovieDetail(
      imgUrl: imgUrls[12],
      title: titles[12],
      genre: genres[12],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[12],
          writers: writers[1],
          stars: stars[0])),
  MovieDetail(
      imgUrl: imgUrls[13],
      title: titles[13],
      genre: genres[13],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[13],
          writers: writers[2],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[14],
      title: titles[14],
      genre: genres[14],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[14],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[15],
      title: titles[15],
      genre: genres[15],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[15],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[16],
      title: titles[16],
      genre: genres[16],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[0],
          writers: writers[5],
          stars: stars[4])),
];
List<MovieDetail> animes = [
  MovieDetail(
      imgUrl: imgUrls[17],
      title: titles[17],
      genre: genres[17],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[1],
          writers: writers[0],
          stars: stars[5])),
  MovieDetail(
      imgUrl: imgUrls[18],
      title: titles[18],
      genre: genres[18],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[2],
          writers: writers[1],
          stars: stars[0])),
  MovieDetail(
      imgUrl: imgUrls[19],
      title: titles[19],
      genre: genres[19],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[3],
          writers: writers[2],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[20],
      title: titles[20],
      genre: genres[20],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[4],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[21],
      title: titles[21],
      genre: genres[21],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[5],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[22],
      title: titles[22],
      genre: genres[22],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[6],
          writers: writers[5],
          stars: stars[4])),
  MovieDetail(
      imgUrl: imgUrls[23],
      title: titles[23],
      genre: genres[23],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[7],
          writers: writers[0],
          stars: stars[5])),
  MovieDetail(
      imgUrl: imgUrls[24],
      title: titles[24],
      genre: genres[24],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[8],
          writers: writers[1],
          stars: stars[0])),
  MovieDetail(
      imgUrl: imgUrls[25],
      title: titles[25],
      genre: genres[25],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[9],
          writers: writers[2],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[26],
      title: titles[26],
      genre: genres[26],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[10],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[27],
      title: titles[27],
      genre: genres[27],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[11],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[28],
      title: titles[28],
      genre: genres[28],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[12],
          writers: writers[5],
          stars: stars[4])),
  MovieDetail(
      imgUrl: imgUrls[29],
      title: titles[29],
      genre: genres[29],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[13],
          writers: writers[0],
          stars: stars[5])),
];
List<MovieDetail> tvComedies = [
  MovieDetail(
      imgUrl: imgUrls[30],
      title: titles[30],
      genre: genres[30],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[14],
          writers: writers[1],
          stars: stars[0])),
  MovieDetail(
      imgUrl: imgUrls[31],
      title: titles[31],
      genre: genres[31],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[15],
          writers: writers[2],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[32],
      title: titles[32],
      genre: genres[32],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[0],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[33],
      title: titles[33],
      genre: genres[33],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[1],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[34],
      title: titles[34],
      genre: genres[34],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[2],
          writers: writers[5],
          stars: stars[4])),
  MovieDetail(
      imgUrl: imgUrls[35],
      title: titles[35],
      genre: genres[35],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[3],
          writers: writers[0],
          stars: stars[5])),
  MovieDetail(
      imgUrl: imgUrls[36],
      title: titles[36],
      genre: genres[36],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[4],
          writers: writers[1],
          stars: stars[0])),
  MovieDetail(
      imgUrl: imgUrls[37],
      title: titles[37],
      genre: genres[37],
      movieContentDescription: MovieContentDescription(
          description: descriptionThree,
          director: directors[5],
          writers: writers[2],
          stars: stars[1])),
  MovieDetail(
      imgUrl: imgUrls[38],
      title: titles[38],
      genre: genres[38],
      movieContentDescription: MovieContentDescription(
          description: descriptionFour,
          director: directors[6],
          writers: writers[3],
          stars: stars[2])),
  MovieDetail(
      imgUrl: imgUrls[39],
      title: titles[39],
      genre: genres[39],
      movieContentDescription: MovieContentDescription(
          description: descriptionFive,
          director: directors[7],
          writers: writers[4],
          stars: stars[3])),
  MovieDetail(
      imgUrl: imgUrls[40],
      title: titles[40],
      genre: genres[40],
      movieContentDescription: MovieContentDescription(
          description: description,
          director: directors[8],
          writers: writers[5],
          stars: stars[4])),
  MovieDetail(
      imgUrl: imgUrls[41],
      title: titles[41],
      genre: genres[41],
      movieContentDescription: MovieContentDescription(
          description: descriptionTwo,
          director: directors[9],
          writers: writers[0],
          stars: stars[5])),
];
