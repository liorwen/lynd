/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.utils.ObjectToDict
{
    import flash.utils.Dictionary;

    public class ValueTransfer extends TransferModule
    {
        public function ValueTransfer()
        {
            super("");
        }

        override public function transfer(obj:*):*
        {
            return excute(obj);
        }

        override protected function excute(obj:*):*
        {
            var result:Dictionary = new Dictionary();
            result["stateValue"] = obj;
            return result;
        }
    }
}
