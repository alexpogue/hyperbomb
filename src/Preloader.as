package
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.ProgressEvent;
    import flash.utils.getDefinitionByName;

    public class Preloader extends MovieClip
    {
        public function Preloader()
        {
            trace("Preloading!");
            this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
        }

        private function onProgress(e:ProgressEvent):void
        {
            var percent:Number = Math.round(e.bytesLoaded / e.bytesTotal * 100);
            if(percent == 100)
            {
                this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
                onLoaded();
            }
        }
        private function onLoaded():void
        {
            nextFrame(); // go to next frame
            var App:Class = getDefinitionByName("Main") as Class; // class of your app
            addChild(new App() as DisplayObject);
        }
    }
}
