using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace FinalClassLibrary
{
    [Serializable]
    public class SalesList
    {
        public List<ItemSales> Sales { get; private set; }

        public SalesList()
        {
            Sales = new List<ItemSales>();
        }


        public void Add(ItemSales sale)
        {
            bool isInList = false;

            foreach (ItemSales s in Sales)
            {
                if (sale.item == s.item)
                {
                    s.Quantity++;
                    isInList = true;
                }
            }

            if (!isInList)
            {
                Sales.Add(sale);
            }
        }

        public void Remove(ItemSales sale)
        {
            bool isInList = true;

            foreach (ItemSales s in Sales)
            {
                if (sale.item == s.item)
                {
                    s.Quantity--;
                    isInList = false;
                }
            }

            if (!isInList)
            {
                Sales.Remove(sale);
            }
        }
    }

}

