using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace wsei_cslab_semestral_project
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }


        /// <summary>
        /// Function called when the btn_1 object is pressed
        /// </summary>
        private void btn_1_Click(object sender, RoutedEventArgs e)
        {
            AddMember k = new AddMember();
            k.Show();
            this.Close();
        }

        /// <summary>
        /// Function called when the btn_2 object is pressed
        /// </summary>
        private void btn_2_Click(object sender, RoutedEventArgs e)
        {
            AddAlarm k = new AddAlarm();
            k.Show();
            this.Close();
        
        }

        /// <summary>
        /// Function called when the btn_3 object is pressed
        /// </summary>
        private void btn_3_Click(object sender, RoutedEventArgs e)
        {
            UpdateEquipmentReview k = new UpdateEquipmentReview();
            k.Show();
            this.Close();
        }

    }
}
