# PREMIUM V2 / WHAT CHANGED

- Eight live premium themes: Summit, Minimal, Vibrant, Noir, Coast, Atelier, Academia, Royal.
- Four steps: template, identity, links/portfolio, review & publish.
- A fully rebuilt dark luxury editor with responsive live phone preview and photo uploads.
- Local draft saving, standalone HTML export and optional Supabase accounts/public publishing retained.
- `NEXORA_Standalone.html` is a convenient single-file demo: rename it to `index.html` if using it alone. For cloud accounts and editing, use the full multi-file project.
- `premium.css` is a required additional stylesheet in the multi-file version; upload it alongside `styles.css`.
- Public publishing and unique cross-device URLs require valid Supabase credentials and the SQL schema. The static demo does not publish pages globally.
- Never store secret keys in GitHub or browser source. Only public Supabase publishable/anon key is intended for the client.

---

# NEXORA SIGNATURE STUDIO — PREMIUM V2 (2026)

**نموذج أولي عملي لمنصة ذاتية الخدمة لإنشاء صفحات LinkBio متخصصة، مصمم للاستخدام على GitHub وVercel.**

## 1) ما الذي يعمل الآن؟

- صفحة تعريف تسويقية + أربع هويات مختلفة: Academic Signature / Business Atelier / Creator Pulse / Community Noor.
- استمارة من 4 مراحل (هوية، ألوان ومظهر، روابط ومحتوى) ومعاينة تتغير فور الكتابة.
- إضافة وحذف روابط اجتماعية وروابط رئيسية، وأعمال أو أبحاث مميزة.
- رفع صورة أو شعار مع ضغطها محليًا، أو إضافة رابط صورة HTTPS.
- حفظ المسودات محليًا في المتصفح، ولوحة إدارة لتعديلها وحذفها وتصدير HTML مستقل.
- اختيار لغة واجهة المحرّر (العربية، الفرنسية، الإنجليزية) وتحديد لغة الصفحة المنشورة.
- **بعد توصيل Supabase**: حسابات دخول عبر بريد إلكتروني، حفظ سحابي، صلاحيات وصول على مستوى قاعدة البيانات، نشر صفحة `https://domain/p/slug` عامة، وQR.
- صفحات الهوية العامة تستعمل روابط HTTPS موثوقة، وحقل محتوى النبذة يُعرض كنص وليس HTML خام.

## 2) انشر وضع التجربة أولًا

1. أنشئ مستودع GitHub جديد باسم `nexora-studio`.
2. فك ضغط ملف `NEXORA_Signature_Studio_V2.zip` وارفع **محتويات المجلد** إلى جذر المستودع: `index.html`, `styles.css`, `app.js`, `config.js`, `vercel.json`... إلخ.
3. افتح Vercel واختر **Add New → Project**، ثم استورد المستودع.
4. اختر Framework **Other** واترك Build Command فارغًا (موقع ثابت)، وتأكد من أن Root Directory هي `./`.
5. اضغط Deploy وافتح الرابط النهائي.
6. اختر تصميمًا من الصفحة الرئيسية، وجرّب إنشاء صفحة، وحفظها من «حفظ مسودة»، وتعديلها عبر «لوحتي».

**في وضع التجربة، بيانات الصفحات مخزنة في متصفحك فقط. الرابط `/p/slug` يعرض معاينة محلية مع تحذير؛ لن يستطيع الزائر رؤيتها من جهاز آخر.** يمكن تصدير صفحة HTML مستقلة وإعادة نشرها يدويًا على استضافة منفصلة.

## 3) فعل الحسابات والنشر العام الحقيقي (Supabase)

1. أنشئ مشروعًا في https://supabase.com/dashboard.
2. اذهب إلى **SQL Editor → New Query**. افتح ملف `supabase-schema.sql` والصق محتواه، ثم Run.
3. من **Project Settings → API** انسخ **Project URL** و**publishable key / anon key**.
4. افتح ملف `config.js` في GitHub واستبدل القيم الفارغة:

```js
window.NEXORA_CONFIG = {
  supabaseUrl: 'https://YOUR_PROJECT.supabase.co',
  supabaseAnonKey: 'sb_publishable_...'
};
```

5. **مهم: لا تضع `service_role` أو `sb_secret_...` داخل `config.js`.** هذان مفتاحان سريان ولا يجوز وضعهما في صفحات المتصفح أو GitHub.
6. في Supabase اختر **Authentication → Providers → Email** وفعل Email Sign-in / Magic Link حسب إعدادات مشروعك.
7. في **Authentication → URL Configuration** ضع رابط موقع Vercel في **Site URL**، وأضف `https://YOUR_DOMAIN/dashboard` إلى Redirect URLs. إذا استخدمت دومينًا خاصًا، أضفه أيضًا.
8. احفظ التعديل في GitHub، وانتظر Vercel ينشر التحديث. افتح «لوحتي → دخول / إنشاء حساب»، وأرسل رابط الدخول إلى بريدك.
9. بعد تسجيل الدخول، أنشئ الصفحة وأضف اسمًا ورابطًا واحدًا على الأقل، واضغط «نشر الصفحة».
10. اختبر العنوان `/p/your-slug` في **نافذة خاصة** أو من هاتف مختلف. هذا هو الاختبار الحقيقي للنشر العام.

**إذا تأخرت رسالة الدخول:** راجع إعدادات إرسال البريد وحدود خدمة Supabase الافتراضية. عند إطلاق المنصة تجاريًا استخدم SMTP مناسبًا.

## 4) مثال واقعي

- العميل يختار «أستاذ جامعي» ويملأ اسمه، نبذته، أبحاثه وResearchGate.
- يختار التصميم الأكاديمي، يضيف 3 أبحاث بروابط HTTPS، ويحفظ المسودة.
- بعد تسجيل الدخول ينشر صفحة مثل `https://YOUR_DOMAIN/p/professor-mohamed`.
- من لوحة التحكم يحصل على QR ليفتحها عبر الهاتف أو يكتب الرابط على شريحة NFC.

## 5) ملفات المشروع

| الملف | الوظيفة |
|---|---|
| `index.html` | نقطة الدخول ومحتوى الصفحة الأساسي |
| `styles.css` + `premium.css` | الواجهة والتصاميم الأربعة والتجاوب |
| `app.js` | المحرّر، القوالب، التخزين، الحسابات، النشر والمعاينة |
| `config.js` | إعداد ربط Supabase — بدون معلومات سرية |
| `supabase-schema.sql` | جداول وسياسات RLS لحماية بيانات المستخدمين |
| `vercel.json` | إعادة توجيه صفحات `/p/:slug`, `/create`, `/dashboard` إلى التطبيق |
| `smoke_logic.js` | اختبار تلقائي لمنطق الإنشاء والحماية الأساسية |

## 6) ميزات ليست موجودة بعد

- لا يوجد توليد نصوص بواسطة نموذج ذكاء اصطناعي حقيقي بعد. القوالب والمحتوى الافتراضي يعملان بقواعد مسبقة. الذكاء الاصطناعي مرحلة لاحقة (بحاجة إلى مفتاح API في خادم آمن + حدود استعمال).
- لا توجد اشتراكات مالية أو دفع آلي أو نطاق خاص لكل عميل أو إحصائيات متقدمة.
- صور الملفات تُضغط وتخزن مؤقتًا ضمن بيانات الصفحة في JSONB. للإنتاج الواسع يجب نقل رفع الملفات إلى Supabase Storage مع سياسات رفع آمنة وحدود حجم.
- يجب إضافة شروط خدمة وسياسة خصوصية وإجراءات منع محتوى مسيء قبل فتح التسجيل للجمهور.
- QR يعتمد على مكتبة خارجية من CDN عند الطلب؛ مع انقطاع الشبكة قد لا يظهر رمز QR، لكن رابط الصفحة يبقى صالحًا.
- صفحة الملف العامة في هذا الـMVP تُحمّل المحتوى من Supabase عند فتحها في المتصفح، وليست Server Side Rendered. لتحسين SEO لاحقًا يمكن الانتقال إلى Next.js SSR.

## 7) ملاحظة خاصة بـ Vercel

تسمح خطة Hobby بالتجارب الشخصية غير التجارية، **ولا تسمح باستخدام تجاري مربح** وفق شروط Vercel الحالية. للمنصة المدفوعة اختر خطة مناسبة تسمح بالاستخدام التجاري أو استضافة بديلة. راجع: https://vercel.com/docs/plans/hobby

## 8) اختبارات

يمكن اختبار منطق الواجهة دون تثبيت مكتبات:

```bash
node smoke_logic.js
```

للتشغيل المحلي، افتح سطر الأوامر داخل المجلد:

```bash
python3 -m http.server 8765
```

ثم افتح `http://localhost:8765`.

---

**NEXORA هو اسم مبدئي.** قبل إطلاق علامة تجارية أو شراء نطاق، تحقق من توفر الاسم والعلامة قانونيًا.
