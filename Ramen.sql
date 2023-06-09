USE [master]
GO
/****** Object:  Database [Ramen]    Script Date: 2023/2/14 下午 04:33:06 ******/
CREATE DATABASE [Ramen]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ramen', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Ramen.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Ramen_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Ramen_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Ramen] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ramen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ramen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ramen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ramen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ramen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ramen] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ramen] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Ramen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ramen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ramen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ramen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ramen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ramen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ramen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ramen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ramen] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Ramen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ramen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ramen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ramen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ramen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ramen] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ramen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ramen] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Ramen] SET  MULTI_USER 
GO
ALTER DATABASE [Ramen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ramen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Ramen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Ramen] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Ramen] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Ramen] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Ramen', N'ON'
GO
ALTER DATABASE [Ramen] SET QUERY_STORE = OFF
GO
USE [Ramen]
GO
/****** Object:  Table [dbo].[Addon Recipe]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addon Recipe](
	[ar_id] [int] IDENTITY(1,1) NOT NULL,
	[a_id] [int] NULL,
	[i_id] [int] NULL,
	[ar_quantity] [decimal](18, 0) NULL,
 CONSTRAINT [PK__Addon Re__36FC454693A083C1] PRIMARY KEY CLUSTERED 
(
	[ar_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addons]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addons](
	[a_id] [int] IDENTITY(1,1) NOT NULL,
	[a_name] [nvarchar](50) NULL,
	[a_price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Addons] PRIMARY KEY CLUSTERED 
(
	[a_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addons Order]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addons Order](
	[ao_id] [int] IDENTITY(1,1) NOT NULL,
	[o_id] [int] NULL,
	[a_id] [int] NULL,
	[ao_quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ao_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[att_id] [int] IDENTITY(1,1) NOT NULL,
	[e_id] [int] NULL,
	[onduty] [datetime] NULL,
	[offduty] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authority]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authority](
	[a_id] [int] IDENTITY(1,1) NOT NULL,
	[a_desc] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[a_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[c_id] [int] NULL,
	[cart_salesdate] [date] NULL,
 CONSTRAINT [PK__Cart__2EF52A2720758236] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[c_id] [int] IDENTITY(1,1) NOT NULL,
	[c_name] [nvarchar](50) NULL,
	[c_contact] [nvarchar](10) NULL,
	[c_birthday] [date] NULL,
	[c_address] [nvarchar](100) NULL,
	[a_id] [int] NULL,
	[account] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[c_email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Customer__213EE774F3A4B32E] PRIMARY KEY CLUSTERED 
(
	[c_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[e_id] [int] IDENTITY(1,1) NOT NULL,
	[e_name] [nvarchar](50) NULL,
	[t_id] [int] NULL,
	[e_address] [nvarchar](100) NULL,
	[e_hiredate] [date] NULL,
	[e_contact] [nvarchar](10) NULL,
	[e_birthday] [date] NULL,
	[a_id] [int] NULL,
	[account] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[e_email] [nvarchar](50) NOT NULL,
	[e_note] [nvarchar](100) NULL,
 CONSTRAINT [PK__Employee__3E2ED64A0BA0D109] PRIMARY KEY CLUSTERED 
(
	[e_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredients]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredients](
	[i_id] [int] IDENTITY(1,1) NOT NULL,
	[i_name] [nvarchar](20) NULL,
	[i_cost] [decimal](18, 0) NULL,
	[i_quantity] [decimal](18, 0) NULL,
	[單位] [nvarchar](10) NULL,
	[sup_id] [int] NULL,
 CONSTRAINT [PK__Ingredie__98F919BA7DB4B9BF] PRIMARY KEY CLUSTERED 
(
	[i_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[o_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NULL,
	[p_id] [int] NULL,
	[硬度_id] [int] NULL,
	[鹹度_id] [int] NULL,
 CONSTRAINT [PK__Orders__904BC20ECA5965A0] PRIMARY KEY CLUSTERED 
(
	[o_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[p_name] [nvarchar](50) NULL,
	[p_price] [decimal](18, 0) NULL,
	[p_description] [nvarchar](500) NULL,
	[p_picture] [nvarchar](20) NULL,
 CONSTRAINT [PK__Products__82E06B91D06D8398] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[r_id] [int] IDENTITY(1,1) NOT NULL,
	[p_id] [int] NULL,
	[i_id] [int] NULL,
	[r_quantity] [decimal](18, 0) NULL,
 CONSTRAINT [PK__Recipe__C47623276568D491] PRIMARY KEY CLUSTERED 
(
	[r_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[sup_id] [int] IDENTITY(1,1) NOT NULL,
	[sup_name] [nvarchar](50) NULL,
	[sup_company] [nvarchar](100) NULL,
	[sup_title] [nvarchar](20) NULL,
	[sup_contact] [nvarchar](10) NULL,
	[sup_address] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[sup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Title]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Title](
	[t_id] [int] IDENTITY(1,1) NOT NULL,
	[t_title] [nvarchar](50) NULL,
	[t_salaray] [decimal](18, 0) NULL,
 CONSTRAINT [PK__Title__E579775F5C2CC690] PRIMARY KEY CLUSTERED 
(
	[t_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[硬度]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[硬度](
	[硬度_id] [int] IDENTITY(1,1) NOT NULL,
	[硬度_desc] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[硬度_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[鹹度]    Script Date: 2023/2/14 下午 04:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[鹹度](
	[鹹度_id] [int] IDENTITY(1,1) NOT NULL,
	[鹹度_desc] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[鹹度_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Addon Recipe] ON 

INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (1, 1, 1, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (2, 2, 2, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (3, 3, 3, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (4, 3, 7, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (5, 4, 4, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (6, 5, 6, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (7, 5, 7, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (8, 5, 18, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (9, 5, 19, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (10, 5, 20, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Addon Recipe] ([ar_id], [a_id], [i_id], [ar_quantity]) VALUES (11, 6, 5, CAST(1 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Addon Recipe] OFF
GO
SET IDENTITY_INSERT [dbo].[Addons] ON 

INSERT [dbo].[Addons] ([a_id], [a_name], [a_price]) VALUES (1, N'加麵', CAST(10 AS Decimal(18, 0)))
INSERT [dbo].[Addons] ([a_id], [a_name], [a_price]) VALUES (2, N'白飯', CAST(10 AS Decimal(18, 0)))
INSERT [dbo].[Addons] ([a_id], [a_name], [a_price]) VALUES (3, N'叉燒', CAST(50 AS Decimal(18, 0)))
INSERT [dbo].[Addons] ([a_id], [a_name], [a_price]) VALUES (4, N'海苔', CAST(15 AS Decimal(18, 0)))
INSERT [dbo].[Addons] ([a_id], [a_name], [a_price]) VALUES (5, N'糖心蛋', CAST(15 AS Decimal(18, 0)))
INSERT [dbo].[Addons] ([a_id], [a_name], [a_price]) VALUES (6, N'菠菜', CAST(15 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Addons] OFF
GO
SET IDENTITY_INSERT [dbo].[Addons Order] ON 

INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (39, 25, 1, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (40, 28, 1, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (41, 28, 4, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (42, 29, 3, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (43, 29, 4, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (44, 30, 3, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (45, 30, 4, 1)
INSERT [dbo].[Addons Order] ([ao_id], [o_id], [a_id], [ao_quantity]) VALUES (46, 30, 5, 1)
SET IDENTITY_INSERT [dbo].[Addons Order] OFF
GO
SET IDENTITY_INSERT [dbo].[Attendance] ON 

INSERT [dbo].[Attendance] ([att_id], [e_id], [onduty], [offduty]) VALUES (3, 3, CAST(N'2023-02-13T08:58:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Attendance] OFF
GO
SET IDENTITY_INSERT [dbo].[Authority] ON 

INSERT [dbo].[Authority] ([a_id], [a_desc]) VALUES (1, N'一般會員')
INSERT [dbo].[Authority] ([a_id], [a_desc]) VALUES (2, N'黑名單')
INSERT [dbo].[Authority] ([a_id], [a_desc]) VALUES (3, N'停權')
INSERT [dbo].[Authority] ([a_id], [a_desc]) VALUES (4, N'神')
INSERT [dbo].[Authority] ([a_id], [a_desc]) VALUES (5, N'勞工')
SET IDENTITY_INSERT [dbo].[Authority] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([cart_id], [c_id], [cart_salesdate]) VALUES (37, 1, CAST(N'2023-02-14' AS Date))
INSERT [dbo].[Cart] ([cart_id], [c_id], [cart_salesdate]) VALUES (38, 1, CAST(N'2023-02-14' AS Date))
INSERT [dbo].[Cart] ([cart_id], [c_id], [cart_salesdate]) VALUES (39, 2, CAST(N'2023-02-14' AS Date))
INSERT [dbo].[Cart] ([cart_id], [c_id], [cart_salesdate]) VALUES (40, 1, CAST(N'2023-02-14' AS Date))
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([c_id], [c_name], [c_contact], [c_birthday], [c_address], [a_id], [account], [password], [c_email]) VALUES (1, N'張大大', N'0939787666', CAST(N'1999-07-06' AS Date), N'高雄市大寮區', 1, N'zzzz', N'zzzz', N'zzzz@gmail.com')
INSERT [dbo].[Customer] ([c_id], [c_name], [c_contact], [c_birthday], [c_address], [a_id], [account], [password], [c_email]) VALUES (2, N'王小小', N'0966553224', CAST(N'1998-08-06' AS Date), N'高雄市鳳山區', 1, N'xxxx', N'xxxx', N'xxxx@gmail.com')
INSERT [dbo].[Customer] ([c_id], [c_name], [c_contact], [c_birthday], [c_address], [a_id], [account], [password], [c_email]) VALUES (3, N'陳貓貓', N'0988653222', CAST(N'1995-07-24' AS Date), N'高雄市仁武區', NULL, N'cccc', N'cccc', N'cccc@gmail.com')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([e_id], [e_name], [t_id], [e_address], [e_hiredate], [e_contact], [e_birthday], [a_id], [account], [password], [e_email], [e_note]) VALUES (1, N'張秉中', 1, N'高雄市大寮區', CAST(N'2006-07-09' AS Date), N'0979181732', CAST(N'1999-08-10' AS Date), 4, N'1111', N'1111', N'1111@gmai.com', N'最高權限者')
INSERT [dbo].[Employee] ([e_id], [e_name], [t_id], [e_address], [e_hiredate], [e_contact], [e_birthday], [a_id], [account], [password], [e_email], [e_note]) VALUES (3, N'張勞工', 2, N'高雄市鼓山區', CAST(N'2023-02-01' AS Date), N'0966553554', CAST(N'2005-08-07' AS Date), 5, N'2222', N'2222', N'2222@gmail.com', N'被剝削者')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Ingredients] ON 

INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (1, N'麵粉', CAST(1 AS Decimal(18, 0)), CAST(82 AS Decimal(18, 0)), N'公斤', 1)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (2, N'白米', CAST(1 AS Decimal(18, 0)), CAST(99 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (3, N'豬肉', CAST(10 AS Decimal(18, 0)), CAST(78 AS Decimal(18, 0)), N'公斤', 2)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (4, N'海苔', CAST(5 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (5, N'菠菜', CAST(10 AS Decimal(18, 0)), CAST(47 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (6, N'蛋', CAST(15 AS Decimal(18, 0)), CAST(45 AS Decimal(18, 0)), N'公斤', 2)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (7, N'醬油', CAST(20 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (8, N'豬骨', CAST(5 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 2)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (9, N'豬背脂', CAST(5 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), N'公斤', 2)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (10, N'火腿', CAST(10 AS Decimal(18, 0)), CAST(40 AS Decimal(18, 0)), N'公斤', 2)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (11, N'青蔥', CAST(3 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (12, N'洋蔥', CAST(5 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (13, N'蒜頭', CAST(7 AS Decimal(18, 0)), CAST(40 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (14, N'小魚乾', CAST(5 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (15, N'雞骨', CAST(5 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 2)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (16, N'白蘿蔔', CAST(7 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (17, N'紅蘿蔔', CAST(7 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), N'公斤', 3)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (18, N'味醂', CAST(20 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (19, N'清酒', CAST(20 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (20, N'七味粉', CAST(20 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (21, N'鹽', CAST(20 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (22, N'柴魚片', CAST(10 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), N'公斤', 4)
INSERT [dbo].[Ingredients] ([i_id], [i_name], [i_cost], [i_quantity], [單位], [sup_id]) VALUES (23, N'昆布', CAST(10 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), N'公斤', 4)
SET IDENTITY_INSERT [dbo].[Ingredients] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([o_id], [cart_id], [p_id], [硬度_id], [鹹度_id]) VALUES (25, 37, 1, 4, 3)
INSERT [dbo].[Orders] ([o_id], [cart_id], [p_id], [硬度_id], [鹹度_id]) VALUES (26, 38, 2, 2, 4)
INSERT [dbo].[Orders] ([o_id], [cart_id], [p_id], [硬度_id], [鹹度_id]) VALUES (27, 38, 1, 3, 2)
INSERT [dbo].[Orders] ([o_id], [cart_id], [p_id], [硬度_id], [鹹度_id]) VALUES (28, 39, 1, 3, 4)
INSERT [dbo].[Orders] ([o_id], [cart_id], [p_id], [硬度_id], [鹹度_id]) VALUES (29, 39, 2, 3, 4)
INSERT [dbo].[Orders] ([o_id], [cart_id], [p_id], [硬度_id], [鹹度_id]) VALUES (30, 40, 1, 4, 3)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([p_id], [p_name], [p_price], [p_description], [p_picture]) VALUES (1, N'豚骨拉麵', CAST(120 AS Decimal(18, 0)), N'濃厚系列的最佳選擇', N'豚骨拉麵.jpg')
INSERT [dbo].[Products] ([p_id], [p_name], [p_price], [p_description], [p_picture]) VALUES (2, N'雞白湯拉麵', CAST(160 AS Decimal(18, 0)), N'以雞作為湯底的濃厚細拉麵', N'雞白湯拉麵.jpg')
INSERT [dbo].[Products] ([p_id], [p_name], [p_price], [p_description], [p_picture]) VALUES (3, N'魚介拉麵', CAST(140 AS Decimal(18, 0)), N'在濃厚湯底尋求極致鮮味', N'魚介拉麵.png')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Recipe] ON 

INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (1, 1, 1, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (2, 1, 3, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (3, 1, 4, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (4, 1, 5, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (5, 1, 6, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (6, 1, 7, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (7, 1, 8, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (8, 1, 9, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (9, 1, 10, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (10, 1, 11, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (11, 1, 12, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (12, 1, 13, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (13, 1, 16, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (14, 1, 17, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (15, 1, 18, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (16, 1, 19, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (17, 1, 20, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (18, 1, 21, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (19, 1, 22, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (20, 1, 23, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (21, 2, 1, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (22, 2, 3, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (23, 2, 4, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (24, 2, 5, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (25, 2, 6, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (28, 2, 7, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (29, 2, 8, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (30, 2, 10, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (31, 2, 11, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (32, 2, 12, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (33, 2, 13, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (34, 2, 14, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (35, 2, 15, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (36, 2, 16, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (37, 2, 17, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (38, 2, 18, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (39, 2, 19, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (40, 2, 20, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (41, 2, 21, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (42, 2, 22, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (43, 2, 23, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (44, 3, 1, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (45, 3, 3, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (46, 3, 4, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (47, 3, 5, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (48, 3, 6, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (49, 3, 7, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (50, 3, 8, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (51, 3, 10, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (52, 3, 11, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (53, 3, 12, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (54, 3, 13, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (55, 3, 14, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (56, 3, 16, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (57, 3, 17, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (58, 3, 18, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (59, 3, 19, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (60, 3, 20, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (61, 3, 21, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (62, 3, 22, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (63, 3, 23, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Recipe] ([r_id], [p_id], [i_id], [r_quantity]) VALUES (64, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Recipe] OFF
GO
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([sup_id], [sup_name], [sup_company], [sup_title], [sup_contact], [sup_address]) VALUES (1, N'王羅根', N'麵點王有限公司', N'產品經理', N'0988633655', N'高雄市鼓山區')
INSERT [dbo].[Supplier] ([sup_id], [sup_name], [sup_company], [sup_title], [sup_contact], [sup_address]) VALUES (2, N'王建民', N'養雞養豬農場', N'董事長', N'0977888777', N'屏東縣萬丹鄉')
INSERT [dbo].[Supplier] ([sup_id], [sup_name], [sup_company], [sup_title], [sup_contact], [sup_address]) VALUES (3, N'韓國瑜', N'菜農園區', N'銷售主管', N'0955333222', N'高雄市前金區')
INSERT [dbo].[Supplier] ([sup_id], [sup_name], [sup_company], [sup_title], [sup_contact], [sup_address]) VALUES (4, N'陳大賣', N'超級大賣場', N'銷售經理', N'0911222555', N'高雄市三民區')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
GO
SET IDENTITY_INSERT [dbo].[Title] ON 

INSERT [dbo].[Title] ([t_id], [t_title], [t_salaray]) VALUES (1, N'店長', CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[Title] ([t_id], [t_title], [t_salaray]) VALUES (2, N'員工', CAST(28000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Title] OFF
GO
SET IDENTITY_INSERT [dbo].[硬度] ON 

INSERT [dbo].[硬度] ([硬度_id], [硬度_desc]) VALUES (1, N'軟')
INSERT [dbo].[硬度] ([硬度_id], [硬度_desc]) VALUES (2, N'適中')
INSERT [dbo].[硬度] ([硬度_id], [硬度_desc]) VALUES (3, N'硬')
INSERT [dbo].[硬度] ([硬度_id], [硬度_desc]) VALUES (4, N'超硬')
SET IDENTITY_INSERT [dbo].[硬度] OFF
GO
SET IDENTITY_INSERT [dbo].[鹹度] ON 

INSERT [dbo].[鹹度] ([鹹度_id], [鹹度_desc]) VALUES (1, N'清淡')
INSERT [dbo].[鹹度] ([鹹度_id], [鹹度_desc]) VALUES (2, N'適中')
INSERT [dbo].[鹹度] ([鹹度_id], [鹹度_desc]) VALUES (3, N'濃厚')
INSERT [dbo].[鹹度] ([鹹度_id], [鹹度_desc]) VALUES (4, N'日本味')
SET IDENTITY_INSERT [dbo].[鹹度] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Customer]    Script Date: 2023/2/14 下午 04:33:07 ******/
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [IX_Customer] UNIQUE NONCLUSTERED 
(
	[c_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Customer_1]    Script Date: 2023/2/14 下午 04:33:07 ******/
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [IX_Customer_1] UNIQUE NONCLUSTERED 
(
	[account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employee]    Script Date: 2023/2/14 下午 04:33:07 ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [IX_Employee] UNIQUE NONCLUSTERED 
(
	[e_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employee_1]    Script Date: 2023/2/14 下午 04:33:07 ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [IX_Employee_1] UNIQUE NONCLUSTERED 
(
	[account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addon Recipe]  WITH CHECK ADD  CONSTRAINT [FK__Addon Reci__a_id__17036CC0] FOREIGN KEY([a_id])
REFERENCES [dbo].[Addons] ([a_id])
GO
ALTER TABLE [dbo].[Addon Recipe] CHECK CONSTRAINT [FK__Addon Reci__a_id__17036CC0]
GO
ALTER TABLE [dbo].[Addon Recipe]  WITH CHECK ADD  CONSTRAINT [FK__Addon Reci__i_id__17F790F9] FOREIGN KEY([i_id])
REFERENCES [dbo].[Ingredients] ([i_id])
GO
ALTER TABLE [dbo].[Addon Recipe] CHECK CONSTRAINT [FK__Addon Reci__i_id__17F790F9]
GO
ALTER TABLE [dbo].[Addons Order]  WITH CHECK ADD  CONSTRAINT [FK__Addons Ord__a_id__14270015] FOREIGN KEY([a_id])
REFERENCES [dbo].[Addons] ([a_id])
GO
ALTER TABLE [dbo].[Addons Order] CHECK CONSTRAINT [FK__Addons Ord__a_id__14270015]
GO
ALTER TABLE [dbo].[Addons Order]  WITH CHECK ADD  CONSTRAINT [FK__Addons Ord__o_id__1332DBDC] FOREIGN KEY([o_id])
REFERENCES [dbo].[Orders] ([o_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Addons Order] CHECK CONSTRAINT [FK__Addons Ord__o_id__1332DBDC]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([e_id])
REFERENCES [dbo].[Employee] ([e_id])
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([e_id])
REFERENCES [dbo].[Employee] ([e_id])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK__Cart__c_id__3C69FB99] FOREIGN KEY([c_id])
REFERENCES [dbo].[Customer] ([c_id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK__Cart__c_id__3C69FB99]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_a_id] FOREIGN KEY([a_id])
REFERENCES [dbo].[Authority] ([a_id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_a_id]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK__Employee__t_id__3F466844] FOREIGN KEY([t_id])
REFERENCES [dbo].[Title] ([t_id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK__Employee__t_id__3F466844]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Authority] FOREIGN KEY([a_id])
REFERENCES [dbo].[Authority] ([a_id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Authority]
GO
ALTER TABLE [dbo].[Ingredients]  WITH CHECK ADD  CONSTRAINT [FK__Ingredien__sup_i__403A8C7D] FOREIGN KEY([sup_id])
REFERENCES [dbo].[Supplier] ([sup_id])
GO
ALTER TABLE [dbo].[Ingredients] CHECK CONSTRAINT [FK__Ingredien__sup_i__403A8C7D]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__cart_id__412EB0B6] FOREIGN KEY([cart_id])
REFERENCES [dbo].[Cart] ([cart_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__cart_id__412EB0B6]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__p_id__4222D4EF] FOREIGN KEY([p_id])
REFERENCES [dbo].[Products] ([p_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__p_id__4222D4EF]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_硬度] FOREIGN KEY([硬度_id])
REFERENCES [dbo].[硬度] ([硬度_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_硬度]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_鹹度] FOREIGN KEY([鹹度_id])
REFERENCES [dbo].[鹹度] ([鹹度_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_鹹度]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK__Recipe__i_id__440B1D61] FOREIGN KEY([i_id])
REFERENCES [dbo].[Ingredients] ([i_id])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK__Recipe__i_id__440B1D61]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK__Recipe__p_id__4316F928] FOREIGN KEY([p_id])
REFERENCES [dbo].[Products] ([p_id])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK__Recipe__p_id__4316F928]
GO
USE [master]
GO
ALTER DATABASE [Ramen] SET  READ_WRITE 
GO
