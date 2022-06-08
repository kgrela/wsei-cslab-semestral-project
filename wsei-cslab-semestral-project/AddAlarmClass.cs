using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace wsei_cslab_semestral_project
{
    class AddAlarmClass
    {

        public int ID { get; set; }
        public string Date { get; set; }
        public string Event { get; set; }
        public string Address { get; set; }

        static string myconnstring = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

        /// <summary>
        /// Function tries to insert a new row into Alarms table in database
        /// </summary>
        /// <param name="a"></param>
        /// <returns></returns>
        public bool Insert(AddAlarmClass a)
        {
            bool isSuccess = false;

            SqlConnection conn = new SqlConnection(myconnstring);
            try
            {
                string sql = "INSERT INTO Alarms (id, date, event, address) VALUES (@ID, @Date, @Event, @Address)";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@ID", a.ID);
                cmd.Parameters.AddWithValue("@Date", a.Date);
                cmd.Parameters.AddWithValue("@Event", a.Event);
                cmd.Parameters.AddWithValue("@Address", a.Address);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    isSuccess = true;
                }
                else
                {
                    isSuccess = false;
                }
            }
            catch (Exception ex)
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
