# Araç uyumluluğu

My AI System Claude Code için yazıldı, ama hedef her yapay zekâ kodlama aracında çalışması.
Sistemin üç katmanı var ve her araçta hepsi aynı derinlikte çalışmaz:

- **Kurallar:** `CLAUDE.md` (Codex `AGENTS.md`, Gemini tabanlı araçlar `GEMINI.md` okur).
- **Skill'ler:** `SKILL.md` klasörleri.
- **Otomatik hafıza:** oturum başında bağlamı yükleyen, sonunda özet yazan, dosya tavanını sayan
  ve yedek alan hook'lar. Hook'u olmayan araçta hafıza kuralları yalnızca yazılı kalır ve zamanla
  terk edilir; bu yüzden "tam destek" hook ister.

## Bugünkü durum (2026-09)

| Araç | Kurallar | Skill'ler | Otomatik hafıza | Durum |
| --- | --- | --- | --- | --- |
| Claude Code | ✅ | ✅ | ✅ | **Çalışıyor**, kurulum bununla test edildi |
| Codex CLI | ✅ `AGENTS.md` | ✅ | 🟡 oturum başı/sonu var; dosya tavanı ve kapanış script'leri henüz bağlı değil | **Kısmi**, köprü hafıza deposunda (`render_codex_hooks.py`) |
| Antigravity (agy) | ✅ | ✅ | 🟡 oturum başı ve kapanış köprüyle; dosya tavanı henüz bağlı değil | **Kısmi**, köprü hafıza deposunda (`antigravity_hooks.py`) |
| Gemini CLI | ✅ `GEMINI.md` | ✅ | Hook'ları uygun (SessionStart/SessionEnd), bağlantı yazılmadı | **Planlandı** |
| Cursor | ✅ `AGENTS.md` | ✅ | Hook'ları uygun (sessionStart/sessionEnd/preCompact), bağlantı yazılmadı | **Planlandı** |
| Copilot, Windsurf, Kiro, Factory Droid, OpenCode, Amp, Cline | çoğu `AGENTS.md` okur | çoğu destekler | Kontrol edilmedi | **Doğrulanmadı** |
| Zed, Aider | ✅ | ❌ | ❌ | **Yalnızca kurallar** |

Gemini CLI ve Cursor satırları resmi hook dokümanlarından doğrulandı; "Doğrulanmadı" satırları
için katkı ve düzeltme memnuniyetle karşılanır.

## Yol haritası

1. Kurulumda `AGENTS.md` ve `GEMINI.md` dosyaları `CLAUDE.md`'ye bağlanacak; kurulum hangi
   araçları kullandığını soracak.
2. Codex ve Antigravity köprülerine dosya tavanı ve kapanış script'leri eklenecek.
3. Gemini CLI ve Cursor için hook bağlantısı yazılacak.
4. Diğer araçların hook desteği resmi dokümanlardan doğrulanıp tablo güncellenecek.
