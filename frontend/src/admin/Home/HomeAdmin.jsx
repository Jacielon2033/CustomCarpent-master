import SectionEditorForm from '../../components/shared/SectionEditorForm';
import { useMemo, useEffect, useState } from 'react';
import CarouselSection from '../../components/shared/CarouselSection';

const HomeAdmin = () => {
  const sections = useMemo(() => [
    { page: "home", key: "experience", label: "Experience" },
    { page: "home", key: "chooseus", label: "Why Choose Us" },
    { page: "home", key: "ourservices_1", label: "Our Services (First Image)" },
    { page: "home", key: "ourservices_2", label: "Our Services (Second Image)" },
    { page: "home", key: "ourservices_3", label: "Our Services (Third Image)" }
  ], []);

  const [sectionData, setSectionData] = useState({});

  useEffect(() => {
    sections.forEach(async ({ page, key }) => {
      try {
        const res = await fetch(`${import.meta.env.VITE_API_URL || 'https://api.rtakabinetssolutions.com'}/api/section/${page}/${key}`);
        const result = await res.json();

        setSectionData(prev => ({
          ...prev,
          [`${page}_${key}`]: {
            title: result.title,
            description: result.description,
            imageUrl: result.image_url
          }
        }));
      } catch (err) {
        console.error(`Error loading ${page}/${key}:`, err);
      }
    });
  }, [sections]);

  const handleFormSubmit = async (formData, page, key) => {
    try {
      const res = await fetch(`${import.meta.env.VITE_API_URL || 'https://api.rtakabinetssolutions.com'}/api/section/${page}/${key}`, {
        method: "POST",
        body: formData,
      });

      const result = await res.json();
      console.log(`Sección ${page}/${key} guardada:`, result);

      const updatedRes = await fetch(`${import.meta.env.VITE_API_URL || 'https://api.rtakabinetssolutions.com'}/api/section/${page}/${key}`);
      const updatedData = await updatedRes.json();

      setSectionData(prev => ({
        ...prev,
        [`${page}_${key}`]: {
          title: updatedData.title,
          description: updatedData.description,
          imageUrl: updatedData.image_url
        }
      }));
    } catch (err) {
      console.error(`Error al guardar ${page}/${key}:`, err);
    }
  };

  const handleDeleteImage = (page, key) => {
    console.log(`Eliminar imagen de ${page}/${key}`);
    // Aquí podrías agregar una petición DELETE si tu backend lo soporta
  };

  return (
    <div className="p-4 sm:p-6 lg:p-8 max-w-7xl mx-auto w-full">
      <h1 className="text-2xl sm:text-3xl font-bold mb-6 text-center text-gray-800">Admin Panel - Home</h1>

      {/* Carrusel */}
      <div className="mb-6">
        <CarouselSection pageName="home" />
      </div>

      {/* Secciones */}
      <div className="space-y-10">
        {sections.map(({ page, key, label }) => {
          const dataKey = `${page}_${key}`;
          const data = sectionData[dataKey];

          return data ? (
            <div key={dataKey} className="bg-white shadow-md rounded-xl p-4 sm:p-6">
              <SectionEditorForm
                title={label}
                pageName={page}
                sectionName={key}
                initialData={data}
                onSubmit={(formData) => handleFormSubmit(formData, page, key)}
                onDeleteImage={() => handleDeleteImage(page, key)}
              />
            </div>
          ) : (
            <p key={dataKey} className="text-center text-gray-600">Loading {label}...</p>
          );
        })}
      </div>
    </div>
  );
};

export default HomeAdmin;
