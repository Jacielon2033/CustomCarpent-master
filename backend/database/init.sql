-- Script de inicialización de la base de datos CustomCarpent
-- Basado en el esquema real de la aplicación

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS customcarpent;

-- Usar la base de datos
USE customcarpent;

-- Configuración de charset
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Tabla de colores
CREATE TABLE IF NOT EXISTS `colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hexCode` varchar(10) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de información de contacto
CREATE TABLE IF NOT EXISTS `contactinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(150) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `ContactBy` varchar(50) DEFAULT NULL,
  `Message` text,
  `ShippingDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de imágenes de galería
CREATE TABLE IF NOT EXISTS `gallery_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_name` varchar(100) NOT NULL,
  `section_name` varchar(100) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de imágenes generales
CREATE TABLE IF NOT EXISTS `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section` varchar(100) NOT NULL,
  `path` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de información de secciones
CREATE TABLE IF NOT EXISTS `sectioninformation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_name` varchar(100) NOT NULL,
  `section_name` varchar(100) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de variantes de productos
CREATE TABLE IF NOT EXISTS `product_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color_id` int NOT NULL,
  `size_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `color_id` (`color_id`),
  KEY `size_id` (`size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `colors` json DEFAULT NULL,
  `sizes` json DEFAULT NULL,
  `materials` text,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de tamaños
CREATE TABLE IF NOT EXISTS `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sizeLabel` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insertar colores por defecto
INSERT IGNORE INTO `colors` (`id`, `hexCode`, `description`) VALUES
(40, '#f7f7f7', 'White shaker'),
(45, '#bab86c', 'Olive Green'),
(46, '#806517', 'Oak'),
(47, '#faebd7', 'Antique White'),
(49, '#000080', 'Navy Blue'),
(50, '#d3d3d3', 'Light Gray'),
(51, '#808080', 'Gray'),
(52, '#605f5c', 'Smoke Metallic'),
(53, '#9b7f5b', 'Ash brown'),
(54, '#000000', 'Black');

-- Insertar usuarios administradores por defecto
INSERT IGNORE INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
(3, 'Admin', 'admin@admin.com', '$2b$10$5t29qgxoOPQDW8sYFtRXhuw9p3XvMdfckLsHkU9hGzN', 'admin'),
(4, 'SuperAdmin', 'admin2@admin.com', '$2b$10$sW8YqKUHY1k6HcSADNSM8iOAaFCrp8P3b7gPLRgI3CA1', 'admin'),
(5, 'DevAdmin', 'admin@dev.com', 'admin123', 'admin');

-- Insertar información de secciones por defecto
INSERT IGNORE INTO `sectioninformation` (`id`, `page_name`, `section_name`, `title`, `description`, `image_path`) VALUES
(1, 'home', 'carousel', 'Custom cabinets, made to your style', NULL, NULL),
(5, 'home', 'experience', 'We have 15 years of experience', 'Welcome to RTA KABINETS LLC, where your vision meets craftsmanship! Our team is here to bring your ideas to life with the warmth and beauty of wood. Whether it\'s a unique piece of furniture or a home transformation, we\'re dedicated to making your dreams a reality. With years of experience, we take care of the details, ensuring every project reflects your style. Let\'s create something special together your space, your story, crafted by us at RTA KABINETS LLC.', '/uploads/home/1751996942588-7d13c1eb68f86f75d59e01d348018ab8f4a3c304.png'),
(6, 'home', 'ourservices_1', 'Custom Cabinets', 'We create custom cabinets, closets, doors, and more, made to your exact measurements, colors, and style. Whatever you imagine, we can build — fully personalized and crafted just for you.', '/uploads/home/1751997248728-f26bad68922b2b4acae9931f6cd6206a926dca7d.png'),
(7, 'home', 'ourservices_2', 'Epoxy Countertops', 'At RTA Carpentry, we create custom epoxy countertops that are both durable and stylish—made to fit your space and reflect your unique taste.', '/uploads/home/1751997251473-78914bbf15f5bd91cfce9a6ddeb3c5123b32e551.png'),
(8, 'home', 'ourservices_3', 'RTA Cabinets', 'At RTA Kabinets, we design and craft stylish, ready-to-assemble cabinets tailored to your space, needs, and personal taste.', '/uploads/home/1751997253277-638fbc882fa28fc59c701108fcd88dfe3ee8aa56.png'),
(9, 'home', 'chooseus', 'Why choose us!!', 'People choose us because we deliver custom cabinets that are exactly what they want, in their own style. Every piece is made-to-order, personalized to fit your space perfectly and match your aesthetic from color and size to the smallest design details. We don\'t just build cabinets; we craft solutions that reflect your personality and needs. With us, your vision is always the blueprint.', '/uploads/home/1751997316745-51f19089c286bdafd8fa36ac823f25cc17521c9c.png'),
(10, 'aboutus', 'carousel', 'About us', NULL, NULL),
(12, 'aboutus', 'ourstory', 'Our Story', 'Welcome to RTA KABINETS LLC – over 15 years of turning ideas into handcrafted beauty. Based in Tucson, Arizona, we specialize in custom cabinetry, expert carpentry, and stunning epoxy countertops for both homes and businesses. Whether you\'re reimagining your kitchen, creating a unique furniture piece, or adding a bold epoxy finish to your space, we\'re here to make it happen. At RTA KABINETS LLC, we blend creativity, craftsmanship, and attention to detail to ensure every project reflects your vision. From timeless woodwork to modern epoxy designs—your space, your story, built with care.', '/uploads/aboutus/1751997637310-82771c97255f779830ec8143c6f0d7e61f8d7f1f.png'),
(13, 'aboutus', 'mission', 'Mission', 'At RTA KABINETS LLC, our mission is to transform spaces through custom carpentry solutions, combining over 15 years of experience with a passion for quality, craftsmanship, and creativity. We are dedicated to designing and building cabinets, furniture, and epoxy countertops that reflect each client\'s unique style and needs—offering reliable, friendly, and professional service every step of the way.', '/uploads/aboutus/1751997691764-92523604375a2187a5ef4c79acede347f3d940df.png'),
(14, 'aboutus', 'vision', 'Vision', 'To become a leading provider of custom woodworking and epoxy designs in Tucson and surrounding areas, known for our exceptional craftsmanship, innovative designs, and commitment to customer satisfaction. We aim to grow with our community, bringing the warmth of wood and the beauty of our work into more homes and businesses.', '/uploads/aboutus/1751998805994-0c2b6ebfcafe4b5a34827872a6a27431da53fa02.png'),
(15, 'gallery', 'carousel', 'Gallery', NULL, NULL),
(17, 'products', 'carousel', 'Products', NULL, NULL),
(22, 'contact', 'carousel', 'Contact', NULL, NULL);

-- Restaurar configuración
SET FOREIGN_KEY_CHECKS = 1;