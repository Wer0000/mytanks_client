package alternativa.tanks.models.battlefield.gamemode
{
   import alternativa.tanks.model.panel.IBattleSettings;
   import alternativa.tanks.models.battlefield.BattleView3D;
   import flash.display.BitmapData;
   
   public interface IGameMode
   {
       
      
      function applyChanges(param1:BattleView3D) : void;
      
      function applyChangesBeforeSettings(param1:IBattleSettings) : void;
      
      function applyColorchangesToSkybox(param1:BitmapData) : BitmapData;
   }
}
