(function initAppConfig() {
  const API_ROOT = "https://api.upcoinmeta.middlesvilletrusted.com/api";
  const IMAGE_ROOT = "https://api.upcoinmeta.middlesvilletrusted.com/images";

  const trimTrailingSlash = (value) => String(value || "").replace(/\/+$/, "");
  const withLeadingSlash = (value) => {
    const str = String(value || "").trim();
    if (!str) return "";
    return str.startsWith("/") ? str : `/${str}`;
  };

  const apiRoot = trimTrailingSlash(API_ROOT);
  const imageRoot = trimTrailingSlash(IMAGE_ROOT);

  window.APP_CONFIG = Object.freeze({
    API_ROOT: apiRoot,
    IMAGE_ROOT: imageRoot,
    USERS_API_BASE: `${apiRoot}/users`,
    ADMIN_API_BASE: `${apiRoot}/admin`,
    toImageUrl(value) {
      if (!value) return null;
      const str = String(value).trim();
      if (!str) return null;
      if (/^https?:\/\//i.test(str)) return str;
      return `${imageRoot}${withLeadingSlash(str)}`;
    },
  });
})();
