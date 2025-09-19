import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import axios from 'axios';

export const fetchProducts = createAsyncThunk(
  'products/fetchProducts',
  async () => {
    const res = await axios.get(`${import.meta.env.VITE_API_URL || 'https://api.rtakabinetssolutions.com'}/api/products`);
    return res.data;
  }
);

const productsSlice = createSlice({
  name: 'products',
  initialState: {
    list: [],
    status: 'idle',
    error: null
  },
  reducers: {
    // Aquí puedes añadir otras acciones como agregar al presupuesto, etc.
  },
  extraReducers: builder => {
    builder
      .addCase(fetchProducts.pending, state => {
        state.status = 'loading';
      })
      .addCase(fetchProducts.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.list = action.payload;
      })
      .addCase(fetchProducts.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      });
  }
});

export default productsSlice.reducer;
