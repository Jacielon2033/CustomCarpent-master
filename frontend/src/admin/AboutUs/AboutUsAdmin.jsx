import SectionEditorForm from '../../components/shared/SectionEditorForm';
import { useMemo, useEffect, useState } from 'react';
import CarouselSection from '../../components/shared/CarouselSection';

const AboutUsAdmin = () => {
     // ✅ Memorizar la lista de secciones para evitar que cambie en cada render
  const sections = useMemo(() => [
    { page: "aboutus", key: "ourstory", label: "Our Story" },
    { page: "aboutus", key: "mission", label: "Mission" },
    { page: "aboutus", key: "vision", label: "Vision" }
  ], []);
    
    const [sectionData, setSectionData] = useState({});

    useEffect(() => {
        sections.forEach(async ({ page, key }) => {
          try {
            const res = await fetch(`http://localhost:5000/api/section/${page}/${key}`);
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
          const res = await fetch(`http://localhost:5000/api/section/${page}/${key}`, {
            method: "POST",
            body: formData,
          });

          const result = await res.json();
      console.log(`Sección ${page}/${key} guardada:`, result);

       // Recargar datos actualizados
       const updatedRes = await fetch(`http://localhost:5000/api/section/${page}/${key}`);
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
        <>
        <div className="p-6 max-w-6xl mx-auto">
            <h1 className="text-3xl font-bold mb-8 text-center">Admin Panel - About Us</h1>
            <CarouselSection pageName="aboutus"/>
            <br/>
            {sections.map(({ page, key, label }) => {
                const dataKey = `${page}_${key}`;
                const data = sectionData[dataKey];
                return data ? (
                <SectionEditorForm
                    key={dataKey}
                    title={label}
                    pageName={page}
                    sectionName={key}
                    initialData={data}
                    onSubmit={(formData) => handleFormSubmit(formData, page, key)}
                    onDeleteImage={() => handleDeleteImage(page, key)}
                />
                ) : (
                <p key={dataKey}>Loading {label}...</p>
                );
            })}
           
        </div>
        </>
    );
};

export default AboutUsAdmin;