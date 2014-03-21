using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace FinalWcfServiceLibrary
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IFinalService1" in both code and config file together.
    [ServiceContract]
    public interface IFinalService1
    {
        [OperationContract]
        string SayHelloWorld();
    }
}
