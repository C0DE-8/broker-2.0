// server.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const path = require("path");

const adminAuthRoutes = require("./routes/admin.auth.routes");
const userRoutes = require("./routes/user.routes");

const app = express();

/* =========================================================
   ✅ SECURITY (FIXED FOR IMAGE LOADING)
   ========================================================= */
app.use(
  helmet({
    crossOriginEmbedderPolicy: false, // ❗ REQUIRED
    crossOriginResourcePolicy: { policy: "cross-origin" } // ❗ REQUIRED
  })
);

/* =========================================================
   ✅ CORS
   ========================================================= */
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"],
    allowedHeaders: ["Content-Type", "Authorization"]
  })
);

/* =========================================================
   ✅ BODY PARSERS
   ========================================================= */
app.use(express.json({ limit: "2mb" }));
app.use(express.urlencoded({ extended: true }));

/* =========================================================
   ✅ STATIC FILES (UPLOADS FIX)
   ========================================================= */
app.use(
  "/uploads",
  express.static(path.join(__dirname, "uploads"), {
    setHeaders: (res) => {
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.setHeader("Cross-Origin-Resource-Policy", "cross-origin");
    }
  })
);

/* =========================================================
   ✅ HEALTH CHECK
   ========================================================= */
app.get("/", (req, res) => {
  res.json({ ok: true, service: "Investment Platform API" });
});

/* =========================================================
   ✅ ROUTES
   ========================================================= */
app.use("/api/admin", adminAuthRoutes);
app.use("/api/users", userRoutes);

/* =========================================================
   ❌ 404 HANDLER
   ========================================================= */
app.use((req, res) => {
  res.status(404).json({ message: "Route not found" });
});

/* =========================================================
   🚀 START SERVER
   ========================================================= */
const PORT = process.env.PORT || 2080;
app.listen(PORT, () => {
  console.log(`✅ Server running at http://localhost:${PORT}`);
});
