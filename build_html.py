import re
import json

def extract_section(text, start_marker, end_marker):
    start = text.find(start_marker)
    if start == -1: return ""
    end = text.find(end_marker, start)
    if end == -1: end = len(text)
    return text[start:end]

with open('Smart AI Powered Agriculture System.md', 'r', encoding='utf-8') as f:
    text = f.read()

slides_data = []

def add_slide(section, title, body):
    if len(title) > 80:
        title = title[:77] + '...'
    if len(body) > 400:
        body = body[:397] + '...'
    slides_data.append({
        "section": section,
        "title": title.strip('* '),
        "text": body.strip()
    })

# 1. Team Work
team_text = extract_section(text, '**1.6. Project Work Break Down**', '**1.7. Project Time Line**')
team_items = re.split(r'\*\*(.*?)\*\*', team_text)
current_title = ""
for item in team_items:
    if len(item.strip()) == 0: continue
    if len(item) < 60 and not item.startswith(' '):
        current_title = item
    elif current_title and len(item.strip()) > 30:
        add_slide("Team Work", current_title, item)
        current_title = ""

# 2. Requirements / User Stories
req_text = extract_section(text, '**2.2. User Stories**', '**2.3. Test-cases**')
for match in re.finditer(r'\*\*(Epic.*?)\*\*(.*?)(?=\*\*Epic|\Z)', req_text, re.DOTALL):
    title = match.group(1)
    body = match.group(2)
    # user stories are inside tables or list, lets just get text
    body = re.sub(r'\|', ' ', body)
    body = re.sub(r'\s+', ' ', body)
    if len(body) > 30:
        add_slide("Requirements & Design", title, body)

# 3. Deployment
dep_text = extract_section(text, '**Chapter 5**', '**Chapter 6**')
for match in re.finditer(r'\*\*(5\.\d+\..*?)\*\*(.*?)(?=\*\*5\.\d+\.|\Z)', dep_text, re.DOTALL):
    title = match.group(1)
    body = match.group(2)
    body = re.sub(r'\|', ' ', body)
    body = re.sub(r'\s+', ' ', body)
    if len(body) > 30:
        add_slide("System Deployment", title, body)

# 4. Testing
test_text = extract_section(text, '**6.1. Unit Testing**', '**6.5. Testing Summary**')
for match in re.finditer(r'\*\*(6\.\d+\.\d+\..*?)\*\*(.*?)(?=\*\*6\.\d+\.\d+\.|\Z)', test_text, re.DOTALL):
    title = match.group(1)
    body = match.group(2)
    body = re.sub(r'\|', ' ', body)
    body = re.sub(r'\s+', ' ', body)
    if len(body) > 30:
        add_slide("System Testing", title, body)


# Limit to around 55 slides total just to be safe
slides_data = slides_data[:60]

print(f"Extracted {len(slides_data)} slides.")

html_template = """
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Final Exam - Smart AI Powered Agriculture System</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --ink: #102118;
      --muted: #4a5c52;
      --line: #d8e7dd;
      --brand: #1f9d55;
      --brand-2: #0d7c66;
      --blue: #2563eb;
      --dark: #07140f;
      --panel: #ffffff;
    }
    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #ecfdf3, #eff6ff);
      color: var(--ink);
      overflow: hidden;
    }
    .slides-container {
      position: relative;
      width: 100%;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .slide {
      position: absolute;
      width: 100%;
      height: 100%;
      opacity: 0;
      pointer-events: none;
      transition: opacity .55s ease-in-out;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .slide.active { opacity: 1; z-index: 10; pointer-events: auto; }
    
    .slide-content {
      width: 100%;
      height: 100vh;
      padding: 48px 7vw 96px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
      background:
        linear-gradient(90deg, rgba(31,157,85,.055) 1px, transparent 1px),
        linear-gradient(rgba(31,157,85,.045) 1px, transparent 1px),
        #ffffff;
      background-size: 48px 48px;
    }
    .title-slide {
      justify-content: center;
      background:
        radial-gradient(circle at 74% 22%, rgba(134,239,172,.25), transparent 28%),
        radial-gradient(circle at 14% 76%, rgba(59,130,246,.22), transparent 24%),
        linear-gradient(135deg, #06120d 0%, #123d2a 56%, #0f172a 100%);
      color: white;
    }
    .title-slide p { color: #d9fbe3; }
    .eyebrow {
      color: var(--brand-2);
      text-transform: uppercase;
      letter-spacing: .12em;
      font-weight: 900;
      margin-bottom: 14px;
    }
    .title-slide .eyebrow {
      color: #bbf7d0;
    }
    h1 {
      font-size: clamp(2rem, 3.7vw, 4.5rem);
      line-height: 1.06;
      letter-spacing: 0;
      margin-bottom: 18px;
    }
    .slide-content > h1 {
      font-size: clamp(1.8rem, 2.8vw, 3rem);
      color: var(--dark);
      padding-bottom: 14px;
      border-bottom: 4px solid var(--brand);
      margin-bottom: 30px;
    }
    h2 {
      color: var(--brand-2);
      font-size: clamp(1.15rem, 1.7vw, 1.55rem);
      margin: 14px 0 10px;
    }
    p, li {
      font-size: 1.1rem;
      line-height: 1.6;
      color: var(--muted);
      margin-bottom: 10px;
    }
    
    .hero-grid, .grid {
      display: grid;
      gap: 20px;
      margin-top: 16px;
    }
    .hero-grid { grid-template-columns: 1.1fr .9fr; align-items: center; gap: 34px; }
    .cols-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
    
    .card {
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: 12px;
      padding: 32px;
      box-shadow: 0 10px 28px rgba(16, 33, 24, .08);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(16, 33, 24, .12);
    }
    .card.dark {
      background: var(--dark);
      border-color: rgba(255,255,255,.18);
      color: white;
    }
    .card.dark h2 { color: #86efac; }
    .card.dark p { color: #d1fae5; }
    
    .metric { padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); }
    .metric:last-child { border-bottom: none; }
    .metric strong { font-size: 1.4rem; color: #fff; }

    .nav-buttons {
      position: fixed;
      bottom: 28px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 12px;
      z-index: 100;
    }
    .nav-btn {
      background: white;
      border: 2px solid var(--brand);
      color: var(--brand);
      padding: 11px 18px;
      border-radius: 999px;
      cursor: pointer;
      font-weight: 900;
      transition: all .25s;
    }
    .nav-btn:hover { background: var(--brand); color: white; transform: translateY(-2px); }
    .slide-counter {
      position: fixed;
      right: 28px; bottom: 28px;
      z-index: 101;
      background: rgba(255,255,255,.94);
      border: 1px solid var(--line);
      border-radius: 999px;
      padding: 9px 14px;
      font-weight: 900;
      color: var(--brand-2);
    }
    .progress {
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 5px;
      background: rgba(31,157,85,.16);
      z-index: 102;
    }
    .progress span {
      display: block;
      height: 100%;
      width: 0;
      background: linear-gradient(90deg, var(--brand), var(--blue));
      transition: width .3s ease;
    }
    
    .reveal-block {
      opacity: 0;
      transform: translateY(20px) scale(.992);
      pointer-events: none;
      transition: opacity .52s ease, transform .52s cubic-bezier(.22, 1, .36, 1);
      will-change: opacity, transform;
    }
    .reveal-block.revealed {
      opacity: 1;
      transform: translateY(0) scale(1);
      pointer-events: auto;
    }
    
    @media (max-width: 900px) {
      .hero-grid, .cols-3 { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
  <div class="slides-container" id="slidesContainer"></div>

  <div class="nav-buttons">
    <button class="nav-btn" onclick="previousSlide()">← Previous</button>
    <button class="nav-btn" onclick="nextSlide()">Next →</button>
  </div>
  <div class="slide-counter"><span id="slideNumber">1</span> / <span id="totalSlides"></span></div>
  <div class="progress"><span id="progressBar"></span></div>

  <script>
    const reportData = """ + json.dumps(slides_data) + """;

    const slidesContainer = document.getElementById('slidesContainer');
    let currentSlide = 1;
    let slides = [];
    let currentBlock = 0;

    function addTitleSlide() {
      slidesContainer.insertAdjacentHTML('beforeend', `
        <div class="slide active">
          <div class="slide-content title-slide">
            <div class="hero-grid">
              <div class="reveal-block revealed">
                <div class="eyebrow">Final Defense Presentation</div>
                <h1>Smart AI Powered Agriculture System</h1>
                <p style="font-size:1.3rem;max-width:780px;margin-bottom:20px;">Evaluation Presentation based on Project Requirements, Testing, Deployment, and Team Collaboration.</p>
                <p style="font-size: 1.2rem; font-weight: 800; color: #ffffff;">Muhammad Awais (BSE223112)<br>Hamza Bashir (BSE223108)<br>Junaid Amin (BSE223107)</p>
                <p style="font-size: 1.1rem; margin-top: 14px;">Supervisor: Adnan Karamat</p>
              </div>
              <div class="card dark reveal-block revealed">
                <h2>Evaluation Criteria Covered</h2>
                <div class="metric"><p>Functional Solution</p><strong>Requirements & Design</strong></div>
                <div class="metric"><p>Formal Testing</p><strong>Comprehensive Test Cases</strong></div>
                <div class="metric"><p>Deployment Status</p><strong>System Deployment Details</strong></div>
                <div class="metric"><p>Team Contribution</p><strong>Tasks & Break Down</strong></div>
              </div>
            </div>
          </div>
        </div>`);
    }

    function addDataSlides() {
      reportData.forEach(data => {
        slidesContainer.insertAdjacentHTML('beforeend', `
          <div class="slide">
            <div class="slide-content">
              <div class="eyebrow reveal-block">${data.section}</div>
              <h1 class="reveal-block">${data.title}</h1>
              <div class="card reveal-block" style="margin-top: 30px;">
                <p style="font-size: 1.25rem;">${data.text}</p>
              </div>
            </div>
          </div>
        `);
      });
    }

    function initPresentation() {
      addTitleSlide();
      addDataSlides();
      
      slides = document.querySelectorAll('.slide');
      document.getElementById('totalSlides').textContent = slides.length;
      updateUI();
    }

    function updateUI() {
      slides.forEach((slide, index) => {
        if (index === currentSlide - 1) {
          slide.classList.add('active');
          let blocks = slide.querySelectorAll('.reveal-block');
          blocks.forEach((b, i) => {
            if (i <= currentBlock) b.classList.add('revealed');
            else b.classList.remove('revealed');
          });
        } else {
          slide.classList.remove('active');
        }
      });
      document.getElementById('slideNumber').textContent = currentSlide;
      document.getElementById('progressBar').style.width = `${(currentSlide / slides.length) * 100}%`;
    }

    function nextSlide() {
      const activeSlide = slides[currentSlide - 1];
      const blocks = activeSlide.querySelectorAll('.reveal-block');
      
      if (currentBlock < blocks.length - 1) {
        currentBlock++;
        updateUI();
      } else if (currentSlide < slides.length) {
        currentSlide++;
        currentBlock = 0;
        updateUI();
      }
    }

    function previousSlide() {
      const activeSlide = slides[currentSlide - 1];
      
      if (currentBlock > 0) {
        currentBlock--;
        updateUI();
      } else if (currentSlide > 1) {
        currentSlide--;
        const prevBlocks = slides[currentSlide - 1].querySelectorAll('.reveal-block');
        currentBlock = prevBlocks.length - 1;
        updateUI();
      }
    }

    document.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowRight' || e.key === ' ') nextSlide();
      if (e.key === 'ArrowLeft') previousSlide();
      if (e.key === 'Home') { currentSlide = 1; currentBlock=0; updateUI(); }
      if (e.key === 'End') { currentSlide = slides.length; currentBlock=0; updateUI(); }
    });

    initPresentation();
  </script>
</body>
</html>
"""

with open('Final_Exam_FYP_Presentation.html', 'w', encoding='utf-8') as f:
    f.write(html_template)

print("Successfully written Final_Exam_FYP_Presentation.html")
