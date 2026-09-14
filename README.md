# My AI System

Kişisel yapay zeka çalışma ortamı ve hafıza altyapısını birleştiren çatı (umbrella) deposu.

## Ne bu?

My AI System, iki bağımsız açık kaynaklı sistemi tek bir yapı altında birleştiren hafif bir orkestrasyon katmanıdır:

- **Hafıza Sistemi (MMS):** Obsidian vault yapısı, Claude Code kancaları, oturum hafızası, günlük kayıtlar, kullanıcı geri bildirimlerinden öğrenilen kurallar, 500 kelime dosya disiplini ve otomatik testler.
- **Ofis:** Her projenin kendi klasöründe yaşadığı çalışma ofisi, köprü `CLAUDE.md` + `AGENTS.md` sembolik bağ mimarisi, backlog/reports iş takip düzeni, Türkçe yetenek kümeleri ve 3 katmanlı ajan orkestrasyonu (Claude Code / Antigravity agy / Codex).

Bu çatı depo kod kopyalamaz; yalnızca iki depoyu çeker ve birbirine bağlar. Böylece sürümler zamanla birbirinden kaymaz.

## Mimari

```
                My AI System (Çatı Depo)
                           │
             ┌─────────────┴─────────────┐
             ▼                           ▼
    Hafıza Sistemi (MMS)                Ofis
  (Obsidian Vault + Bellek)   (Projeler + Ajan Masası)
```

Kurulum sonrası disk üzerindeki klasör yerleşimi:

```
$KOK (Varsayılan: $HOME/yapay-zeka-sistemim)
├── hafiza/           # Obsidian vault ve bellek katmanı
├── ofis/             # Projeler, iş yönetimi ve yetenekler
├── OKU.md            # İki kardeş klasörü açıklayan kılavuz
├── CLAUDE.md -> hafiza/CLAUDE.md
└── .claude   -> hafiza/.claude
```

## Kurulum

Sistemi kurmak için depoyu klonlayıp kurulum betiğini çalıştırın:

```bash
git clone https://github.com/MrMerkus/My-AI-System.git
cd My-AI-System
bash kur.sh
```

Farklı bir hedef dizine kurmak için:

```bash
KOK="$HOME/ozel-yol" bash kur.sh
```

## Tek tek kurmak isteyenler

Bileşenleri çatı olmadan ayrı ayrı incelemek veya kurmak için:

- **Hafıza Sistemi:** https://github.com/MrMerkus/MMS
- **Ofis:** https://github.com/MrMerkus/Ofis

## Gereksinimler

Temel gereksinimler:
- `git`
- `bash` (4.0+)
- `python3`
- `Claude Code`

İsteğe bağlı (önerilen):
- `Obsidian` (hafıza vault yapısını grafik arayüzle görüntülemek için)
- `agy` (Antigravity CLI)
- `codex` (OpenAI Codex CLI)

## Güvenlik notu

`kur.sh` betiği yalnızca bu dokümanda listelenen genel erişime açık depoları klonlar ve depoların kendi kurulum betiklerini yürütür. Dışarıdan bilinmeyen ikili dosyalar indirmez ve sistem dosyalarını değiştirmez. Çalıştırmadan önce betiği inceleyebilirsiniz.

## Lisans

MIT Lisansı — Detaylar için `LICENSE` dosyasına bakınız.
