/** Vite 개발 서버와 React 변환 설정입니다. */
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
});
