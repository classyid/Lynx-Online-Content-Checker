# Lynx-Online-Content-Checker
Repository ini menyediakan script bash untuk melakukan pencarian berbasis kata kunci di beberapa domain menggunakan lynx, kemudian menghasilkan file log yang dapat diintegrasikan dengan notifikasi melalui WhatsApp dan Telegram. Script ini sangat cocok untuk mendeteksi konten yang melanggar aturan, seperti judi online, dan membantu menjaga keamanan digital.

# Kelebihan Lynx
Ringan dan Cepat: Lynx adalah browser berbasis teks yang sangat ringan sehingga cocok untuk pencarian otomatis tanpa memakan banyak resource.
Tidak Menampilkan Iklan: Karena Lynx tidak menampilkan elemen visual, Anda bisa fokus pada konten teks tanpa terganggu iklan.
Bekerja di CLI: Bisa dijalankan dari command line, menjadikannya sempurna untuk diintegrasikan dalam script otomatis.
Tidak Memerlukan GUI: Lynx dapat digunakan pada server yang tidak memiliki antarmuka grafis, sehingga cocok untuk automasi di lingkungan server.

# Integrasi WhatsApp Notifier
Menggunakan endpoint m-pedia untuk mengirim pesan WhatsApp.
Mengirim ringkasan hasil pencarian dengan pesan teks.
Bisa dikonfigurasi untuk menonaktifkan pengiriman pesan sesuai kebutuhan.

# Telegram Document 
Menggunakan Bot Telegram API untuk mengirim file hasil pencarian ke channel Telegram.
File hasil pencarian dikirim sebagai document dengan caption berisi informasi terkait kata kunci dan domain yang diperiksa.

# Konfigurasi Telegram dan WhatsApp :
ENABLE_TELEGRAM dan ENABLE_WHATSAPP memungkinkan pengguna untuk mengontrol apakah hasil pencarian akan dikirim melalui Telegram atau WhatsApp.
TELEGRAM_TOKEN, CHAT_ID, API_KEY, SENDER, dan NUMBER dapat dikonfigurasi sesuai kebutuhan pengguna untuk mengirim notifikasi.

Silakan perbarui informasi sensitif yang telah saya bersihkan (DOMAIN, TOKEN, CHAT_ID, API_KEY, dll) sesuai dengan kebutuhan Anda.
