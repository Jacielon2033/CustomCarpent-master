// backend/api/routes/carouselRoutes.js
import express from 'express';
import { deleteCarouselImage, saveCarousel, getCarousel } from '../controllers/carouselController.js';
import upload from '../middlewares/multerConfig.js';

const router = express.Router();

// POST múltiples imágenes y título
router.post('/:pageName', upload.array('images'), saveCarousel);

// GET imágenes + título
router.get('/:pageName', getCarousel);

router.delete('/:pageName/:id', deleteCarouselImage); // debes tener esta ruta

export default router;
