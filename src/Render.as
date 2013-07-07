package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class Render implements Component
    {
        private var _imgUri:String;
        private var _imgData:BitmapData;

        public function get imgUri():String
        {
            return _imgUri;
        }

        public function set imgUri(imgUri:String):void
        {
            if (imgUri == _imgUri)
                return;

            _imgUri = imgUri;
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
            loader.load(new URLRequest(imgUri));
        }

        private function onLoaded(event:Event):void
        {
            _imgData = Bitmap(LoaderInfo(event.target).content).bitmapData;
        }

        public function get imgData():BitmapData
        {
            return _imgData;
        }
    }
}
