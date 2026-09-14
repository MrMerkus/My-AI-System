#!/usr/bin/env bash
set -euo pipefail

# My AI System - Çatı Kurulum Betiği

REPO_MMS="${MAIS_REPO_MMS:-https://github.com/MrMerkus/MMS.git}"
REPO_OFFICE="${MAIS_REPO_OFFICE:-https://github.com/MrMerkus/Office.git}"

SISTEM_ADI="My AI System"
ASISTAN=""
HITAP_GUNLUK=""
HITAP_RESMI=""
HITAP_ODAK=""
KULLANICI=""
DIL="Türkçe"
BAGLAM=""
KOK="${KOK:-$HOME/yapay-zeka-sistemim}"
HAFIZA_ADI="hafiza"
OFIS_ADI="ofis"
SADECE_HAFIZA=0
SADECE_OFIS=0
EVET=0

yardim() {
  cat << 'EOF'
Kullanım: bash kur.sh [SEÇENEKLER]

My AI System çatı kurulum betiği.

Seçenekler:
  --sistem-adi <AD>     Sistem adı (Varsayılan: "My AI System")
  --asistan <AD>        Asistan adı (Zorunlu)
  --hitap-gunluk <AD>   Günlük hitap adı (Varsayılan: asistan adı)
  --hitap-resmi <AD>    Resmi hitap adı (Varsayılan: asistan adı)
  --hitap-odak <AD>     Odak modu hitap adı (Varsayılan: resmi hitap adı)
  --kullanici <AD>      Kullanıcı hitap şekli (Zorunlu)
  --dil <DİL>           Çalışma dili (Varsayılan: "Türkçe")
  --baglam <METİN>      Kullanıcı ve sistem bağlamı (Varsayılan: "")
  --kok <DİZİN>         Hedef kurulum kök dizini (Varsayılan: $HOME/yapay-zeka-sistemim)
  --hafiza-adi <AD>     Hafıza klasörü adı (Varsayılan: "hafiza")
  --ofis-adi <AD>       Ofis klasörü adı (Varsayılan: "ofis")
  --sadece-hafiza       Yalnızca Hafıza Sistemi (MMS) bileşenini kurar
  --sadece-ofis         Yalnızca Ofis bileşenini kurar
  --evet                Onay istemeden doğrudan kurulumu başlatır
  -h, --help, --yardim  Bu yardım iletisini görüntüler

Ortam Değişkenleri:
  KOK                   Hedef kurulum dizini
  MAIS_REPO_MMS         Hafıza repo adresi (gizli test modu)
  MAIS_REPO_OFFICE      Ofis repo adresi (gizli test modu)
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --sistem-adi)
      if [ $# -lt 2 ]; then echo "Hata: --sistem-adi değer gerektirir" >&2; exit 1; fi
      SISTEM_ADI="$2"; shift 2 ;;
    --sistem-adi=*)
      SISTEM_ADI="${1#*=}"; shift ;;
    --asistan)
      if [ $# -lt 2 ]; then echo "Hata: --asistan değer gerektirir" >&2; exit 1; fi
      ASISTAN="$2"; shift 2 ;;
    --asistan=*)
      ASISTAN="${1#*=}"; shift ;;
    --hitap-gunluk)
      if [ $# -lt 2 ]; then echo "Hata: --hitap-gunluk değer gerektirir" >&2; exit 1; fi
      HITAP_GUNLUK="$2"; shift 2 ;;
    --hitap-gunluk=*)
      HITAP_GUNLUK="${1#*=}"; shift ;;
    --hitap-resmi)
      if [ $# -lt 2 ]; then echo "Hata: --hitap-resmi değer gerektirir" >&2; exit 1; fi
      HITAP_RESMI="$2"; shift 2 ;;
    --hitap-resmi=*)
      HITAP_RESMI="${1#*=}"; shift ;;
    --hitap-odak)
      if [ $# -lt 2 ]; then echo "Hata: --hitap-odak değer gerektirir" >&2; exit 1; fi
      HITAP_ODAK="$2"; shift 2 ;;
    --hitap-odak=*)
      HITAP_ODAK="${1#*=}"; shift ;;
    --kullanici)
      if [ $# -lt 2 ]; then echo "Hata: --kullanici değer gerektirir" >&2; exit 1; fi
      KULLANICI="$2"; shift 2 ;;
    --kullanici=*)
      KULLANICI="${1#*=}"; shift ;;
    --dil)
      if [ $# -lt 2 ]; then echo "Hata: --dil değer gerektirir" >&2; exit 1; fi
      DIL="$2"; shift 2 ;;
    --dil=*)
      DIL="${1#*=}"; shift ;;
    --baglam)
      if [ $# -lt 2 ]; then echo "Hata: --baglam değer gerektirir" >&2; exit 1; fi
      BAGLAM="$2"; shift 2 ;;
    --baglam=*)
      BAGLAM="${1#*=}"; shift ;;
    --kok)
      if [ $# -lt 2 ]; then echo "Hata: --kok değer gerektirir" >&2; exit 1; fi
      KOK="$2"; shift 2 ;;
    --kok=*)
      KOK="${1#*=}"; shift ;;
    --hafiza-adi)
      if [ $# -lt 2 ]; then echo "Hata: --hafiza-adi değer gerektirir" >&2; exit 1; fi
      HAFIZA_ADI="$2"; shift 2 ;;
    --hafiza-adi=*)
      HAFIZA_ADI="${1#*=}"; shift ;;
    --ofis-adi)
      if [ $# -lt 2 ]; then echo "Hata: --ofis-adi değer gerektirir" >&2; exit 1; fi
      OFIS_ADI="$2"; shift 2 ;;
    --ofis-adi=*)
      OFIS_ADI="${1#*=}"; shift ;;
    --sadece-hafiza)
      SADECE_HAFIZA=1; shift ;;
    --sadece-ofis)
      SADECE_OFIS=1; shift ;;
    --evet)
      EVET=1; shift ;;
    -h|--help|--yardim)
      yardim; exit 0 ;;
    *)
      echo "Hata: Bilinmeyen seçenek: $1" >&2
      yardim >&2
      exit 1
      ;;
  esac
done

if [ "$SADECE_HAFIZA" -eq 1 ] && [ "$SADECE_OFIS" -eq 1 ]; then
  echo "Hata: --sadece-hafiza ve --sadece-ofis seçenekleri aynı anda kullanılamaz." >&2
  exit 1
fi

KUR_HAFIZA=1
KUR_OFIS=1

if [ "$SADECE_HAFIZA" -eq 1 ]; then
  KUR_OFIS=0
elif [ "$SADECE_OFIS" -eq 1 ]; then
  KUR_HAFIZA=0
fi

# Zorunlu alan kontrolü ve etkileşimli girdi alma
if [ -z "$ASISTAN" ] || [ -z "$KULLANICI" ]; then
  if [ -t 0 ]; then
    echo "=== My AI System Yapılandırma Bilgileri ==="
    echo "Lütfen kurulum için gerekli bilgileri giriniz:"
    while [ -z "$ASISTAN" ]; do
      read -r -p "Asistan adı (Zorunlu, örn: Atlas): " ASISTAN
    done
    while [ -z "$KULLANICI" ]; do
      read -r -p "Kullanıcı adı / hitap şekli (Zorunlu): " KULLANICI
    done
    if [ "$SISTEM_ADI" = "My AI System" ]; then
      read -r -p "Sistem adı [My AI System]: " girdi
      [ -n "$girdi" ] && SISTEM_ADI="$girdi"
    fi
    if [ -z "$HITAP_GUNLUK" ]; then
      read -r -p "Günlük hitap [$ASISTAN]: " girdi
      HITAP_GUNLUK="${girdi:-$ASISTAN}"
    fi
    if [ -z "$HITAP_RESMI" ]; then
      read -r -p "Resmi hitap [$ASISTAN]: " girdi
      HITAP_RESMI="${girdi:-$ASISTAN}"
    fi
    if [ -z "$HITAP_ODAK" ]; then
      read -r -p "Odak modu hitabı [${HITAP_RESMI:-$ASISTAN}]: " girdi
      HITAP_ODAK="${girdi:-${HITAP_RESMI:-$ASISTAN}}"
    fi
    if [ "$DIL" = "Türkçe" ]; then
      read -r -p "Çalışma dili [Türkçe]: " girdi
      [ -n "$girdi" ] && DIL="$girdi"
    fi
    if [ -z "$BAGLAM" ]; then
      read -r -p "Bağlam (isteğe bağlı, boş bırakılabilir): " girdi
      BAGLAM="$girdi"
    fi
    if [ "$KOK" = "$HOME/yapay-zeka-sistemim" ]; then
      read -r -p "Kök dizin [$HOME/yapay-zeka-sistemim]: " girdi
      [ -n "$girdi" ] && KOK="$girdi"
    fi
  else
    echo "Hata: Eksik zorunlu parametreler:" >&2
    [ -z "$ASISTAN" ] && echo "  --asistan <isim>" >&2
    [ -z "$KULLANICI" ] && echo "  --kullanici <isim>" >&2
    exit 1
  fi
fi

HITAP_GUNLUK="${HITAP_GUNLUK:-$ASISTAN}"
HITAP_RESMI="${HITAP_RESMI:-$ASISTAN}"
HITAP_ODAK="${HITAP_ODAK:-$HITAP_RESMI}"

KOK="$(python3 -c "import os, sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))" "$KOK")"

if [ "$KUR_HAFIZA" -eq 1 ]; then
  HAFIZA="$KOK/$HAFIZA_ADI"
else
  HAFIZA=""
fi

if [ "$KUR_OFIS" -eq 1 ]; then
  OFIS="$KOK/$OFIS_ADI"
else
  OFIS=""
fi

if [ "$EVET" -eq 0 ]; then
  echo ""
  echo "=== My AI System Kurulum Özeti ==="
  echo "Sistem Adı     : $SISTEM_ADI"
  echo "Asistan Adı    : $ASISTAN"
  echo "Günlük Hitap   : $HITAP_GUNLUK"
  echo "Resmi Hitap    : $HITAP_RESMI"
  echo "Odak Hitabı    : $HITAP_ODAK"
  echo "Kullanıcı      : $KULLANICI"
  echo "Dil            : $DIL"
  [ -n "$BAGLAM" ] && echo "Bağlam         : $BAGLAM"
  echo "Kök Dizin      : $KOK"
  if [ "$KUR_HAFIZA" -eq 1 ]; then
    echo "Hafıza Dizini  : $HAFIZA"
  else
    echo "Hafıza         : Kurulmayacak (--sadece-ofis)"
  fi
  if [ "$KUR_OFIS" -eq 1 ]; then
    echo "Ofis Dizini    : $OFIS"
  else
    echo "Ofis           : Kurulmayacak (--sadece-hafiza)"
  fi
  echo ""
  read -r -p "Devam edilsin mi? [e/H]: " ONAY || ONAY=""
  case "$ONAY" in
    [eE]|[eE][vV][eE][tT]|y|Y|yes|YES)
      ;;
    *)
      echo "Kurulum iptal edildi."
      exit 0
      ;;
  esac
fi

echo ""
echo "=== My AI System Kurulumu Başlatılıyor ==="
echo "Hedef Dizin (KOK): $KOK"
mkdir -p "$KOK"

CONFIG_DIR="$HOME/.config/my-ai-system"
mkdir -p "$CONFIG_DIR"
SISTEM_JSON="$CONFIG_DIR/sistem.json"
ZAMAN_DAMGASI="$(date +%Y%m%d-%H%M%S)"
YEDEK_DIZINI="$CONFIG_DIR/yedek-$ZAMAN_DAMGASI"

yedek_al() {
  local kaynak="$1"
  local ad="${2:-$(basename "$kaynak")}"
  if [ -e "$kaynak" ] || [ -L "$kaynak" ]; then
    mkdir -p "$YEDEK_DIZINI"
    echo ">> Yedekleniyor: $kaynak -> $YEDEK_DIZINI/$ad"
    cp -a "$kaynak" "$YEDEK_DIZINI/$ad"
  fi
}

if [ -f "$SISTEM_JSON" ]; then
  echo ">> Mevcut sistem.json yedekleniyor: $SISTEM_JSON.yedek-$ZAMAN_DAMGASI"
  cp "$SISTEM_JSON" "$SISTEM_JSON.yedek-$ZAMAN_DAMGASI"
fi

python3 - "$SISTEM_JSON" "$SISTEM_ADI" "$ASISTAN" "$HITAP_GUNLUK" "$HITAP_RESMI" "$HITAP_ODAK" "$KULLANICI" "$DIL" "$BAGLAM" "$KOK" "$HAFIZA" "$OFIS" << 'EOF_PYTHON'
import sys, json

target = sys.argv[1]
data = {
    "sistem_adi": sys.argv[2],
    "asistan_adi": sys.argv[3],
    "hitap_gunluk": sys.argv[4],
    "hitap_resmi": sys.argv[5],
    "hitap_odak": sys.argv[6],
    "kullanici": sys.argv[7],
    "dil": sys.argv[8],
    "baglam": sys.argv[9],
    "kok": sys.argv[10],
    "hafiza": sys.argv[11] if sys.argv[11] else None,
    "ofis": sys.argv[12] if sys.argv[12] else None,
    "surum": 1
}

with open(target, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
    f.write("\n")
EOF_PYTHON
echo ">> Yapılandırma dosyası kaydedildi: $SISTEM_JSON"

# 1. Hafıza Sistemi Klonlama ve Yapılandırma
if [ "$KUR_HAFIZA" -eq 1 ]; then
  if [ -d "$HAFIZA" ]; then
    echo ">> Hafıza dizini zaten mevcut: $HAFIZA (klonlama atlandı)"
  else
    echo ">> Hafıza Sistemi klonlanıyor: $REPO_MMS -> $HAFIZA..."
    git clone "$REPO_MMS" "$HAFIZA"
    git -C "$HAFIZA" remote remove origin
    echo ">> Güvenlik için genel kalıp uzak deposu (origin) kaldırıldı; kişisel yedekleriniz genel depoya gitmeyecek."
  fi

  if [ -f "$HAFIZA/kurulum/yapilandir.py" ]; then
    echo ">> Hafıza yapılandırma betiği çalıştırılıyor..."
    python3 "$HAFIZA/kurulum/yapilandir.py" --ayarlar "$SISTEM_JSON" --hedef "$HAFIZA"
  elif [ -f "$HAFIZA/kur.sh" ]; then
    echo ">> Hafıza kurulum betiği (kur.sh) çalıştırılıyor..."
    bash "$HAFIZA/kur.sh"
  elif [ -f "$HAFIZA/install.sh" ]; then
    echo ">> Hafıza kurulum betiği (install.sh) çalıştırılıyor..."
    bash "$HAFIZA/install.sh"
  fi
fi

# 2. Ofis Klonlama ve Kurulum
if [ "$KUR_OFIS" -eq 1 ]; then
  # ~/.claude altında değişiklik yapılmadan önce mevcut hedef dizinleri yedekle
  if [ -d "$HOME/.claude" ]; then
    yedek_al "$HOME/.claude" "claude"
  fi

  if [ -d "$OFIS/.git" ]; then
    echo ">> Ofis dizini zaten mevcut: $OFIS"
  elif [ -d "$OFIS" ]; then
    echo ">> Uyarı: Ofis dizini zaten mevcut ancak git deposu değil: $OFIS (klonlama atlandı)"
  else
    echo ">> Ofis klonlanıyor: $REPO_OFFICE -> $OFIS..."
    git clone "$REPO_OFFICE" "$OFIS"
    if git -C "$OFIS" remote | grep -q "^origin$"; then
      git -C "$OFIS" remote rename origin upstream
      echo ">> Ofis uzak deposu (origin) 'upstream' olarak yeniden adlandırıldı."
    fi
  fi

  if [ -f "$OFIS/kur.sh" ]; then
    echo ">> Ofis kurulum betiği çalıştırılıyor..."
    OFIS="$OFIS" HAFIZA="$HAFIZA" bash "$OFIS/kur.sh"
  fi
fi

# 3. Kök Dizin Sembolik Bağları
if [ "$KUR_HAFIZA" -eq 1 ]; then
  if [ -f "$HAFIZA/CLAUDE.md" ]; then
    mevcut_hedef="$(readlink "$KOK/CLAUDE.md" 2>/dev/null || true)"
    if [ "$mevcut_hedef" = "$HAFIZA_ADI/CLAUDE.md" ]; then
      echo ">> Sembolik bağ zaten güncel: $KOK/CLAUDE.md -> $HAFIZA_ADI/CLAUDE.md"
    else
      if [ -e "$KOK/CLAUDE.md" ] || [ -L "$KOK/CLAUDE.md" ]; then
        yedek_al "$KOK/CLAUDE.md" "CLAUDE.md"
        rm -rf "$KOK/CLAUDE.md"
      fi
      echo ">> Sembolik bağ oluşturuluyor: $KOK/CLAUDE.md -> $HAFIZA_ADI/CLAUDE.md"
      ln -s "$HAFIZA_ADI/CLAUDE.md" "$KOK/CLAUDE.md"
    fi
  fi

  if [ -d "$HAFIZA/.claude" ]; then
    mevcut_hedef="$(readlink "$KOK/.claude" 2>/dev/null || true)"
    if [ "$mevcut_hedef" = "$HAFIZA_ADI/.claude" ]; then
      echo ">> Sembolik bağ zaten güncel: $KOK/.claude -> $HAFIZA_ADI/.claude"
    else
      if [ -e "$KOK/.claude" ] || [ -L "$KOK/.claude" ]; then
        yedek_al "$KOK/.claude" "dot-claude-kok"
        rm -rf "$KOK/.claude"
      fi
      echo ">> Sembolik bağ oluşturuluyor: $KOK/.claude -> $HAFIZA_ADI/.claude"
      ln -s "$HAFIZA_ADI/.claude" "$KOK/.claude"
    fi
  fi
fi

# 4. OKU.md Dosyası Oluşturma
echo ">> $KOK/OKU.md oluşturuluyor..."
cat << EOF > "$KOK/OKU.md"
# $SISTEM_ADI

Bu dizin ($KOK), kişisel yapay zeka çalışma ortamınızın ana kök dizinidir.

## Klasör Yapısı
EOF

if [ "$KUR_HAFIZA" -eq 1 ]; then
  cat << EOF >> "$KOK/OKU.md"
- **$HAFIZA_ADI/**: Kişisel hafıza sistemi. Obsidian vault yapısı, günlük kayıtlar, oturum geçmişi ve öğrenilen kuralları barındırır.
EOF
fi

if [ "$KUR_OFIS" -eq 1 ]; then
  cat << EOF >> "$KOK/OKU.md"
- **$OFIS_ADI/**: Çalışma ofisi. Projeler, iş takip dosyaları (backlog/reports), Türkçe yetenekler ve ajan orkestrasyon masasını içerir.
EOF
fi

cat << EOF >> "$KOK/OKU.md"

## Kullanım

Ana dizinde ($KOK) Claude Code oturumu açtığınızda (\`cd "$KOK" && claude\`), sembolik bağlar ve sistem yapılandırması sayesinde tüm çalışma ortamına doğrudan erişebilirsiniz.
EOF

# 5. Kurulum Özeti ve Sonraki Adımlar
echo ""
echo "========================================================"
echo "  My AI System Kurulumu Başarıyla Tamamlandı!"
echo "========================================================"
echo "Kök Dizin  : $KOK"
[ "$KUR_HAFIZA" -eq 1 ] && echo "Hafıza     : $HAFIZA"
[ "$KUR_OFIS" -eq 1 ] && echo "Ofis       : $OFIS"
echo "Ayarlar    : $SISTEM_JSON"
echo ""
echo "Sonraki Adımlar:"
echo "1. Bu oturumu kapatıp kök dizinde Claude Code başlatın:"
echo "   cd \"$KOK\" && claude"
if [ "$KUR_HAFIZA" -eq 1 ]; then
  echo "2. İlk oturumda asistanınızın soru sormasına izin vererek"
  echo "   '🔮 zihin/Çekirdek.md' dosyasını doldurmasını sağlayın."
  echo "3. Hafıza sisteminizi yedeklemek için özel (private) bir git deposu açıp bağlayın:"
  echo "   git -C \"$HAFIZA\" remote add origin <ozel-repo-adresi>"
fi
echo "4. İsteğe bağlı ek CLI araçları: agy (Antigravity), codex (OpenAI Codex)"
echo ""
echo "Detaylı bilgi için '$KOK/OKU.md' dosyasını inceleyebilirsiniz."
