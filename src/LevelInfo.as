package
{
    public class LevelInfo
    {
        public static var numCellsTall:int;
        public static var numCellsWide:int;
        public static var cellWidth:int;
        public static var cellHeight:int;

        public static function get numPixelsTall():int
        {
            return numCellsTall * cellHeight;
        }

        public static function get numPixelsWide():int
        {
            return numCellsWide * cellWidth;
        }
    }
}
