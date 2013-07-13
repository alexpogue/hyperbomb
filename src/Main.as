package
{
    import components.PixelPosition;
    import components.Render;
    import EntityManager;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import systems.RenderSystem;

    [Frame(factoryClass = 'Preloader')]
    public class Main extends Sprite
    {
        public function Main()
        {
            var entityManager:EntityManager = new EntityManager();
            var renderSystem:RenderSystem = new RenderSystem(entityManager, this);

            var entity:int = entityManager.createEntity();
            var position:PixelPosition = new PixelPosition();
            entityManager.addComponent(entity, position);
            position.x = 100;
            position.y = 200;

            var render:Render = new Render();
            entityManager.addComponent(entity, render);
            render.imgUri = "../assets/Pixel-mario-small.gif";

            addEventListener(Event.ENTER_FRAME, renderSystem.update);
        }
    }
}
