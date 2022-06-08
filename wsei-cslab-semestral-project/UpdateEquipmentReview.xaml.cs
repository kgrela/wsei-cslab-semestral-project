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
    /// Logika interakcji dla klasy UpdateEquipmentReview.xaml
    /// </summary>
    public partial class UpdateEquipmentReview : Window
    {
        public UpdateEquipmentReview()
        {
            InitializeComponent();
        }

        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            MainWindow k = new MainWindow();
            k.Show();
            this.Close();
        }

        UpdateEquipmentReviewClass a = new UpdateEquipmentReviewClass();

        private void btn_addMember_Click(object sender, RoutedEventArgs e)
        {
            Int32.TryParse(Input_ID.Text, out int id);
            a.ID = id;
            a.Date = Input_Date.Text;

            bool success = a.Update(a);
            if (success)
            {
                MessageBox.Show("Termin badania sprzętu został zaaktualizowany!");
            }
            else
            {
                MessageBox.Show("Wystąpił błąd! Spróbuj ponownie...");
            }

        }
    }
}
