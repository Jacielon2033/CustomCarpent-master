import React, { useEffect, useState } from 'react';
import { Carousel } from 'react-responsive-carousel';
import "react-responsive-carousel/lib/styles/carousel.min.css";

const ImageCarousel = ({ page }) => {
  const [images, setImages] = useState([]);

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_URL || 'https://api.rtakabinetssolutions.com'}/api/carousel/${page}`)
      .then(res => res.json())
      .then(data => {
        if (Array.isArray(data.images)) {
          const loadedImages = data.images.map(img => ({
            id: img.id,
            path: img.path.replace(/\\/g, '/')
          }));
          setImages(loadedImages);
        }
      })
      .catch(err => {
        console.error('❌ Error al cargar las imágenes del carrusel:', err);
      });
  }, [page]);

  return (
    <>
      {images.length > 0 && (
        <Carousel
          showThumbs={false}
          showStatus={false}
          infiniteLoop
          autoPlay
          interval={4000}
          stopOnHover={false}
          showArrows={false}
          swipeable
          emulateTouch
          className="h-[500px] rounded-xl overflow-hidden shadow-lg transition-all duration-1000"
        >
          {images.map((img, index) => (
            <div key={img.id} className="w-full h-[500px]">
              <img
                src={`${img.path}`}
                alt={`Slide-${index}`}
                className="w-full h-full object-cover transition-opacity duration-700 ease-in-out"
              />
            </div>
          ))}
        </Carousel>
      )}
    </>
  );
};

export default ImageCarousel;
