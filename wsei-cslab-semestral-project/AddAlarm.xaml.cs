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
    /// Logika interakcji dla klasy AddAlarm.xaml
    /// </summary>
    public partial class AddAlarm : Window
    {
        public AddAlarm()
        {
            InitializeComponent();
        }

        AddAlarmClass a = new AddAlarmClass();

        private void btn_addAlarm_Click_1(object sender, RoutedEventArgs e)
        {
            Int32.TryParse(Input_ID.Text, out int id);

            a.ID = id;
            a.Date = Input_Date.Text;
            a.Event = Input_Event.Text;
            a.Address = Input_Address.Text;

            bool success = a.Insert(a);
            if (success)
            {
                MessageBox.Show("Alarm został dodany!");
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
