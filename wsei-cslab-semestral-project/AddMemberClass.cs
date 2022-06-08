using System;
using System.Collections.Generic;
using System.Configuration;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace wsei_cslab_semestral_project
{
    class AddMemberClass
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public int PESEL { get; set; }
        public string Email { get; set; }
        public string JoinDate { get; set; }
        public int Role { get; set; }

        static string myconnstring = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

        public bool Insert(AddMemberClass a)
        {
            bool isSuccess = false;

            SqlConnection conn = new SqlConnection(myconnstring);
            try
            {
                string sql = "INSERT INTO Members (id, name, surname, pesel, email, join_date, role) VALUES (@ID, @Name, @Surname, @PESEL, @Email, @JoinDate, @Role)";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@ID", a.ID);
                cmd.Parameters.AddWithValue("@Name", a.Name);
                cmd.Parameters.AddWithValue("@Surname", a.Surname);
                cmd.Parameters.AddWithValue("@PESEL", a.PESEL);
                cmd.Parameters.AddWithValue("@Email", a.Email);
                cmd.Parameters.AddWithValue("@JoinDate", a.JoinDate);
                cmd.Parameters.AddWithValue("@Role", a.Role);

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
