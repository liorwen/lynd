/**
 * Created by zear19st on 2016/12/20.
 */
package lynd.mutations
{
    public interface IMutationCore
    {
        function commit(type:String, ...args):void;
    }
}
