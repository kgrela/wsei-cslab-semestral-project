using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace wsei_cslab_semestral_project
{
    /// <summary>
    /// Logika interakcji dla klasy AddMember.xaml
    /// </summary>
    public partial class AddMember : Window
    {
        public AddMember()
        {
            InitializeComponent();
        }

        AddMemberClass a = new AddMemberClass();

        private void btn_addMember_Click(object sender, RoutedEventArgs e)
        {
            Int32.TryParse(Input_ID.Text, out int id);
            Int32.TryParse(Input_Role.Text, out int role);

            a.ID = id;
            a.Name = Input_Name.Text;
            a.Surname = Input_Surname.Text;
            a.PESEL = Input_PESEL.Text;
            a.Email = Input_Email.Text;
            a.JoinDate = Input_JoinDate.Text;
            a.Role = role;

            bool success = a.Insert(a);
            if(success)
            {
                MessageBox.Show("Nowy członek został dodany!");
            }
            else
            {
                MessageBox.Show("Wystąpił błąd! Spróbuj ponownie...");
            }

        }

        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            MainWindow k = new MainWindow();
            k.Show();
            this.Close();
        }
    }
}
