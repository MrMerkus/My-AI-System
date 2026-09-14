# My AI System

Kişisel yapay zeka çalışma ortamı ve hafıza altyapısını birleştiren çatı (umbrella) deposu.

## Kurulum (1 dakika)

Claude Code'a doğrudan şu cümleyi yapıştırın:

> https://github.com/MrMerkus/My-AI-System deposundaki KURULUM.md dosyasını oku ve beni kur.

Claude Code sizinle adım adım konuşarak sistemi yapılandıracak ve kurulumu tamamlayacaktır.

### Elle kurmak isteyenler

Terminal üzerinden doğrudan kurmak için:

```bash
git clone https://github.com/MrMerkus/My-AI-System.git
cd My-AI-System
bash kur.sh
```

Özelleştirilmiş parametrelerle çalıştırmak için `bash kur.sh --yardim` komutunu inceleyebilirsiniz.

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

Kurulum sırasında yapılan tüm yapılandırma tercihleri `~/.config/my-ai-system/sistem.json` dosyasında saklanır. Disk üzerindeki klasör yerleşimi:

```
$KOK (Varsayılan: $HOME/yapay-zeka-sistemim)
├── hafiza/           # Obsidian vault ve bellek katmanı
├── ofis/             # Projeler, iş yönetimi ve yetenekler
├── OKU.md            # İki kardeş klasörü açıklayan kılavuz
├── CLAUDE.md -> hafiza/CLAUDE.md
└── .claude   -> hafiza/.claude
```

## Tek tek kurmak isteyenler

Bileşenleri çatı olmadan ayrı ayrı incelemek veya kurmak için:

- **Hafıza Sistemi:** https://github.com/MrMerkus/MMS
- **Ofis (Office):** https://github.com/MrMerkus/Office

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

`kur.sh` betiği yalnızca bu dokümanda listelenen genel erişime açık depoları klonlar ve depoların kendi kurulum betiklerini yürütür. Yapılan değişiklikler öncesinde `~/.config/my-ai-system/` altında otomatik yedek alınır. Dışarıdan bilinmeyen ikili dosyalar indirilmez ve sistem dosyaları değiştirilmez.

## Lisans

MIT Lisansı — Detaylar için `LICENSE` dosyasına bakınız.
