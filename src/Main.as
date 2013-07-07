package
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import EntityManager;
    import RenderSystem;
    import Position;
    import Render;
    import flash.display.*;

    [Frame(factoryClass = 'Preloader')]
    public class Main extends Sprite
    {
        public function Main()
        {
            var entityManager:EntityManager = new EntityManager();
            trace(entityManager.createEntity());
            trace(entityManager.createEntity());
            trace(entityManager.createEntity());
            var targetEntity:int = entityManager.createEntity();
            trace(targetEntity + " <- target entity");
            trace(entityManager.createEntity());
            var targetEntity2:int = entityManager.createEntity();
            trace(targetEntity2 + " <- target entity 2");
            var position:Position = new Position();
            position.x = 10;
            position.y = 5;
            entityManager.addComponent(targetEntity, position);
            trace("added position to entity " + targetEntity + ", making more entities");
            trace(entityManager.createEntity());
            trace(entityManager.createEntity());
            var position2:Position = new Position();
            position2.x = 15;
            position2.y = 45;
            entityManager.addComponent(targetEntity2, position2);
            trace("added position to entity " + targetEntity2 + ", making more entities");
            trace(entityManager.createEntity());
            trace(entityManager.createEntity());
            trace("getting all entities with position...");
            var entities:Vector.<int> = entityManager.getAllEntitiesPossessingComponent(Position);
            for each (var entity:int in entities)
            {
                var positionOut:Position = Position(entityManager.getComponent(entity, Position));
                trace("entity " + entity + " has position (" + positionOut.x + ", " + positionOut.y + ")");
            }
            var renderSystem:RenderSystem = new RenderSystem(entityManager, this);
            renderSystem.update();
            var addedEntity:int = entityManager.createEntity();
            var position3:Position = new Position();
            position3.x = 100;
            position3.y = 200;
            entityManager.addComponent(addedEntity, position3);
            var render:Render = new Render();
            entityManager.addComponent(addedEntity, render);
            renderSystem.update();
            var necessaryComponents:Vector.<Class> = new Vector.<Class>();
            necessaryComponents.push(Position);
            necessaryComponents.push(Render);
            var entitiesWithComponents:Vector.<int> = entityManager.getAllEntitiesPossessingComponents(necessaryComponents);
            trace("HI!");
            for each (var e:int in entitiesWithComponents)
            {
                trace("entity " + e + " is renderable!");
            }
        }
    }
}
