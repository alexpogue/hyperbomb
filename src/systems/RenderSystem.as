package systems
{
    import EntityManager;
    import components.PixelPosition;
    import components.Component;
    import flash.display.DisplayObjectContainer;

    public class RenderSystem
    {
        private var container:DisplayObjectContainer;
        private var entityManager:EntityManager;

        public function RenderSystem(em:EntityManager, c:DisplayObjectContainer)
        {
            container = c;
            entityManager = em;
        }

        public function update():void
        {
            var positions:Vector.<Component> = entityManager.getAllComponentsOfType(PixelPosition);
            for each(var position:PixelPosition in positions)
                trace("updating position!");
        }
    }
}
