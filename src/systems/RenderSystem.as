package systems
{
    import components.PixelPosition;
    import LevelInfo;
    import components.Render;
    import EntityManager;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.events.Event;

    public class RenderSystem
    {
        private var container:DisplayObjectContainer;
        private var entityManager:EntityManager;
        private var canvas:Bitmap

        public function RenderSystem(em:EntityManager, c:DisplayObjectContainer)
        {
            container = c;
            entityManager = em;
            canvas = new Bitmap(new BitmapData(LevelInfo.numPixelsWide, LevelInfo.numPixelsTall, false));

            container.addChild(canvas);
        }

        public function update(event:Event):void
        {
            var requiredComponents:Vector.<Class> = Vector.<Class>([PixelPosition, Render]);
            var renderableEntities:Vector.<int> = entityManager.getAllEntitiesPossessingComponents(requiredComponents);

            renderEntities(renderableEntities);
        }

        private function renderEntities(entities:Vector.<int>):void
        {
            for each (var entity:int in entities)
                renderEntity(entity);
        }

        private function renderEntity(entity:int):void
        {
            var position:PixelPosition = PixelPosition(entityManager.getComponent(entity, PixelPosition));
            var render:Render = Render(entityManager.getComponent(entity, Render));

            blitImage(position.x, position.y, render.imgData);
        }

        private function blitImage(x:int, y:int, imgData:BitmapData):void
        {
            if (!imgData)
                return;

            canvas.bitmapData.lock();
            canvas.bitmapData.copyPixels(imgData, imgData.rect, imgData.rect.topLeft);
            canvas.bitmapData.unlock();
        }
    }
}
