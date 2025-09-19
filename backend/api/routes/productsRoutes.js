import express from 'express';
import multer from 'multer';
import { getProducts, saveProduct, deleteProduct, modifyProduct } from '../controllers/productsController.js';
import { getFullProductById } from '../controllers/productsController.js';
const router = express.Router();

// Configura multer para recibir la imagen
const storage = multer.memoryStorage();
const upload = multer({ storage });

router.post('/', upload.single('image'), saveProduct);
router.get('/', getProducts);
router.delete('/:id', deleteProduct);
router.put('/:id', upload.single('image'), modifyProduct);
router.get('/full/:id', getFullProductById);

export default router;