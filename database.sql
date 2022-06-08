USE [master]
GO
/****** Object:  Database [STRAZ]    Script Date: 09.06.2022 00:30:56 ******/
CREATE DATABASE [STRAZ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'STRAZ', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\STRAZ.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'STRAZ_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\STRAZ_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [STRAZ] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [STRAZ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [STRAZ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [STRAZ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [STRAZ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [STRAZ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [STRAZ] SET ARITHABORT OFF 
GO
ALTER DATABASE [STRAZ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [STRAZ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [STRAZ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [STRAZ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [STRAZ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [STRAZ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [STRAZ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [STRAZ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [STRAZ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [STRAZ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [STRAZ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [STRAZ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [STRAZ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [STRAZ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [STRAZ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [STRAZ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [STRAZ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [STRAZ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [STRAZ] SET  MULTI_USER 
GO
ALTER DATABASE [STRAZ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [STRAZ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [STRAZ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [STRAZ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [STRAZ] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [STRAZ] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [STRAZ] SET QUERY_STORE = OFF
GO
USE [STRAZ]
GO
/****** Object:  UserDefinedFunction [dbo].[ShowMemberWhoJoinedOnThatDay]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ShowMemberWhoJoinedOnThatDay]
	(@f_date date)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @NameSurname varchar(50)
	SET @NameSurname = (SELECT name + ' ' + surname FROM Members WHERE join_date = @f_date)
	RETURN @NameSurname
END
GO
/****** Object:  Table [dbo].[Tests]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tests](
	[member_id] [int] NULL,
	[end_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[surname] [varchar](50) NOT NULL,
	[pesel] [varchar](50) NOT NULL,
	[email] [varchar](50) NULL,
	[join_date] [varchar](50) NOT NULL,
	[role] [int] NOT NULL,
 CONSTRAINT [PK_Czlonkowie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ShowMembersWithTests]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ShowMembersWithTests]
AS
SELECT        dbo.Members.name, dbo.Members.surname, dbo.Tests.end_date
FROM            dbo.Members INNER JOIN
                         dbo.Tests ON dbo.Members.id = dbo.Tests.member_id
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[equipment_id] [int] NOT NULL,
	[deadline] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ShowEquipmentWithReviewDates]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ShowEquipmentWithReviewDates]
AS
SELECT        TOP (100) PERCENT dbo.Equipment.name, dbo.Equipment.description, dbo.Reviews.deadline
FROM            dbo.Equipment INNER JOIN
                         dbo.Reviews ON dbo.Equipment.id = dbo.Reviews.equipment_id
ORDER BY dbo.Reviews.deadline
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] NOT NULL,
	[role_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ShowRolesWithMembersCount]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ShowRolesWithMembersCount]
AS
SELECT        dbo.Roles.role_name AS Funkcja, COUNT(dbo.Members.id) AS Liczebność
FROM            dbo.Roles INNER JOIN
                         dbo.Members ON dbo.Roles.role_id = dbo.Members.role
GROUP BY dbo.Roles.role_name
GO
/****** Object:  Table [dbo].[Donations]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[member_id] [int] NULL,
	[year] [int] NULL,
	[money] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ShowMembersWithoutDonation]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ShowMembersWithoutDonation]
AS
SELECT        dbo.Members.name, dbo.Members.surname
FROM            dbo.Members LEFT OUTER JOIN
                         dbo.Donations ON dbo.Members.id = dbo.Donations.member_id
WHERE        (dbo.Donations.year = YEAR(GETDATE())) AND (dbo.Donations.money IS NULL)
GO
/****** Object:  Table [dbo].[Alarms]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alarms](
	[id] [int] NOT NULL,
	[date] [varchar](50) NOT NULL,
	[event] [varchar](50) NOT NULL,
	[address] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ShowAlarmsForTheDate]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ShowAlarmsForTheDate]
	(@f_date date)
RETURNS TABLE
AS
RETURN
	SELECT * FROM Alarms WHERE date = @f_date
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[member_id] [int] NOT NULL,
	[course_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses_list]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses_list](
	[course_id] [int] NOT NULL,
	[course_name] [varchar](50) NULL,
 CONSTRAINT [PK_Courses_list] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ShowCoursesOfMember]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ShowCoursesOfMember]
	(@f_id int)
RETURNS TABLE
AS
RETURN
	SELECT course_name FROM Courses_list
	INNER JOIN Courses AS c ON c.course_id = Courses_list.course_id
	INNER JOIN Members AS m ON m.id = c.member_id
	WHERE m.id = @f_id
GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[id] [int] NOT NULL,
	[manufacturer] [varchar](50) NOT NULL,
	[model] [varchar](50) NOT NULL,
	[bodybuilder] [varchar](50) NOT NULL,
	[code_name] [varchar](50) NOT NULL,
	[mark] [varchar](50) NOT NULL,
	[registration_number] [varchar](50) NOT NULL,
	[review] [date] NOT NULL,
	[reservoir] [int] NULL,
 CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ShowVehiclesByMark]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ShowVehiclesByMark]
	(@f_mark varchar(50))
RETURNS TABLE
AS
RETURN
	SELECT * FROM Vehicles WHERE mark = @f_mark
GO
/****** Object:  StoredProcedure [dbo].[AddAlarm]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAlarm](
	@f_id INT,
	@f_date date,
	@f_event varchar(50),
	@f_address varchar(50))
AS
BEGIN
INSERT Alarms
VALUES (@f_id, @f_date, @f_event, @f_address)
END
GO
/****** Object:  StoredProcedure [dbo].[AddMember]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddMember](
	@f_id INT,
	@f_name varchar(50),
	@f_surname varchar(50),
	@f_pesel int,
	@f_email varchar(50),
	@f_join_date date,
	@f_role int)
AS
BEGIN
INSERT Members
VALUES (@f_id, @f_name, @f_surname, @f_pesel, @f_email, @f_join_date, @f_role)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateReviewDeadline]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateReviewDeadline](
	@f_id int,
	@f_deadline date)
AS
BEGIN
UPDATE Reviews SET deadline = @f_deadline WHERE equipment_id = @f_id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateVehicleReview]    Script Date: 09.06.2022 00:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateVehicleReview](
	@f_numberplate varchar(50),
	@f_review date)
AS
BEGIN
UPDATE Vehicles SET review = @f_review WHERE registration_number = @f_numberplate
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Equipment"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 185
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Reviews"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 160
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowEquipmentWithReviewDates'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowEquipmentWithReviewDates'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Members"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 221
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Donations"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 205
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowMembersWithoutDonation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowMembersWithoutDonation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Members"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 191
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tests"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 189
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowMembersWithTests'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowMembersWithTests'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Roles"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 239
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Members"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 240
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowRolesWithMembersCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ShowRolesWithMembersCount'
GO
USE [master]
GO
ALTER DATABASE [STRAZ] SET  READ_WRITE 
GO
