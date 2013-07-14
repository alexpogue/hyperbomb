package
{
    import flash.utils.Dictionary;
    import components.Component;

    public class EntityManager
    {
        private var lowestUnassignedEntityId:int = 1;
        private var allEntities:Vector.<int>;
        // dictionary of [componentType:Class, components:Dictionary[entity:int, comp:Component]]
        private var componentStores:Dictionary;

        public function EntityManager()
        {
            allEntities = new Vector.<int>();
            componentStores = new Dictionary();
        }

        public function getComponent(entity:int, componentType:Class):Component
        {
            var store:Dictionary = componentStores[componentType];

            var componentClassName:String = flash.utils.getQualifiedClassName(componentType);

            if (!store)
                throw new Error("GET FAIL: there are no entities with a Component of class: " + componentClassName);

            var result:Component = store[entity];
            if (!result)
                throw new Error("GET FAIL: " + entity + " does not possess Component of class: " + componentClassName);

            return result;
        }

        public function getAllEntitiesPossessingComponents(componentTypes:Vector.<Class>):Vector.<int>
        {
            var entityLists:Vector.<Vector.<int> > = new Vector.<Vector.<int> >();

            // get lists of entities containing each component
            for each (var componentType:Class in componentTypes)
                entityLists.push(getAllEntitiesPossessingComponent(componentType));

            var numComponentsInEntities:Dictionary = new Dictionary();

            // count the componentTypes that each entity contains
            for each (var entityList:Vector.<int> in entityLists)
            {
                for each (var entityFromList:int in entityList)
                {
                    if (!numComponentsInEntities[entityFromList])
                        numComponentsInEntities[entityFromList] = 0;

                    ++numComponentsInEntities[entityFromList];
                }
            }

            var ret:Vector.<int> = new Vector.<int>();

            // if entity contains all componentTypes, add to ret
            for (var entity:* in numComponentsInEntities)
            {
                if (numComponentsInEntities[entity] == componentTypes.length)
                    ret.push(int(entity));
            }

            return ret;
        }

        public function getAllEntitiesPossessingComponent(componentType:Class):Vector.<int>
        {
            return Vector.<int>(getEntitiesOrComponentsWithType(componentType, false));
        }

        public function getAllComponentsOfType(componentType:Class):Vector.<Component>
        {
            return Vector.<Component>(getEntitiesOrComponentsWithType(componentType, true));
        }

        private function getEntitiesOrComponentsWithType(componentType:Class, getComponents:Boolean):Array
        {
            var store:Dictionary = componentStores[componentType];
            var ret:Array = new Array();

            if (!store)
                return ret;

            for (var entity:* in store)
            {
                if (getComponents)
                {
                    var component:Component = Component(store[entity]);
                    ret.push(component);
                }
                else
                {
                    ret.push(int(entity));
                }
            }

            return ret;
        }

        public function addComponent(entity:int, component:Component):void
        {
            var componentType:Class = Object(component).constructor;
            var store:Dictionary = componentStores[componentType];

            if (!store)
            {
                store = new Dictionary();
                componentStores[componentType] = store;
            }

            store[entity] = component;
        }

        public function createEntity():int
        {
            var newId:int = generateNewEntityId();

            if (newId < 1)
            {
                // fatal error
                return 0;
            }

            allEntities.push(newId);
            return newId;
        }

        public function killEntity(entity:int):void
        {
            allEntities.splice(allEntities.indexOf(entity), 1);
        }

        public function generateNewEntityId():int
        {
            if (lowestUnassignedEntityId < int.MAX_VALUE)
                return lowestUnassignedEntityId++;

            for (var i:int = 1; i < int.MAX_VALUE; i++)
            {
                if (allEntities.indexOf(i) == -1)
                    return i;
            }

            throw new Error("ERROR: no available Entity IDs; too many entities!");
        }
    }
}
