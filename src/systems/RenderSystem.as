package
{
    import EntityManager;
    import Position;
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
            var positions:Vector.<Component> = entityManager.getAllComponentsOfType(Position);
            for each(var position:Position in positions)
                trace("updating position!");
        }
    }
}
