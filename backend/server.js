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

app.get(["/api/app-config", "/api/app-config.js"], (req, res) => {
  const apiRoot = process.env.PUBLIC_API_ROOT || "https://api.upcoinmeta.middlesvilletrusted.com/api";
  const imageRoot = process.env.PUBLIC_IMAGE_ROOT || "https://api.upcoinmeta.middlesvilletrusted.com/images";

  res.type("application/javascript").send(`
(function initAppConfig() {
  const API_ROOT = ${JSON.stringify(apiRoot)};
  const IMAGE_ROOT = ${JSON.stringify(imageRoot)};
  const trimTrailingSlash = (value) => String(value || "").replace(/\\/+$/, "");
  const withLeadingSlash = (value) => {
    const str = String(value || "").trim();
    if (!str) return "";
    return str.startsWith("/") ? str : "/" + str;
  };
  const apiRoot = trimTrailingSlash(API_ROOT);
  const imageRoot = trimTrailingSlash(IMAGE_ROOT);
  window.APP_CONFIG = Object.freeze({
    API_ROOT: apiRoot,
    IMAGE_ROOT: imageRoot,
    USERS_API_BASE: apiRoot + "/users",
    ADMIN_API_BASE: apiRoot + "/admin",
    toImageUrl(value) {
      if (!value) return null;
      const str = String(value).trim();
      if (!str) return null;
      if (/^https?:\\/\\//i.test(str)) return str;
      return imageRoot + withLeadingSlash(str);
    },
  });
})();`);
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
