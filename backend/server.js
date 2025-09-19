import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import path from 'path';
import routes from './api/index.js';
import optionsRoutes from './api/routes/optionsRoutes.js';
import productVariantRoutes from './api/routes/productVariantRoutes.js';
import healthRoutes from './api/routes/healthRoutes.js';
import { fileURLToPath } from 'url';
import authRoutes from './api/routes/authRoutes.js'
dotenv.config();
const app = express();

// Convertir __filename y __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Middlewares
app.use(cors({
  origin: process.env.NODE_ENV === 'production' 
    ? ['https://rtakabinetssolutions.com', 'https://www.rtakabinetssolutions.com']
    : ['http://localhost:3000', 'http://localhost:5173', 'https://rtakabinetssolutions.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Logging middleware
app.use((req, res, next) => {
  console.log(`📥 ${req.method} ${req.path} - Origin: ${req.get('Origin') || 'No Origin'}`);
  next();
});

// Rutas
app.use('/api', authRoutes);
app.use('/api/options', optionsRoutes);
app.use('/api/product_variants', productVariantRoutes);  // aquí está bien
app.use('/api', healthRoutes);  // health check
app.use('/api', routes);  // aquí ya se incluye /products desde index.js

// Archivos estáticos
app.use('/uploads', express.static(path.join(__dirname, 'api', 'uploads')));

// Puerto
const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server running on port ${PORT}`);
  console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🔗 CORS origins: ${process.env.NODE_ENV === 'production' ? 'https://rtakabinetssolutions.com' : 'localhost + production domains'}`);
  console.log(`📡 Server accessible at: http://0.0.0.0:${PORT}`);
});