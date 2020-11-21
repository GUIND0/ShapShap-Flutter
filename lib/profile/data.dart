class SliderModel{
  String ImagePath;
  String title;
  String desc;

  SliderModel({this.ImagePath,this.title,this.desc});

  void setImageAssetPath(String getpath){
    ImagePath = getpath;
  }

  void setTitle(String Title){
    title = Title;
  }

  void setDescription(String description){
    desc = description;
  }

  String getpath(){
    return ImagePath;
  }
  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}

List<SliderModel> getSlide(){
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  sliderModel.setImageAssetPath("assets/shopping.jpg");
  sliderModel.setDescription("Faites vos shopping en toute simplicité sur shapshap,une interface simplifié un moteur de recherche performent à votre disposition.");
  sliderModel.setTitle("Shopping");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImageAssetPath("assets/market.jpg");
  sliderModel.setDescription("Retrouver tous vos commerçants sur une seul plateforme,les meilleurs produits aux meilleurs prix.");
  sliderModel.setTitle("Produit");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImageAssetPath("assets/deliver.jpg");
  sliderModel.setDescription("La livraison est gratuite partout à Bamako avec un délai de livraison de 24h maximum");
  sliderModel.setTitle("Livraison");
  slides.add(sliderModel);
  sliderModel = new SliderModel();
  return slides;

}