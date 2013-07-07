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

        public static function getImage(uri:String):BitmapData
        {
            if (images[uri])
                return images[uri];

            var functionOnLoaded:Function = onLoaded(uri);
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, functionOnLoaded);
            loader.load(new URLRequest(uri));

            return images[uri];
        }

        private static function onLoaded(imageUri:String):Function
        {
            return function(event:Event):void
            {
                images[imageUri] = Bitmap(LoaderInfo(event.target).content).bitmapData;
            }
        }
    }
}
