using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using DAL_Project;

namespace FinalClassLibrary
{
    [Serializable]
    public class ItemSales
    {
        private int _quantity;
        public string item { get; set; }
        public double Price { get; set; }

        public int Quantity
        {
            get { return _quantity; }
            set
            {
                _quantity = value;
                SubTotalPrice = _quantity * Price;
            }
        }

        public double SubTotalPrice { get; set; }


        public ItemSales(string Item, double price)
        {
            Quantity = 1;
            Item = item;
            Price = price;
        }

        public ItemSales(string Item)
        {
            Quantity = 1;
            Item = item;
            Price = 40.00;
        }

        public ItemSales()
        {
            Quantity = 0;
            item = "White";
            Price = 40.00;
        }


        public void SaveToDatabase(string clientId)
        {
            //have to do this
        }
    }
}
