-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 16, 2023 at 06:21 AM
-- Server version: 8.0.31
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int UNSIGNED NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `image`, `url`, `created_at`, `updated_at`) VALUES
(4, 'public/banner-image/2023-01-22-22-54-49.jpeg', 'https://digikala.com/', '2023-01-23 02:24:49', NULL),
(5, 'public/banner-image/2023-01-22-22-55-15.jpeg', 'https://toplearn.com/', '2023-01-23 02:25:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'اقتصادی', '2023-01-17 18:45:00', NULL),
(3, 'سیاسی', '2023-01-17 18:45:13', NULL),
(4, 'تکنولوژی', '2023-01-17 18:45:21', NULL),
(5, 'اجتماعی', '2023-01-18 15:58:38', NULL),
(6, 'ورزشی', '2023-01-18 16:35:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `post_id` int UNSIGNED NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('unseen','seen','approved') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unseen',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `comment`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'خیلی خوشحال شدم واقعا حقش بود بعد از این همه سال یدونه توپ طلا بگیره.', 'seen', '2023-01-20 15:50:57', '2023-01-20 20:10:51'),
(2, 2, 3, 'این چه وضعشه آخه هر روز باید ببینیم همه چی دوبرابر شده', 'approved', '2023-01-20 15:51:57', '2023-01-20 20:10:49'),
(3, 1, 2, 'حال نکردم', 'seen', '2023-01-20 16:41:01', '2023-01-23 15:32:00'),
(5, 9, 8, 'همش کاره دشمنه', 'approved', '2023-01-22 14:18:11', '2023-01-23 15:31:59'),
(6, 2, 8, 'دیوید دیوید او اس آآآآ', 'approved', '2023-01-23 12:07:05', '2023-01-23 15:38:08'),
(7, 9, 8, 'به نظره من که بایدن بهتر از ترامپه', 'approved', '2023-01-23 22:56:05', '2023-01-23 22:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` int UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `url`, `parent_id`, `created_at`, `updated_at`) VALUES
(2, 'اخبار سیاسی', 'https://digikala.com/', NULL, '2023-01-20 17:09:19', NULL),
(5, 'پربازدید ترین اخبار', 'https://varzesh3.com/', NULL, '2023-01-20 21:07:07', NULL),
(6, 'اخبار ورزشی', 'https://varzesh3.com/', NULL, '2023-01-20 21:07:39', NULL),
(7, 'فوتبال', 'https://varzesh3.com/', 6, '2023-01-20 21:07:51', NULL),
(8, 'اخباره تازه', 'login', NULL, '2023-01-20 21:51:55', NULL),
(9, 'اخبار اقتصادی', 'https://divar.com/', NULL, '2023-01-20 21:52:46', NULL),
(10, 'قیمت ارز و طلا', 'https://tgju.org/', 9, '2023-01-20 21:53:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `view` int NOT NULL DEFAULT '0',
  `user_id` int UNSIGNED NOT NULL,
  `cat_id` int UNSIGNED NOT NULL,
  `image` text COLLATE utf8mb4_general_ci,
  `status` enum('enable','disable') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'disable',
  `selected` tinyint NOT NULL DEFAULT '1' COMMENT '1 => selected\r\n2 => not selected',
  `breaking_news` tinyint NOT NULL DEFAULT '1' COMMENT '1 => BN\r\n2 => not BN',
  `published_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `summary`, `body`, `view`, `user_id`, `cat_id`, `image`, `status`, `selected`, `breaking_news`, `published_at`, `created_at`, `updated_at`) VALUES
(2, 'توپ طلای 2018', '<p>لوکا مودریچ، برنده توپ طلای سال 2018</p>\r\n', '<p>لوکا مودریچ بعد از انتخاب شدن به عنوان برنده جایزه توپ طلا گفت: بردن این جایزه یک احساس منحصر به فرد است و من بسیار افتخار می کنم. توصیف احساسی که در حال حاضر دارم بسیار دشوار است و من باید از همه افرادی که زمینه حضور من در این مراسم را فراهم کردند تشکر کنم. من می خواهم از دوستان و مربیانم در رئال مادرید و کرواسی قدردانی کنم. همسر و فرزندانم شخصیت من را ساخته و برای حضور در عرصه حرفه ای در همه ابعاد آماده می سازند.</p>\r\n', 22, 1, 6, 'public/post-image/2023-01-22-23-44-09.jpeg', 'disable', 1, 2, '2023-02-08 19:27:38', '2023-01-18 13:52:20', '2023-01-23 02:09:43'),
(3, 'قیمت دلار', '<p>قیمت دلار در بازار آزاد به ۴۲ هزار تومان نزدیک شد</p>\r\n', '<p>وزیر اقتصاد گفت: برنامه ارزی دولت تثبیت به معنای میخکوب کردن نرخ ارز نیست بلکه به دنبال ثبات بخشی به بازار و مدیریت نرخ حول سامانه نیما است. سید احسان خاندوزی وزیر اقتصاد در گفت&zwnj;وگوی تلویزیونی با اشاره به سیاست دولت در تثبیت بازار ارز گفت: تثبیت بازار ارز به معنای تثبیت نرخ ارز نیما در قیمت ۲۸,۵۰۰ تومان نیست. باید بتوانیم صادرات و واردات را در سامانه نیما انجام دهیم و ثبات اقتصادی باید در سامانه نیما انجام بگیرد.</p>\r\n', 13, 2, 2, 'public/post-image/2023-01-19-12-21-39.jpeg', 'disable', 1, 2, '2023-01-20 12:21:17', '2023-01-18 13:54:07', '2023-01-23 02:09:43'),
(8, 'انتخابات ریاست‌جمهوری ایالات متحده آمریکا (۲۰۲۰)', '<p><strong>پنجاه و نهمین انتخابات ریاست&zwnj;جمهوری ایالات متحده آمریکا</strong>&nbsp;در ۳ نوامبر ۲۰۲۰ مصادف با ۱۳ آبان ۱۳۹۹، برای انتخاب&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%B1%D8%A6%DB%8C%D8%B3%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7\">رئیس&zwnj;جمهور ایالات متحده آمریکا</a>&nbsp;و معاون او، برگزار شد</p>\r\n', '<p><strong>پنجاه و نهمین انتخابات ریاست&zwnj;جمهوری ایالات متحده آمریکا</strong>&nbsp;در ۳ نوامبر ۲۰۲۰ مصادف با ۱۳ آبان ۱۳۹۹، برای انتخاب&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%B1%D8%A6%DB%8C%D8%B3%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7\">رئیس&zwnj;جمهور ایالات متحده آمریکا</a>&nbsp;و معاون او، برگزار شد و با پیروزی نامزدهای&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AD%D8%B2%D8%A8_%D8%AF%D9%85%D9%88%DA%A9%D8%B1%D8%A7%D8%AA_(%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7)\">حزب دموکرات</a>،&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AC%D9%88_%D8%A8%D8%A7%DB%8C%D8%AF%D9%86\">جو بایدن</a>&nbsp;و&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%DA%A9%D8%A7%D9%85%D8%A7%D9%84%D8%A7_%D9%87%D8%B1%DB%8C%D8%B3\">کامالا هریس</a>&nbsp;به پایان رسید. این انتخابات، بیشترین میزان مشارکت در انتخابات&zwnj;های ریاست جمهوری از سال ۱۹۰۰ را داشت. همچنین بایدن و هریس با دریافت بیش از ۸۱ میلیون رای، بالاتر از&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%A8%D8%A7%D8%B1%D8%A7%DA%A9_%D8%A7%D9%88%D8%A8%D8%A7%D9%85%D8%A7\">باراک اوباما</a>&nbsp;(۶۹٫۵ میلیون رای در&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%A7%D9%86%D8%AA%D8%AE%D8%A7%D8%A8%D8%A7%D8%AA_%D8%B1%DB%8C%D8%A7%D8%B3%D8%AA%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1%DB%8C_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7_(%DB%B2%DB%B0%DB%B0%DB%B8)\">انتخابات ۲۰۰۸</a>)، صاحب رکورد بیشترین رای در تاریخ ایالات متحده شدند.&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%B1%DB%8C%D8%A7%D8%B3%D8%AA%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1%DB%8C_%D8%AC%D9%88_%D8%A8%D8%A7%DB%8C%D8%AF%D9%86\">دولت جو بایدن</a>&nbsp;در تاریخ ۲۰ ژانویه ۲۰۲۱ کار خود را&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AA%D8%AD%D9%84%DB%8C%D9%81_%D8%AC%D9%88_%D8%A8%D8%A7%DB%8C%D8%AF%D9%86\">آغاز</a>&nbsp;کرد.</p>\r\n\r\n<p>این انتخابات یک انتخابات غیرمستقیم بود. رأی&zwnj;دهندگان،&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D9%85%D8%AC%D9%85%D8%B9_%DA%AF%D8%B2%DB%8C%D9%86%D9%86%D8%AF%DA%AF%D8%A7%D9%86_(%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7)\">گزینندگان</a>&nbsp;را انتخاب کردند؛&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%DA%A9%D8%A7%D9%84%D8%AC_%D8%A7%D9%86%D8%AA%D8%AE%D8%A7%D8%A8%D8%A7%D8%AA%DB%8C_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7\">گزینندگان</a>&nbsp;نیز در روز ۱۴ دسامبر ۲۰۲۰ رأی نهایی خود برای انتخاب&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AC%D9%88_%D8%A8%D8%A7%DB%8C%D8%AF%D9%86\">جو بایدن</a>،&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D9%81%D9%87%D8%B1%D8%B3%D8%AA_%D8%B1%D8%A6%DB%8C%D8%B3%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1%D9%87%D8%A7%DB%8C_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7\">رئیس&zwnj;جمهور</a>&nbsp;جدید، را به صندوق انداختند.<a href=\"https://fa.wikipedia.org/wiki/%D8%A7%D9%86%D8%AA%D8%AE%D8%A7%D8%A8%D8%A7%D8%AA_%D8%B1%DB%8C%D8%A7%D8%B3%D8%AA%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1%DB%8C_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7_(%DB%B2%DB%B0%DB%B2%DB%B0)#cite_note-1\">[۱]</a>&nbsp;دو حزب اصلی شرکت&zwnj;کننده در انتخابات،&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AD%D8%B2%D8%A8_%D8%AF%D9%85%D9%88%DA%A9%D8%B1%D8%A7%D8%AA_(%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7)\">حزب دموکرات</a>&nbsp;و&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AD%D8%B2%D8%A8_%D8%AC%D9%85%D9%87%D9%88%D8%B1%DB%8C%E2%80%8C%D8%AE%D9%88%D8%A7%D9%87_(%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7)\">حزب جمهوری&zwnj;خواه</a>&nbsp;بودند. رئیس&zwnj;جمهور&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AF%D9%88%D9%86%D8%A7%D9%84%D8%AF_%D8%AA%D8%B1%D8%A7%D9%85%D9%BE\">دونالد ترامپ</a>&nbsp;از حزب جمهوری&zwnj;خواه متقاضی انتخاب مجدد برای دوره دوم در سال ۲۰۲۰ بود. او بدون روبرو شدن با یک رقیب جدی در رقابت&zwnj;های مقدماتی، توانست نامزدی حزب جمهوری&zwnj;خواه را مال خود کند. در سوی دیگر،&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AC%D9%88_%D8%A8%D8%A7%DB%8C%D8%AF%D9%86\">جو بایدن</a>&nbsp;قرار داشت. او با شکست&zwnj;دادن&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%A8%D8%B1%D9%86%DB%8C_%D8%B3%D9%86%D8%AF%D8%B1%D8%B2\">برنی سندرز</a>&nbsp;که در&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%B1%D9%82%D8%A7%D8%A8%D8%AA%E2%80%8C%D9%87%D8%A7%DB%8C_%D9%85%D9%82%D8%AF%D9%85%D8%A7%D8%AA%DB%8C_%D8%B1%DB%8C%D8%A7%D8%B3%D8%AA%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1%DB%8C_%D8%AD%D8%B2%D8%A8_%D8%AF%D9%85%D9%88%DA%A9%D8%B1%D8%A7%D8%AA_(%DB%B2%DB%B0%DB%B2%DB%B0)\">رقابت&zwnj;های مقدماتی حزب دموکرات</a>&nbsp;نزدیک&zwnj;ترین رقیبش بود، به عنوان نامزد دموکرات&zwnj;ها انتخاب شد.&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AC%D9%88_%D8%AC%D9%88%D8%B1%DA%AF%D9%86%D8%B3%D9%86\">جو جورگنسن</a>&nbsp;نامزد&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AD%D8%B2%D8%A8_%D9%84%DB%8C%D8%A8%D8%B1%D8%AA%D8%B1%DB%8C%D9%86\">حزب لیبرترین</a>&nbsp;و هووی هاوکینز نامزد&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D8%AD%D8%B2%D8%A8_%D8%B3%D8%A8%D8%B2_(%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7)\">حزب سبز</a>&nbsp;بود.<a href=\"https://fa.wikipedia.org/wiki/%D8%A7%D9%86%D8%AA%D8%AE%D8%A7%D8%A8%D8%A7%D8%AA_%D8%B1%DB%8C%D8%A7%D8%B3%D8%AA%E2%80%8C%D8%AC%D9%85%D9%87%D9%88%D8%B1%DB%8C_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7_(%DB%B2%DB%B0%DB%B2%DB%B0)#cite_note-2\">[۲]</a>&nbsp;همزمان با این انتخابات، انتخابات&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D9%85%D8%AC%D9%84%D8%B3_%D9%86%D9%85%D8%A7%DB%8C%D9%86%D8%AF%DA%AF%D8%A7%D9%86_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7\">مجلس نمایندگان</a>&nbsp;و&nbsp;<a href=\"https://fa.wikipedia.org/wiki/%D9%85%D8%AC%D9%84%D8%B3_%D8%B3%D9%86%D8%A7%DB%8C_%D8%A7%DB%8C%D8%A7%D9%84%D8%A7%D8%AA_%D9%85%D8%AA%D8%AD%D8%AF%D9%87_%D8%A2%D9%85%D8%B1%DB%8C%DA%A9%D8%A7\">سنا</a>&nbsp;نیز برگزار شد.</p>\r\n', 45, 1, 3, 'public/post-image/2023-01-22-17-04-11.jpeg', 'disable', 1, 1, '2023-01-22 19:00:59', '2023-01-22 17:04:11', '2023-01-23 02:09:56'),
(9, 'قهرمانی همیلتون', '<p>لوییس همیلتون افسانه فرمول یک هفتمین قهرمانی خود را کسب کرد</p>\r\n', '<p>&laquo;هنوز برمی&zwnj;خیزم&raquo;&nbsp;I Still Get Up ؛&nbsp;این کلماتی است که در پشت کلاه&nbsp;لوییس همیلتون &laquo;Lewis Hamilton&raquo;&nbsp;نقش بسته و روی شانه&zwnj;هایش خالکوبی شده است و انتظارات را با یکی از بهترین نمایش&zwnj;های یک تازه کار در&nbsp;تاریخ F1&nbsp;در سال ۲۰۰۷ برآورده کرده است. این به معنای واقعی کلمه، تمام کاری است که او انجام می&zwnj;دهد: &laquo;او قیام کرده است&raquo;. در صدر فهرست رتبه&zwnj;بندی تمام دوران فرمول یک، پیش از قهرمان خود آیرتون سنا، به مقام اول در ستون بردها رسید و از&nbsp;میشائیل شوماخر&nbsp;تکرار نشدنی پیشی گرفت و سپس با هفت عنوان قهرمانی جهان آلمانی افسانه ای برابری کرد.</p>\r\n\r\n<p>لوییس همیلتون&nbsp;یکی از بزرگ&zwnj;ترین رانندگان تاریخ فرمول یک است. تا سال ۲۰۲۱، لوئیس همیلتون پادشاه رانندگان فرمول یک بود. او قهرمان مطلق بود و اگرچه&nbsp;مکس ورشتاپن&nbsp;جوان او را شکست داد، اما این اتفاق چیزی از ارزش های ۷ قهرمانی که لوئیس قبلا کسب کرده است، کم نمی&zwnj;کند. در حالی که هنوز شایعاتی مبنی بر بازنشستگی همیلتون از فرمول یک وجود دارد، ما به معرفی خودرو و آغاز فصل جدید بسیار نزدیک هستیم و به معنی این است که احتمال بازنشستگی همیلتون بسیار کم است.</p>\r\n', 0, 1, 6, 'public/post-image/2023-01-23-23-36-00.webp', 'disable', 1, 1, '2023-01-23 23:31:03', '2023-01-23 23:33:33', '2023-01-23 23:36:00');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `keywords` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logo` text COLLATE utf8mb4_general_ci,
  `icon` text COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `title`, `description`, `keywords`, `logo`, `icon`, `created_at`, `updated_at`, `name`) VALUES
(1, 'سایت خبری', 'این سایت خبری اولین پروژه سمت سرور من است', 'سایت/طراحی', 'public/setting/logo.png', 'public/setting/icon.png', '2023-01-20 22:38:51', '2023-01-21 15:00:07', 'پروژه طراحی سایت خبری');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permission` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'user',
  `verify_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT '0' COMMENT '0 => inactive \r\n1 => active',
  `forgot_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `forgot_token_expire` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `permission`, `verify_token`, `is_active`, `forgot_token`, `forgot_token_expire`, `created_at`, `updated_at`) VALUES
(1, 'پویا', 'pooya@yahoo.com', 'pooya12345', 'admin', NULL, 1, NULL, NULL, '2023-01-18 13:51:01', '2023-01-20 16:59:19'),
(2, 'درسا', 'dorsa@gmail.com', '123321', 'user', NULL, 0, NULL, NULL, '2023-01-18 13:51:43', '2023-01-20 16:59:27'),
(9, 'admin', 'firstprojectmailer@gmail.com', '$2y$10$MF99sNJzYhvb413gdspIYOhNQIWIKni0ZxWVuEwZeVrcb9virqqz2', 'admin', '6c383333037829928d0ac314f67ea5e721ec3c34d23f4a8d559fd95ef0ac0f7c', 1, 'cfcc388c37b2d5e9c7102a102da9ec898a5a69116f04297b6cf9e13f42f90412', '2023-01-22 03:16:31', '2023-01-21 20:15:22', '2023-01-22 03:14:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id2` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `parent_id` FOREIGN KEY (`parent_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `cat_id` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
