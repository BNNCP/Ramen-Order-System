using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MidTermFinal
{
    internal class GlobalConnection
    {
        public static string strMyDBConnectionsString = "";
        public static string image_dir = @".";
        public static int Authority;
        public static int UserID;
        public static Decimal TotalCart;


        public List<GlobalProduct> Products { get; set; } = new List<GlobalProduct>();
    }
}
