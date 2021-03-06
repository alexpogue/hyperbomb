package
{
    import components.KeyControl;
    import components.PixelPosition;
    import components.Render;
    import components.Velocity;
    import EntityManager;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;
    import LevelInfo;
    import systems.InputSystem;
    import systems.MoveSystem;
    import systems.RenderSystem;

    [Frame(factoryClass = 'Preloader')]
    public class Main extends Sprite
    {
        private var pastTime:int;
        private var renderSystem:RenderSystem;
        private var moveSystem:MoveSystem;
        private var inputSystem:InputSystem;

        public function Main()
        {
            if (!this.stage)
                this.addEventListener(Event.ADDED_TO_STAGE, init);
            else
                init();
        }

        private function init(event:Event = null):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, init);
            LevelInfo.numCellsTall = 10;
            LevelInfo.numCellsWide = 10;
            LevelInfo.cellWidth = 64;
            LevelInfo.cellHeight = 64;

            var entityManager:EntityManager = new EntityManager();
            renderSystem = new RenderSystem(entityManager, this);
            moveSystem = new MoveSystem(entityManager);
            inputSystem = new InputSystem(entityManager, this.stage);

            var entity:int = entityManager.createEntity();
            var position:PixelPosition = new PixelPosition();
            entityManager.addComponent(entity, position);
            position.x = 100;
            position.y = 200;

            var velocity:Velocity = new Velocity();
            entityManager.addComponent(entity, velocity);
            velocity.x = 100;
            velocity.y = 0;

            var render:Render = new Render();
            entityManager.addComponent(entity, render);
            render.imgUri = "../assets/Pixel-mario-small.gif";

            var controls:KeyControl = new KeyControl();
            entityManager.addComponent(entity, controls);

            var pastTime:int = getTimer();
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(e:Event):void
        {
            var presentTime:int = getTimer();
            var deltaTime:int = presentTime - pastTime;
            pastTime = presentTime;
            renderSystem.update(deltaTime);
            moveSystem.update(deltaTime);
            inputSystem.update(deltaTime);
        }
    }
}
