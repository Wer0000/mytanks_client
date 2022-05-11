package alternativa.tanks.model
{
   import alternativa.init.Main;
   import alternativa.model.IModel;
   import alternativa.model.IObjectLoadListener;
   import alternativa.models.coloring.IColoring;
   import alternativa.models.object3ds.IObject3DS;
   import alternativa.object.ClientObject;
   import alternativa.resource.Tanks3DSResource;
   import alternativa.service.IModelService;
   import com.alternativaplatform.projects.tanks.client.commons.models.itemtype.ItemTypeEnum;
   import com.alternativaplatform.projects.tanks.client.garage.item3d.IItem3DModelBase;
   import com.alternativaplatform.projects.tanks.client.garage.item3d.Item3DModelBase;
   import scpacker.resource.images.ImageResource;
   
   public class Item3DModel extends Item3DModelBase implements IItem3DModelBase, IObjectLoadListener
   {
       
      
      private var clientObject:ClientObject;
      
      private var itemType:ItemTypeEnum;
      
      public function Item3DModel()
      {
         super();
         _interfaces.push(IModel);
         _interfaces.push(IItem3DModelBase);
         _interfaces.push(IObjectLoadListener);
      }
      
      public function initObject(clientObject:ClientObject, itemType:ItemTypeEnum) : void
      {
         Main.writeToConsole("\n\n\nItem3DModel init clientObject id:" + clientObject.id + "\n\n\n");
         this.clientObject = clientObject;
         this.itemType = itemType;
      }
      
      public function objectLoaded(object:ClientObject) : void
      {
         var modelRegister:IModelService = null;
         var object3DSmodel:IObject3DS = null;
         var coloringModel:IColoring = null;
         var resource:Tanks3DSResource = null;
         Main.writeToConsole("Item3DModel objectLoaded");
         modelRegister = Main.osgi.getService(IModelService) as IModelService;
         var models:Vector.<IModel> = modelRegister.getModelsByInterface(IGarage) as Vector.<IModel>;
         var garageModel:IGarage = models[0] as IGarage;
         if(garageModel != null)
         {
            object3DSmodel = modelRegister.getModelForObject(this.clientObject,IObject3DS) as IObject3DS;
            switch(this.itemType)
            {
               case ItemTypeEnum.ARMOR:
                  if(object3DSmodel != null)
                  {
                     resource = object3DSmodel.getResource3DS(this.clientObject);
                     Main.writeToConsole("Item3DModel setHull resource: " + resource);
                  }
                  break;
               case ItemTypeEnum.WEAPON:
                  if(object3DSmodel != null)
                  {
                     resource = object3DSmodel.getResource3DS(this.clientObject);
                     Main.writeToConsole("Item3DModel setTurret resource: " + resource);
                  }
                  break;
               case ItemTypeEnum.COLOR:
                  coloringModel = modelRegister.getModelForObject(this.clientObject,IColoring) as IColoring;
                  garageModel.setColorMap(coloringModel.getResource(this.clientObject) as ImageResource);
                  break;
               case ItemTypeEnum.INVENTORY:
            }
         }
         else
         {
            Main.writeToConsole("Item3DModel garageModel = null");
         }
      }
      
      public function objectUnloaded(object:ClientObject) : void
      {
         Main.writeToConsole("Item3DModel objectUnloaded");
         this.clientObject = null;
      }
   }
}
