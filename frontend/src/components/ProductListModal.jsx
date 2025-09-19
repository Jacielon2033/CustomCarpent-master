import { useState, useMemo } from "react";

const PAGE_SIZE = 10;

const ProductListModal = ({
    products,
    onClose,
    onEdit,
    onDelete,
    show,
}) => {
    const [search, setSearch] = useState("");
    const [page, setPage] = useState(1);

    // Filtered and paginatted products
    const filtered = useMemo(() =>
            products.filter(p =>
            p.name.toLowerCase().includes(search.toLowerCase())
            ), [products, search]
        );
        const totalPages = Math.ceil(filtered.length / PAGE_SIZE);
        const paginated = filtered.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE);
        if (!show) return null;

        return (

            
            <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40">
                <div className="bg-white rounded-lg shadow-lg max-w-2xl w-full p-6 relative">
                    <button className="absolute top-2 right-2 text-xl font-bold" 
                    onClick={onClose}
                >x</button>
                    <h2 className="text-xl font-bold mb-4">Product List</h2>
                    <input
                        className="w-full border p-2 mb-4 rounded"
                        placeholder="Search products..."
                        value={search}
                        onChange={e => { setSearch(e.target.value); setPage(1); }}
                    />
                    <ul className="divide-y max-h-96 overflow-y-auto">
                        {paginated.map(product => (
                            <li key={product.id} className="flex items-center justify-between py-2">
                                <div className="flex items-center">
                                    {product.image_path && (
                                        <img 
                                            src={`${import.meta.env.VITE_API_URL || 'https://api.rtakabinetssolutions.com'}${product.image_path}`}
                                            alt={product.name}
                                            className="w-12 h-12 object-cover rounded border" 
                                        />
                                    )}
                                    <span>{product.name}</span>
                                </div>
                                <div>
                                    <button
                                        className="bg-yellow-400 text-white px-2 py-1 rounded mr-2"
                                        onClick={() => onEdit(product)}
                                    >
                                        Edit
                                    </button>
                                    <button
                                        className="bg-red-600 text-white px-2 py-1 rounded"
                                        onClick={() => onDelete(product.id)}
                                    >
                                        Delete
                                    </button>
                                </div>
                            </li>
                        ))}
                    </ul>
                    <div className="flex justify-between items-center mt-4">
                        <button
                            className="px-3 py-1 rounded bg-gray-200"
                            disabled={page === totalPages}
                            onClick={() => setPage(p => p + 1)}
                        >Next</button>
                    </div>
                </div>
            </div>
        );
    };

export default ProductListModal;