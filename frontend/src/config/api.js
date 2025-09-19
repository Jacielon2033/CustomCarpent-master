// Configuración centralizada de la API
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:5001';

export const API_ENDPOINTS = {
  // Auth
  LOGIN: `${API_BASE_URL}/api/login`,
  
  // Products
  PRODUCTS: `${API_BASE_URL}/api/products`,
  PRODUCT_VARIANTS: `${API_BASE_URL}/api/product_variants`,
  PRODUCT_VARIANTS_ADMIN: `${API_BASE_URL}/api/product-variants/admin/all`,
  
  // Contact
  CONTACT: `${API_BASE_URL}/api/contact`,
  
  // Carousel
  CAROUSEL: (pageName) => `${API_BASE_URL}/api/carousel/${pageName}`,
  
  // Gallery
  GALLERY: `${API_BASE_URL}/api/gallery`,
  
  // Options
  OPTIONS: `${API_BASE_URL}/api/options`,
  
  // Sections
  SECTIONS: `${API_BASE_URL}/api/sections`,
  
  // Uploads
  UPLOADS: `${API_BASE_URL}/uploads`
};

export default API_BASE_URL;
