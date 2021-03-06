 
USE [FarmSystem]
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 7/3/2021 12:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HoaDonId] [int] NOT NULL,
	[VatTuId] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ChiTietHoaDon] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[F_CongViec]    Script Date: 7/3/2021 12:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[F_CongViec](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Note] [nvarchar](200) NULL,
	[Sound] [nvarchar](100) NULL,
	[CreatedDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_F_CongViec] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[F_LichSuLamViec]    Script Date: 7/3/2021 12:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[F_LichSuLamViec](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CVId] [int] NOT NULL,
	[Note] [nvarchar](200) NULL,
	[CreatedDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_F_LichSuLamViec] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 7/3/2021 12:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](500) NOT NULL,
	[Total] [float] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 7/3/2021 12:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[Code] [varchar](250) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Fax] [nvarchar](250) NULL,
	[Telephone] [nvarchar](50) NULL,
	[Email] [nvarchar](250) NULL,
	[Phone] [char](15) NULL,
	[Address] [nvarchar](1000) NULL,
	[TaxCode] [nvarchar](50) NULL,
	[BankAccount] [nvarchar](50) NULL,
	[Note] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VatTu]    Script Date: 7/3/2021 12:57:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VatTu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](500) NOT NULL,
	[CongDung] [nvarchar](500) NOT NULL,
	[CachDung] [nvarchar](500) NULL,
	[DanhGia] [nvarchar](500) NULL,
	[DonGia] [float] NOT NULL,
	[Image] [nvarchar](1000) NULL,
	[CreatedDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_VatTu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDon] ON 

GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (1, 1, 1, 150000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (2, 1, 2, 75000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (3, 1, 3, 38000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (4, 1, 4, 80000, 3, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (5, 2, 1007, 250000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (6, 2, 1011, 25000, 5, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (7, 3, 1008, 250000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (8, 3, 1009, 20000, 5, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (9, 4, 1012, 20000, 3, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (10, 4, 1013, 20000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (11, 4, 1015, 20000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (12, 4, 1016, 20000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (13, 4, 1017, 20000, 5, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (14, 5, 1019, 130000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (15, 5, 1009, 13500, 20, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (16, 5, 1, 150000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (17, 5, 2, 75000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (18, 5, 1021, 165000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (19, 5, 1022, 135000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (21, 1004, 2024, 320000, 1, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (22, 1004, 2025, 42000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (23, 1004, 1024, 95000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (24, 1004, 1, 149000, 2, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (25, 1004, 2, 75000, 1, NULL, CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (26, 1009, 2026, 48000, 2, NULL, CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (27, 1004, 2027, 15000, 1, NULL, CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[ChiTietHoaDon] ([Id], [HoaDonId], [VatTuId], [Price], [Quantity], [Note], [CreatedDate], [IsDeleted]) VALUES (28, 1010, 2026, 48000, 2, NULL, CAST(0x00000000 AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[F_CongViec] ON 

GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1, N'Bón phân nở', NULL, NULL, CAST(0x1D420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (2, N'Bón phân 007', NULL, NULL, CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (3, N'Tưới', NULL, NULL, CAST(0x1D420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (4, N'Tưới HUMIC + Tricodema', NULL, NULL, CAST(0x1D420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1002, N'Tưới Root 10', NULL, NULL, CAST(0x1D420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1003, N'Xịt mantus', NULL, NULL, CAST(0x65420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1004, N'Xịt rầy', NULL, NULL, CAST(0x65420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1005, N'Xịt mantus + Rầy', NULL, NULL, CAST(0x65420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1006, N'Xịt mantus + classico +vino 79', NULL, NULL, CAST(0x65420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (1007, N'Ủ đạm cá', NULL, NULL, CAST(0x65420B00 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (2006, N'Trồng sầu riêng', NULL, NULL, CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (2007, N'tưới đạm cá', N'humic + tricodema + đạm cá', NULL, CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[F_CongViec] ([Id], [Name], [Note], [Sound], [CreatedDate], [IsDeleted]) VALUES (3006, N'Xịt thuốc', NULL, NULL, CAST(0x00000000 AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[F_CongViec] OFF
GO
SET IDENTITY_INSERT [dbo].[F_LichSuLamViec] ON 

GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (1, 1, NULL, CAST(0x1B420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2, 2, NULL, CAST(0x1B420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (1002, 1002, NULL, CAST(0x64420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (1004, 1003, NULL, CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (1005, 1004, NULL, CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2004, 1, NULL, CAST(0x81420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2005, 2, NULL, CAST(0x81420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2006, 3, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2007, 1005, NULL, CAST(0x83420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2008, 1004, NULL, CAST(0x89420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2009, 3006, N'mantus +vino 79 + classico', CAST(0x91420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (2010, 1007, NULL, CAST(0x8E420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (3008, 3006, N'mantus + amino + conphai', CAST(0x98420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (4008, 3006, N'classico + mantus + amino', CAST(0xA2420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (4009, 2006, N'cây số 2, 25', CAST(0x95420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (4011, 2006, NULL, CAST(0x5C410B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (4012, 2007, NULL, CAST(0xA9420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (4013, 3006, N'conphai + vino 79 + confidoor =>phạm thuốc rầy', CAST(0xAA420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (5008, 3006, N'mantus + amino spri', CAST(0xAD420B00 AS Date), 0)
GO
INSERT [dbo].[F_LichSuLamViec] ([Id], [CVId], [Note], [CreatedDate], [IsDeleted]) VALUES (5009, 3, N'Tiêu tuyến trùng (dịch quế) => nửa đám trên', CAST(0xB3420B00 AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[F_LichSuLamViec] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (1, N'Hiệp MT', 530000, NULL, CAST(0x82420B00 AS Date), 0, 1)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (2, N'Tư Thành', 330000, NULL, CAST(0x82420B00 AS Date), 0, 1)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (3, N'8 Đức', 350000, NULL, CAST(0x82420B00 AS Date), 0, 1)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (4, N'thuốc ủ phân cá', 240000, NULL, CAST(0xA3420B00 AS Date), 0, 5)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (5, N'Hiệp MT', 1280000, NULL, CAST(0x8B420B00 AS Date), 0, 1)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (1004, N'Hiệp MT', 982000, NULL, CAST(0xB2420B00 AS Date), 0, 1)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (1009, N'1', 96000, N'truông mít', CAST(0xB4420B00 AS Date), 0, 3)
GO
INSERT [dbo].[HoaDon] ([Id], [Code], [Total], [Note], [CreatedDate], [IsDeleted], [CustomerId]) VALUES (1010, N'2', 96000, NULL, CAST(0xB2420B00 AS Date), 0, 3)
GO
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (1, 1, N'1', N'Hiệp MT', NULL, NULL, NULL, N'12             ', N'miền tây - online', NULL, NULL, NULL, 0, CAST(0x0000AD5800E619A5 AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (3, 1, N'02072021-103717', N'Chú Mè', NULL, NULL, NULL, N'1              ', N'chợ chiều truông mít', NULL, NULL, NULL, 0, CAST(0x0000AD5900AF0957 AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (4, 2, N'03072021-103520', N'Chị mông', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(0x0000AD5A00AE80C1 AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (5, 1, N'03072021-103554', N'Lazada', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(0x0000AD5A00AEA8A1 AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (6, 1, N'03072021-103606', N'Shopee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(0x0000AD5A00AEB5D0 AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (7, 1, N'03072021-104407', N'Tư Thành', NULL, NULL, NULL, NULL, N'đèn đỏ bàu đồn chạy lên', NULL, NULL, NULL, 0, CAST(0x0000AD5A00B0EA56 AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (8, 1, N'03072021-104425', N'8 Đức', NULL, NULL, NULL, NULL, N'ngã 3 đất sét', NULL, NULL, NULL, 0, CAST(0x0000AD5A00B0FF2C AS DateTime))
GO
INSERT [dbo].[KhachHang] ([Id], [Type], [Code], [Name], [Fax], [Telephone], [Email], [Phone], [Address], [TaxCode], [BankAccount], [Note], [IsDeleted], [CreatedDate]) VALUES (9, 1, N'03072021-113142', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000AD5A00BDFB36 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[VatTu] ON 

GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1, N'Mantus', N'nhân sâm gốc', N'chai pha 200l + phun lá', N'*****', 150000, N'z2585275110493_b80e7f9acd2e97751537b79f4304dbd5.jpg', CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (2, N'Amino spri', N'kéo đọt', N'chai pha 200l + phun lá', N'*****', 75000, N'z2585275110124_c86882d0eece43b80d925e3eaf057c73.jpg', CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (3, N'Asara super siêu sát rầy', N'rầy', N'gói pha 200l + phun lá', N'3*', 38000, NULL, CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (4, N'Nu vita', N'tưới gốc kích rễ', N'chai pha 200l + tưới gốc 7-8l', N'5*', 80000, NULL, CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1007, N'Vi sinh 007', N'phân bón', N'phân bón', N'*****', 250000, NULL, CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1008, N'Phân nở', N'phân bón', N'phân bón', NULL, 250000, NULL, CAST(0x66420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1009, N'Conphai', N'thuốc rầy', N'gói 30l', N'****', 20000, N'z2585275066748_f5a44eeee320b3d78dd8196f937e0167.jpg', CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1011, N'pumax japan', N'phân bón', N'trộn với 007', N'5*', 25000, NULL, CAST(0x82420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1012, N'mật rỉ đường', N'ủ đạm cá', N'ủ đạm cá', N'*****', 14325, N'2920202052023_mat-ri-duong-nguyen-chat-sfarm.jpg', CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1013, N'Chế phẩm vi sinh EM Emuniv', N'Chế phẩm vi sinh EM Emuniv dùng ủ phân cá, xử lý rác thải hữu cơ 200gr', N'ủ đạm cá', N'*****', 27543, N'2353202035344_che-pham-sinh-hoc-emuniv-u-phan-rac-thai-va-dau-tuong.jpg', CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1015, N'NấmTrichoderma Điền Trang', N'NấmTrichoderma Điền Trang, nấm đối kháng trichoderma chế phẩm trichoderma dùng để ủ xác bã thực vật 1000gr', N'tưới gốc', N'*', 55000, NULL, CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1016, N'Confidor 200sl', N'thuốc xịt con nâu', N'thuốc xịt con nâu', N'*', 34095, N'confidoor.jpg', CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1017, N'Bột Diệt Kiến Và Côn Trùng ViPesco', N'Bột Diệt Kiến Và Côn Trùng ViPesco', N'Bột Diệt Kiến Và Côn Trùng ViPesco', N'***', 9010, NULL, CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1019, N'Humic acid USA', N'kích rễ humic', N'tưới 1kg/400l', NULL, 130000, N'z2585275097637_e636574e1dbbaf503dec465149cccc7c.jpg', CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1021, N'Thuốc rầy Classico', N'xịt rầy mạnh', N'1 chai/400l', N'*****', 165000, N'classico.jpg', CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1022, N'vino 79 500ml', N'bổ xung trung vi lượng', N'xịt lá chai/400l', NULL, 150000, NULL, CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1023, N'vino 79 1000ml', N'bổ xung trung vi lượng', N'xịt lá chai/800l', NULL, 270000, NULL, CAST(0x8B420B00 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (1024, N'Map logic', N'rãi gốc trị tuyến trùng', N'rãi gốc khi cay bệnh', NULL, 95000, N'map-logic.jpg', CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (2024, N'tiêu tuyến trùng 18ec', N'tưới tiêu tuyến trùng', N'tưới 2 cử vào đầu & cuối mùa mưa', NULL, 320000, N'h1.jpg', CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (2025, N'Ridomin gold', N'xì mũ, tưới gốc mùa mưa trị nấm', N'xì mũ, tưới gốc mùa mưa trị nấm', N'*****', 42000, N'ridomin-gold.jpg', CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (2026, N'Sieugon 85gr', N'diệt kiến ...', N'rãi gốc ', N'****', 48000, N'sieugon85gr.jpg', CAST(0x00000000 AS Date), 0)
GO
INSERT [dbo].[VatTu] ([Id], [Ten], [CongDung], [CachDung], [DanhGia], [DonGia], [Image], [CreatedDate], [IsDeleted]) VALUES (2027, N'Phí ship ', N'Phí ship ', NULL, NULL, 15000, NULL, CAST(0x00000000 AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[VatTu] OFF
GO
ALTER TABLE [dbo].[ChiTietHoaDon] ADD  CONSTRAINT [DF_ChiTietHoaDon_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ChiTietHoaDon] ADD  CONSTRAINT [DF_ChiTietHoaDon_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[F_CongViec] ADD  CONSTRAINT [DF_F_CongViec_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[F_CongViec] ADD  CONSTRAINT [DF_Table_1_IsDelete]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[F_LichSuLamViec] ADD  CONSTRAINT [DF_F_LichSuLamViec_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[F_LichSuLamViec] ADD  CONSTRAINT [DF_F_LichSuLamViec_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_CustomerId]  DEFAULT ((1)) FOR [CustomerId]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_Type]  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_Table_1_Index]  DEFAULT ((0)) FOR [Code]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[VatTu] ADD  CONSTRAINT [DF_VatTu_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[VatTu] ADD  CONSTRAINT [DF_VatTu_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_HoaDon] FOREIGN KEY([HoaDonId])
REFERENCES [dbo].[HoaDon] ([Id])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_HoaDon]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_VatTu] FOREIGN KEY([VatTuId])
REFERENCES [dbo].[VatTu] ([Id])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_VatTu]
GO
ALTER TABLE [dbo].[F_LichSuLamViec]  WITH CHECK ADD  CONSTRAINT [FK_F_LichSuLamViec_F_CongViec] FOREIGN KEY([CVId])
REFERENCES [dbo].[F_CongViec] ([Id])
GO
ALTER TABLE [dbo].[F_LichSuLamViec] CHECK CONSTRAINT [FK_F_LichSuLamViec_F_CongViec]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_KhachHang] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[KhachHang] ([Id])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_KhachHang]
GO
USE [master]
GO
ALTER DATABASE [FarmSystem] SET  READ_WRITE 
GO
