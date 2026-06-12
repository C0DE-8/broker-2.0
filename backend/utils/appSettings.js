const pool = require("../db");

let ensured = false;

async function ensureSettingsTable() {
  if (ensured) return;

  await pool.query(`
    CREATE TABLE IF NOT EXISTS app_settings (
      setting_key varchar(100) NOT NULL,
      setting_value varchar(255) NOT NULL,
      updated_at datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
      PRIMARY KEY (setting_key)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  `);

  ensured = true;
}

async function getSetting(key, defaultValue) {
  await ensureSettingsTable();

  const [rows] = await pool.query(
    "SELECT setting_value FROM app_settings WHERE setting_key = ? LIMIT 1",
    [key]
  );

  if (!rows.length) return defaultValue;
  return rows[0].setting_value;
}

async function setSetting(key, value) {
  await ensureSettingsTable();

  await pool.query(
    `
    INSERT INTO app_settings (setting_key, setting_value, updated_at)
    VALUES (?, ?, NOW())
    ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value), updated_at = NOW()
    `,
    [key, value]
  );
}

async function isRegistrationOtpEnabled() {
  const value = await getSetting("registration_otp_enabled", "1");
  return String(value) !== "0";
}

module.exports = {
  getSetting,
  setSetting,
  isRegistrationOtpEnabled,
};
