/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.utils.ObjectToDict
{
    public interface ITransferModule
    {
        function transfer(obj:*):*
        function next(transfer:ITransferModule):ITransferModule
    }
}
