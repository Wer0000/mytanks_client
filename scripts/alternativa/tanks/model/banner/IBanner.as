package alternativa.tanks.model.banner
{
   import alternativa.object.ClientObject;
   import flash.display.BitmapData;
   
   public interface IBanner
   {
       
      
      function getBannerBd(param1:ClientObject) : BitmapData;
      
      function getBannerURL(param1:ClientObject) : String;
      
      function click(param1:ClientObject) : void;
   }
}
