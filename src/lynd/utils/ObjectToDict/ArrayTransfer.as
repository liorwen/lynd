/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.utils.ObjectToDict
{
    import flash.utils.Dictionary;

    public class ArrayTransfer extends TransferModule
    {
        public function ArrayTransfer()
        {
            super("Array");
        }


        override protected function excute(obj:*):*
        {
            var result:Dictionary = new Dictionary();
            var objectTransfer:ITransferModule = new ObjectTransfer().next(this);
            for (var index:String in obj)
            {
                result[index] = objectTransfer.transfer(obj[index]);
            }
            return result;
        }
    }
}
