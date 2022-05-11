package alternativa.init
{
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.locale.ru.Image;
   import alternativa.tanks.locale.ru.Text;
   import scpacker.gui.GTanksI;
   import scpacker.gui.GTanksLoaderImages;
   
   public class TanksLocaleRuActivator implements IBundleActivator
   {
      
      public static var osgi:OSGi;
       
      
      public function TanksLocaleRuActivator()
      {
         super();
      }
      
      public function start(osgi:OSGi) : void
      {
         TanksLocaleRuActivator.osgi = osgi;
         Text.init(osgi.getService(ILocaleService) as ILocaleService);
         Image.init(osgi.getService(ILocaleService) as ILocaleService);
         Main.osgi.registerService(GTanksLoaderImages,new GTanksI());
      }
      
      public function stop(osgi:OSGi) : void
      {
         TanksLocaleRuActivator.osgi = null;
      }
   }
}
