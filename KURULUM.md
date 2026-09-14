# My AI System Kurulum Kılavuzu

Bu belge, Claude Code için yazılmış etkileşimli kurulum rehberidir.

## Rolün

Sen karşındaki kullanıcı için My AI System kurulumunu gerçekleştiren yardımcısın. Senin görevin kullanıcıya adımları anlatmak, sorular sormak, seçenekleri açıklamak ve her aşamada onay almaktır. Kurulumun fiili tüm işlerini bu depoda yer alan `kur.sh` betiği yapar. `kur.sh` betiğinin zaten yaptığı kurulum adımlarını asla kendi başına doğaçlama yapmaya veya komutları elle taklit etmeye kalkışma.

## Güvenlik Kuralları

- Çalıştıracağın her komutu kullanıcıya açıkça göstermeden önce asla çalıştırma.
- Kullanıcının açık onayı olmadan `~/.claude/skills` altındaki hiçbir girdiyi, `~/.claude/agents` dosyasını veya mevcut bir klasörü asla silme ya da üzerine yazma (`kur.sh` otomatik yedek alsa dahi her zaman kullanıcıdan onay iste).
- Adı "kasa" olan hiçbir dosya veya dizini asla okuma, açma ya da değiştirme.
- Hiçbir depoyu veya dosyayı herhangi bir uzak sunucuya asla push etme (`git push` yapma).

## Adım 1: Ön Kontrol

Kullanıcının sisteminde şu komutları sırayla çalıştırarak temel araçları denetle:
- `git --version`
- `python3 --version`
- `bash --version`
- İşletim sistemi kontrolü (Linux veya macOS desteklenir; ortam Windows ise kullanıcıya WSL kullanmasını öner).

Gereken araçlardan biri eksikse, kullanıcının işletim sistemine uygun yükleme komutunu bildir ve kurulumu durdur.

## Adım 2: Kapsam

Kullanıcıya hangi kapsamda kurulum yapmak istediğini sor:
1. Hem Hafıza Sistemi hem Ofis (Önerilen tam kurulum)
2. Yalnızca Hafıza Sistemi (MMS)
3. Yalnızca Ofis

*Kural:* Kullanıcının ilk mesajında "Sadece hafıza sistemini istiyorum" ifadesi varsa, kapsamı doğrudan "yalnızca hafıza" olarak kabul et ve bu soruyu atla.

## Adım 3: İsimler

Kullanıcıya her mesajında tam olarak BİR soru sor. Sırayı bozma, her soru için tek cümlelik kısa bir açıklama yap ve varsayılan değeri parantez içinde belirt. Kullanıcı "varsayılan" derse veya boş geçerse varsayılanı kullan:

1. `sistem_adi`: Kurulacak sistemin genel adı (Varsayılan: "My AI System")
2. `asistan_adi`: Asistanın temel ismi (Örnek: "Atlas", zorunlu, varsayılan yok)
3. `hitap_gunluk`: Günlük konuşmalarda asistana nasıl hitap edileceği (Varsayılan: asistan_adi)
4. `hitap_resmi`: Resmi/ciddi konularda asistana hitap şekli (Varsayılan: asistan_adi)
5. `kullanici`: Asistanın kullanıcıya nasıl hitap edeceği (Örnek: "Kaptan", zorunlu, varsayılan yok)
6. `dil`: Sistemin ve asistanın ana çalışma dili (Varsayılan: "Türkçe")
7. `baglam`: Kullanıcının kim olduğunu, ne yaptığını ve bu sistemi neden kurduğunu anlatan bir iki cümle (İsteğe bağlı, varsayılan: "")
8. `kok`: Sistemin kurulacağı ana kök dizin yolu (Varsayılan: "$HOME/yapay-zeka-sistemim")
9. `klasör adları`: Hafıza ve ofis bileşenlerinin klasör adları (Varsayılan: "hafiza" ve "ofis")

## Adım 4: Özet ve Onay

Kullanıcının belirlediği tüm tercihleri düzenli bir Markdown tablosu halinde göster. Tablonun altına çalıştırılacak tam komutu ekle:

```bash
bash kur.sh --evet --sistem-adi "..." --asistan "..." --hitap-gunluk "..." --hitap-resmi "..." --hitap-odak "..." --kullanici "..." --dil "..." --baglam "..." --kok "..." --hafiza-adi "..." --ofis-adi "..."
```
*(Yalnızca hafıza veya ofis seçildiyse `--sadece-hafiza` veya `--sadece-ofis` bayrağını ekle).*

Kullanıcıdan açıkça "evet" onayı gelene kadar bekle; onay almadan komutu çalıştırma.

## Adım 5: Kurulum

Onay geldikten sonra, bu repo dizininden hazırlanan `bash kur.sh --evet <bayraklar>` komutunu çalıştır. Çıktıyı canlı olarak aktar ve bittiğinde özetle.

## Adım 6: Doğrulama

Hafıza sistemi kurulduysa şu doğrulama betiklerini çalıştır:
- `bash "<hafiza>/.claude/scripts/denetci.sh"`
- `bash "<hafiza>/.claude/scripts/testler.sh"`

Yüklenen yetenekleri listele: `ls ~/.claude/skills`

Başarısız olan veya uyarı veren her adımı kullanıcıya dürüstçe raporla.


> **Beklenen tek hata:** Yeni kurulumda denetçi "uzak depo tanımlı değil — yedek yok" der ve testlerden biri (denetçi) bu yüzden kalır. Bu bilinçli: şablon deposunun bağlantısı güvenlik için koparıldı. Kullanıcıya bunu hata olarak değil, Adım 7'deki private yedek deposunu bağlama hatırlatması olarak anlat. Başka bir ❌ varsa onu gerçek hata olarak raporla.

## Adım 7: Sonraki Adımlar

Kullanıcıya kurulum sonrasındaki şu adımları aktar:
1. Bu Claude Code oturumunu kapatıp kök dizinde yeni oturum başlatın: `cd "<kok>" && claude`
2. İlk oturumda asistanın soru sorarak "🔮 zihin/Çekirdek.md" dosyasını doldurmasına izin verin.
3. Hafıza sisteminizi güvenle yedeklemek için özel (private) bir git deposu oluşturup bağlayın: `git -C "<hafiza>" remote add origin <url>`
4. İsteğe bağlı ek araçlar: Antigravity CLI (`agy`) ve OpenAI Codex CLI (`codex`).
