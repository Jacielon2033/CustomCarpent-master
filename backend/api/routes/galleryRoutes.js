import express from 'express';
import upload from '../middlewares/multerConfig.js';
import { getGallerySection, saveGallerySection, deleteGalleryImage } from '../controllers/galleryController.js';

const router = express.Router();

// Obtener imágenes de una sección
router.get('/:pageName/:sectionName', getGallerySection);
// Guardar imágenes
router.post('/:pageName/:sectionName', upload.array('images'), saveGallerySection);
// Eliminar una imagen específica
router.delete('/:pageName/:sectionName/:id', deleteGalleryImage);

export default router;