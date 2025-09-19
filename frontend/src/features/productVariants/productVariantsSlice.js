import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import axios from 'axios';

import { API_ENDPOINTS } from '../../config/api.js';

export const fetchProductVariants = createAsyncThunk(
  'productVariants/fetchProductVariants',
  async () => {
    const response = await axios.get(API_ENDPOINTS.PRODUCT_VARIANTS_ADMIN);
    return response.data;
  }
);

const productVariantsSlice = createSlice({
  name: 'productVariants',
  initialState: {
    list: [],
    loading: false,
    error: null,
  },
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(fetchProductVariants.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchProductVariants.fulfilled, (state, action) => {
        state.loading = false;
        state.list = action.payload;
      })
      .addCase(fetchProductVariants.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      });
  },
});

export default productVariantsSlice.reducer;