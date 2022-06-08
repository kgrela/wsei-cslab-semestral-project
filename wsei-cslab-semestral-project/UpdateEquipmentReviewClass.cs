using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace wsei_cslab_semestral_project
{
    class UpdateEquipmentReviewClass
    {
        public int ID { get; set; }
        public string Date { get; set; }

        static string myconnstring = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

        public bool Update(UpdateEquipmentReviewClass a)
        {
            bool isSuccess = false;
            SqlConnection conn = new SqlConnection(myconnstring);
            try
            {
                string sql = "UPDATE Reviews SET deadline=@Date WHERE equipment_id=@ID";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@Date", a.Date);
                cmd.Parameters.AddWithValue("@ID", a.ID);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                if(rows>0)
                {
                    isSuccess = true;
                }
                else
                {
                    isSuccess = false;
                }
            }
            catch(Exception ex)
            {

            }
            finally
            {
                conn.Close();
            }
            return isSuccess;
        }
    }
}
