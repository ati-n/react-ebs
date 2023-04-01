import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
    resolve: {
        extensions: [".js", ".mjs"],
    },
    plugins: [react()],
    server: {
        host: "0.0.0.0",
        port: 3000,
        hmr: {
            clientPort: 3000,
        },
        watch: {
            usePolling: true,
        },
    },
});
