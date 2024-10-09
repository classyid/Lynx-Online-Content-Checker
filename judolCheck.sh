#!/bin/bash

# Membuat nama file berdasarkan tanggal, jam, dan detik saat ini
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
DOMAINS=(
    "DOMAIN_1"
    "DOMAIN_2"
)
KEYWORDS=(
    "Slot Online"
    "Maxwin"
    "Jackpot Slot"
)

# Konfigurasi untuk mengaktifkan atau menonaktifkan pengiriman pesan
ENABLE_TELEGRAM=true
ENABLE_WHATSAPP=false

# Token bot Telegram dan chat_id
TELEGRAM_TOKEN="YOUR_TELEGRAM_TOKEN"
CHAT_ID="YOUR_CHAT_ID"

# Mengirim pesan melalui WhatsApp menggunakan endpoint kirimwa.apps.classy.id
WA_API_URL="YOUR_WHATSAPP_API_URL"
API_KEY="YOUR_API_KEY"
SENDER="YOUR_SENDER_NUMBER"
NUMBER="YOUR_TARGET_NUMBER"

# Loop melalui setiap domain dan keyword
echo "Memulai pencarian untuk beberapa domain"
for DOMAIN in "${DOMAINS[@]}"; do
  for KEYWORD in "${KEYWORDS[@]}"; do
      # Mengganti spasi dengan '+' pada keyword untuk pencarian di Google
      SEARCH_KEYWORD="${KEYWORD// /+}"
      BASE_URL="https://www.google.com/search?q=site:$DOMAIN+$SEARCH_KEYWORD"
      OUTPUT_FILE="hasil_pencarian_${DOMAIN//./_}_${KEYWORD// /_}_$(date +%Y%m%d_%H%M%S).txt"

      # Membersihkan atau membuat file baru untuk menyimpan hasil
      : > "$OUTPUT_FILE"

      # Menambahkan informasi header dengan timestamp di awal file
      {
        echo "============================================="
        echo "          HASIL PENCARIAN GOOGLE              "
        echo "============================================="
        echo "Data diakses pada: $TIMESTAMP"
        echo "Hasil pencarian dengan kata kunci: $BASE_URL"
        echo "Sistem yang digunakan: $(uname -a)"
        echo "---------------------------------------------"
        echo ""
      } >> "$OUTPUT_FILE"

      # Mengambil hasil dari halaman pertama saja
      echo "Mengambil data dari URL: $BASE_URL"

      # Menjalankan Lynx dengan pengaturan untuk selalu menerima cookies dan menambahkan hasil ke file
      lynx -accept_all_cookies -dump "$BASE_URL" >> "$OUTPUT_FILE"

      # Memisahkan hasil dengan garis pembatas
      echo -e "\n----- Akhir dari Halaman 1 -----\n" >> "$OUTPUT_FILE"

      # Menampilkan informasi hasil
      echo "Hasil pencarian telah disimpan di file: $OUTPUT_FILE"

      # Membuat caption untuk pesan Telegram dan WhatsApp
      CAPTION="🗓️ Tanggal Akses: $TIMESTAMP\n\n📄 Hasil Pencarian Google\n\n🔍 Kata kunci: $KEYWORD pada domain: $DOMAIN\n\nUntuk informasi lebih lengkap, cek file hasil pencarian."

      # Mengirim file hasil pencarian ke bot Telegram dengan caption yang sesuai jika ENABLE_TELEGRAM=true
      if [ "$ENABLE_TELEGRAM" = true ]; then
          curl -F "chat_id=$CHAT_ID" \
               -F "caption=$CAPTION" \
               -F "document=@$OUTPUT_FILE" \
               "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument"
          # Informasi pengiriman file
          echo "File hasil pencarian telah dikirim ke bot Telegram dengan caption yang sesuai."
      fi

      # Mengirim pesan WhatsApp menggunakan curl dengan isi pesan yang sudah diringkas jika ENABLE_WHATSAPP=true
      if [ "$ENABLE_WHATSAPP" = true ]; then
          # Encode newline untuk JSON agar sesuai dengan format WhatsApp
          CAPTION_WHATSAPP="${CAPTION//$'\n'/\\n}"
          curl -X POST "$WA_API_URL" \
          -H "Content-Type: application/json" \
          -d '{
              "api_key": "'"$API_KEY"'",
              "sender": "'"$SENDER"'",
              "number": "'"$NUMBER"'",
              "message": "'"$CAPTION_WHATSAPP"'"
          }'
          # Informasi pengiriman pesan WhatsApp
          echo "Pesan WhatsApp telah dikirim melalui API"
      fi

      # Menunggu 30 detik sebelum melanjutkan ke keyword berikutnya
      sleep 30
  done
done

echo "Proses pencarian selesai untuk semua domain dan keyword."
