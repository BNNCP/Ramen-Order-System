using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MidTermFinal.Cart
{
    internal class CartBox
    {
        public List<Orders> RamenOrder { get; set; } = new List<Orders>();
        public int cart_id { get; set; }
        public int c_id { get; set; }
        public int cart_salesdate { get; set; }
    }
}
