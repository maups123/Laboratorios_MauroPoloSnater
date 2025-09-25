-- Crear base de datos
CREATE DATABASE IF NOT EXISTS streaming_musical
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE streaming_musical;

-- ========================
-- 1. ARTISTS
-- ========================
CREATE TABLE artists (
  artist_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(50),
  primary_genre VARCHAR(50)
);

-- ========================
-- 2. ALBUMS
-- ========================
CREATE TABLE albums (
  album_id INT AUTO_INCREMENT PRIMARY KEY,
  artist_id INT NOT NULL,
  title VARCHAR(100) NOT NULL,
  release_date DATE,
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

-- ========================
-- 3. SONGS
-- ========================
CREATE TABLE songs (
  song_id INT AUTO_INCREMENT PRIMARY KEY,
  album_id INT NOT NULL,
  title VARCHAR(100) NOT NULL,
  duration_sec INT,
  genre VARCHAR(50),
  popularity INT,
  FOREIGN KEY (album_id) REFERENCES albums(album_id)
);

-- ========================
-- 4. USERS
-- ========================
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE,
  country VARCHAR(50),
  plan_name ENUM('Free','Estudiante','Individual','Familiar') NOT NULL,
  plan_price DECIMAL(5,2) NOT NULL,
  subscription_end_date DATE
);

-- ========================
-- 5. PLAYLISTS
-- ========================
CREATE TABLE playlists (
  playlist_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ========================
-- 6. PLAYLIST_SONGS (tabla puente para romper N:N)
-- ========================
CREATE TABLE playlist_songs (
  playlist_id INT NOT NULL,
  song_id INT NOT NULL,
  added_at DATETIME,
  PRIMARY KEY (playlist_id, song_id),
  FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
  FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- ========================
-- 7. ACTIVITY (historial de reproducciones y likes)
-- ========================
CREATE TABLE activity (
  activity_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  song_id INT NOT NULL,
  activity_type ENUM('PLAY','LIKE') NOT NULL,
  event_time DATETIME NOT NULL,
  seconds_played INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (song_id) REFERENCES songs(song_id)
);
