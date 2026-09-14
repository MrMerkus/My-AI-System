#!/usr/bin/env bash
set -euo pipefail

# My AI System - Çatı Kurulum Betiği

KOK="${KOK:-$HOME/yapay-zeka-sistemim}"
SADECE_HAFIZA=0
SADECE_OFIS=0

yardim() {
  cat << 'EOF'
Kullanım: bash kur.sh [SEÇENEKLER]

My AI System çatı kurulum betiği.

Seçenekler:
  --sadece-hafiza    Yalnızca Hafıza Sistemi (MMS) bileşenini kurar
  --sadece-ofis      Yalnızca Ofis bileşenini kurar
  -h, --help, --yardim  Bu yardım iletisini görüntüler

Ortam Değişkenleri:
  KOK                Hedef kurulum dizini (Varsayılan: $HOME/yapay-zeka-sistemim)
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --sadece-hafiza)
      SADECE_HAFIZA=1
      shift
      ;;
    --sadece-ofis)
      SADECE_OFIS=1
      shift
      ;;
    -h|--help|--yardim)
      yardim
      exit 0
      ;;
    *)
      echo "Hata: Bilinmeyen seçenek: $1" >&2
      yardim >&2
      exit 1
      ;;
  esac
done

KUR_HAFIZA=1
KUR_OFIS=1

if [ "$SADECE_HAFIZA" -eq 1 ] && [ "$SADECE_OFIS" -eq 0 ]; then
  KUR_OFIS=0
elif [ "$SADECE_OFIS" -eq 1 ] && [ "$SADECE_HAFIZA" -eq 0 ]; then
  KUR_HAFIZA=0
fi

echo "=== My AI System Kurulumu Başlatılıyor ==="
echo "Hedef Dizin (KOK): $KOK"
mkdir -p "$KOK"

klonla_veya_guncelle() {
  local repo_url="$1"
  local hedef_dizin="$2"
  local repo_adi="$3"

  if [ -d "$hedef_dizin/.git" ]; then
    echo ">> Güncelleniyor: $repo_adi ($hedef_dizin)..."
    git -C "$hedef_dizin" pull --ff-only
  elif [ -d "$hedef_dizin" ]; then
    echo ">> Uyarı: Dizin zaten mevcut ancak git deposu değil: $hedef_dizin (atlanıyor)"
  else
    echo ">> Klonlanıyor: $repo_adi -> $hedef_dizin..."
    git clone "$repo_url" "$hedef_dizin"
  fi
}

# 1. Depoları klonla veya güncelle
if [ "$KUR_HAFIZA" -eq 1 ]; then
  klonla_veya_guncelle "https://github.com/MrMerkus/MMS.git" "$KOK/hafiza" "Hafıza Sistemi"
fi

if [ "$KUR_OFIS" -eq 1 ]; then
  klonla_veya_guncelle "https://github.com/MrMerkus/Ofis.git" "$KOK/ofis" "Ofis"
fi

# 2. Ofis kurulum betiği varsa çalıştır
if [ "$KUR_OFIS" -eq 1 ] && [ -f "$KOK/ofis/kur.sh" ]; then
  echo ">> Ofis kurulum betiği çalıştırılıyor..."
  OFIS="$KOK/ofis" HAFIZA="$KOK/hafiza" bash "$KOK/ofis/kur.sh"
fi

# 3. Hafıza kurulum betiği varsa çalıştır, yoksa yönergeleri yazdır
if [ "$KUR_HAFIZA" -eq 1 ]; then
  hafiza_kuruldu=0
  if [ -f "$KOK/hafiza/kur.sh" ]; then
    echo ">> Hafıza Sistemi kurulum betiği (kur.sh) çalıştırılıyor..."
    bash "$KOK/hafiza/kur.sh"
    hafiza_kuruldu=1
  elif [ -f "$KOK/hafiza/install.sh" ]; then
    echo ">> Hafıza Sistemi kurulum betiği (install.sh) çalıştırılıyor..."
    bash "$KOK/hafiza/install.sh"
    hafiza_kuruldu=1
  fi

  if [ "$hafiza_kuruldu" -eq 0 ]; then
    echo ""
    echo ">> Hafıza Sistemi için başlangıç adımları:"
    echo "   1. Obsidian uygulamasında '$KOK/hafiza' dizinini vault olarak açın."
    echo "   2. Claude Code oturumunu ana dizinden başlatın:"
    echo "      cd \"$KOK\" && claude"
    echo ""
  fi
fi

# 4. OKU.md dosyasını eksikse oluştur
if [ ! -f "$KOK/OKU.md" ]; then
  echo ">> $KOK/OKU.md oluşturuluyor..."
  cat << 'EOF' > "$KOK/OKU.md"
# My AI System

Bu dizin, kişisel yapay zeka çalışma ortamınızın ana kök dizinidir.

## Kardeş Klasörler

- **hafiza/**: Kişisel hafıza sistemi. Obsidian vault yapısı, günlük kayıtlar, oturum geçmişi ve öğrenilen kuralları barındırır.
- **ofis/**: Çalışma ofisi. Projeler, iş takip dosyaları (backlog/reports), Türkçe yetenekler ve ajan orkestrasyon masasını içerir.

## Kullanım

Ana dizinde (`$KOK`) Claude Code oturumu açtığınızda, sembolik bağlar sayesinde hem hafıza hem de ofis altyapısına doğrudan erişebilirsiniz.
EOF
fi

# 5. Sembolik bağlar (hafiza/CLAUDE.md ve hafiza/.claude mevcutsa)
if [ -e "$KOK/hafiza/CLAUDE.md" ] && [ ! -e "$KOK/CLAUDE.md" ] && [ ! -L "$KOK/CLAUDE.md" ]; then
  echo ">> Sembolik bağ oluşturuluyor: $KOK/CLAUDE.md -> hafiza/CLAUDE.md"
  ln -s "hafiza/CLAUDE.md" "$KOK/CLAUDE.md"
fi

if [ -e "$KOK/hafiza/.claude" ] && [ ! -e "$KOK/.claude" ] && [ ! -L "$KOK/.claude" ]; then
  echo ">> Sembolik bağ oluşturuluyor: $KOK/.claude -> hafiza/.claude"
  ln -s "hafiza/.claude" "$KOK/.claude"
fi

# 6. Kurulum özeti
echo ""
echo "=== Kurulum Tamamlandı ==="
echo "Konum: $KOK"
if [ "$KUR_HAFIZA" -eq 1 ]; then
  echo "- Hafıza: $KOK/hafiza"
fi
if [ "$KUR_OFIS" -eq 1 ]; then
  echo "- Ofis:   $KOK/ofis"
fi
echo ""
echo "Detaylı bilgi için '$KOK/OKU.md' dosyasını okuyabilirsiniz."
