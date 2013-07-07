package components
{
    import flash.display.BitmapData;
    import utils.ImageManager;

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
            _imgData = ImageManager.getImage(imgUri);
        }

        public function get imgData():BitmapData
        {
            return _imgData;
        }
    }
}
