package systems
{
    import components.KeyControl;
    import components.Velocity;
    import EntityManager;
    import flash.display.Stage;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class InputSystem
    {
        private var entityManager:EntityManager;
        private var rightKeyDown:Boolean;
        private var leftKeyDown:Boolean;
        private var downKeyDown:Boolean;
        private var upKeyDown:Boolean;

        public function InputSystem(em:EntityManager, s:Stage)
        {
            entityManager = em;
            s.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            s.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        }

        public function update(deltaMs:int):void
        {
            var requiredComponents:Vector.<Class> = Vector.<Class>([KeyControl, Velocity]);
            var inputableEntities:Vector.<int> = entityManager.getAllEntitiesPossessingComponents(requiredComponents);

            reactToInput(inputableEntities);
        }

        private function reactToInput(entities:Vector.<int>):void
        {
            for each (var entity:int in entities)
                updateEntity(entity);
        }

        private function updateEntity(entity:int):void
        {
            var controls:KeyControl = KeyControl(entityManager.getComponent(entity, KeyControl));
            var velocity:Velocity = Velocity(entityManager.getComponent(entity, Velocity));

            if (leftKeyDown)
                velocity.x = -100;
            else if (rightKeyDown)
                velocity.x = 100;
            else
                velocity.x = 0;

            if (upKeyDown)
                velocity.y = -100;
            else if (downKeyDown)
                velocity.y = 100;
            else
                velocity.y = 0;
        }

        public function onKeyDown(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.LEFT)
                leftKeyDown = true;
            else if (event.keyCode == Keyboard.RIGHT)
                rightKeyDown = true;
            else if (event.keyCode == Keyboard.UP)
                upKeyDown = true;
            else if (event.keyCode == Keyboard.DOWN)
                downKeyDown = true;
        }

        public function onKeyUp(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.LEFT)
                leftKeyDown = false;
            else if (event.keyCode == Keyboard.RIGHT)
                rightKeyDown = false;
            else if (event.keyCode == Keyboard.UP)
                upKeyDown = false;
            else if (event.keyCode == Keyboard.DOWN)
                downKeyDown = false;
        }
    }
}
