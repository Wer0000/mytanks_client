package alternativa.tanks.model
{
   import alternativa.init.Main;
   import alternativa.model.IModel;
   import alternativa.object.ClientObject;
   import alternativa.osgi.service.dump.dumper.IDumper;
   import alternativa.register.SpaceInfo;
   import alternativa.service.IModelService;
   import alternativa.service.ISpaceService;
   import flash.utils.Dictionary;
   
   public class ItemDumper implements IDumper
   {
       
      
      public function ItemDumper()
      {
         super();
      }
      
      public function dump(params:Vector.<String>) : String
      {
         var spaces:Array = null;
         var i:int = 0;
         var objects:Dictionary = null;
         var obj:ClientObject = null;
         var models:Vector.<String> = null;
         var m:int = 0;
         var itemParams:ItemParams = null;
         var result:String = "\n";
         var modelRegister:IModelService = IModelService(Main.osgi.getService(IModelService));
         var itemModel:IItem = (modelRegister.getModelsByInterface(IItem) as Vector.<IModel>)[0] as IItem;
         if(itemModel != null)
         {
            spaces = ISpaceService(Main.osgi.getService(ISpaceService)).spaceList;
            for(i = 0; i < spaces.length; i++)
            {
               objects = SpaceInfo(spaces[i]).objectRegister.getObjects();
               for each(obj in objects)
               {
                  models = obj.getModels();
                  if(models.length > 0)
                  {
                     for(m = 0; m < models.length; m++)
                     {
                        if((itemModel as IModel).id == models[m] as String)
                        {
                           itemParams = itemModel.getParams(obj);
                           result += "\n" + itemParams.name;
                           result += "   type: " + itemParams.itemType + "\n";
                           result += "   description: " + itemParams.description + "\n";
                           result += "   rankId: " + itemParams.rankId + "\n";
                           result += "   price: " + itemParams.price + "\n";
                        }
                     }
                  }
               }
            }
         }
         else
         {
            result += "ItemModel not registered!";
         }
         return result + "\n";
      }
      
      public function get dumperName() : String
      {
         return "item";
      }
   }
}
