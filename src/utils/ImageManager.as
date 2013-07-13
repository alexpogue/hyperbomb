package utils
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    public class ImageManager
    {
        private static var images:Dictionary;

        public static function isImageLoaded(uri:String):Boolean
        {
            return (images[uri]) ? (true) : (false);
        }

        public static function getImage(uri:String, callback:Function):BitmapData
        {
            return (images && images[uri]) ? (images[uri]) : (null);
        }

        public static function loadImage(uri:String, callback:Function):void
        {
            if (!images)
                images = new Dictionary();

            if (images[uri])
            {
                callback(uri);
                return;
            }

            var loader:Loader = new Loader();

            var onLoadedFunction:Function = onLoaded(uri, callback);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedFunction);
            loader.load(new URLRequest(uri));
        }

        private static function onLoaded(imageUri:String, callback:Function):Function
        {
            return function(event:Event):void
            {
                images[imageUri] = Bitmap(LoaderInfo(event.target).content).bitmapData;
                event.currentTarget.removeEventListener(event.type, arguments.callee);
                callback(imageUri);
            }
        }
    }
}
