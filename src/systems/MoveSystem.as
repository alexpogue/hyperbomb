package systems
{
    import components.PixelPosition;
    import components.Velocity;
    import EntityManager;

    public class MoveSystem
    {
        private var entityManager:EntityManager;

        public function MoveSystem(em:EntityManager)
        {
            entityManager = em;
        }

        public function update(deltaMs:int):void
        {
            var requiredComponents:Vector.<Class> = Vector.<Class>([PixelPosition, Velocity]);
            var movableEntities:Vector.<int> = entityManager.getAllEntitiesPossessingComponents(requiredComponents);

            moveEntities(movableEntities, deltaMs);
        }

        private function moveEntities(entities:Vector.<int>, deltaMs:int):void
        {
            for each (var entity:int in entities)
                moveEntity(entity, deltaMs);
        }

        private function moveEntity(entity:int, deltaMs:int):void
        {
            var position:PixelPosition = PixelPosition(entityManager.getComponent(entity, PixelPosition));
            var velocity:Velocity = Velocity(entityManager.getComponent(entity, Velocity));

            position.x += velocity.x * deltaMs * 0.001;
            position.y += velocity.y * deltaMs * 0.001;
        }
    }
}
