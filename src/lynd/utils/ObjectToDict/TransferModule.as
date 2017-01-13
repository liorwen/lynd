/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.utils.ObjectToDict
{
    import flash.utils.getQualifiedClassName;

    public class TransferModule implements ITransferModule
    {
        private var _next:ITransferModule;
        private var _rule:String;

        public function TransferModule(rule:String)
        {
            _rule = rule;
        }

        public function transfer(obj:*):*
        {
            if(getQualifiedClassName(obj) == _rule)
                return excute(obj);
            return _next.transfer(obj);
        }

        protected function excute(obj:*):*
        {
            return null;
        }

        public function next(transfer:ITransferModule):ITransferModule
        {
            _next = transfer;
            return this;
        }
    }
}
