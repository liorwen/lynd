/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.utils.ObjectToDict
{
    import flash.utils.Dictionary;

    public class ObjectTransfer extends TransferModule
    {
        public function ObjectTransfer()
        {
            super("Object");
        }

        override protected function excute(obj:*):*
        {
            var result:Dictionary = new Dictionary();

            for (var key:String in obj)
            {
                result[key] = transfer(obj[key]);
            }

            return result;
        }
    }
}
