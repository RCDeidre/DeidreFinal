using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Serialization;


namespace FinalClassLibrary
{
    public static class SerializeClass
    {
        public static void SerializeObjectToXML<T>(string filename, T obj)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(T));
            Stream stream = File.Open(filename, FileMode.Create);
            serializer.Serialize(stream, obj);
            stream.Close();
        }
        public static T DeserializeObjectFromXML<T>(string filename)
        {
            XmlSerializer deserializer = new XmlSerializer(typeof(T));
            Stream stream = File.Open(filename, FileMode.Open);
            T objectToBeSerialized = (T)deserializer.Deserialize(stream);
            stream.Close();
            return objectToBeSerialized;
        }
    }
}
