using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MidTermFinal.Cart
{
    internal class Orders
    {
        public int o_id { get; set; }
        public int cart_id { get; set; }
        public int p_id { get; set;}
        public int 硬度_id { get; set;}
        public int 鹹度_id { get; set; }

        public Decimal price { get; set; }
        public List<Addons_Order> AddonsOrder { get; set; } = new List<Addons_Order>();
    }
}
