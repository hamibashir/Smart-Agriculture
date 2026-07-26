import re
import json

def clean_text(text):
    text = re.sub(r'<[^>]+>', ' ', text)
    text = re.sub(r'\|', ' ', text)
    text = re.sub(r'\s+', ' ', text)
    return text.strip()

def parse_md():
    with open('Smart AI Powered Agriculture System.md', 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    team_work = []
    implementation = []
    deployment = []
    testing = []

    state = None
    current_item = None
    current_text = []

    for line in lines:
        raw_line = line
        line = line.strip()

        # Detect chapters
        if 'Detailed Work Breakdown Structure with Ownership' in line:
            state = 'TEAM'
            continue
        elif line.startswith('### **4.3.1. Snippet 1'):
            state = 'IMPLEMENTATION'
        elif line.startswith('## **5.1. Installation'):
            state = 'DEPLOYMENT'
        elif line.startswith('## **6.1. Unit Testing'):
            state = 'TESTING'
        elif line.startswith('# **7. Conclusion'):
            state = 'DONE'
            break

        if state == 'TEAM':
            # Extract table rows
            if line.startswith('|') and '---|' not in line and 'Table' not in line:
                parts = [p.strip() for p in line.split('|') if p.strip()]
                if len(parts) >= 2:
                    team_work.append({'role': parts[0], 'task': ' '.join(parts[1:])})
            elif line.startswith('# **1.7'):
                state = None
        
        elif state == 'IMPLEMENTATION':
            match = re.match(r'### \*\*4\.\d+\.\d+\.\s*(Snippet \d+:.*?)\*\*', line)
            if match:
                if current_item:
                    implementation.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                current_item = match.group(1)
                current_text = []
            elif line.startswith('## **4.4') or line.startswith('# **5.'):
                if current_item:
                    implementation.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                current_item = None
                state = None
            elif current_item and not line.startswith('!['):
                current_text.append(line)

        elif state == 'DEPLOYMENT':
            match = re.match(r'### \*\*5\.\d+\.\d+\.\s*(.*?)\*\*', line)
            if match:
                if current_item:
                    deployment.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                current_item = match.group(1)
                current_text = []
            elif line.startswith('## **5.') and not line.startswith('## **5.1.'):
                match = re.match(r'## \*\*5\.\d+\.\s*(.*?)\*\*', line)
                if match:
                    if current_item:
                        deployment.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                    current_item = match.group(1)
                    current_text = []
            elif line.startswith('# **6.'):
                if current_item:
                    deployment.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                current_item = None
                state = None
            elif current_item and not line.startswith('!['):
                current_text.append(line)

        elif state == 'TESTING':
            match = re.match(r'### \*\*6\.\d+\.\d+\.\s*(TC-[A-Z]+-\d+:.*?)\*\*', line)
            if match:
                if current_item:
                    testing.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                current_item = match.group(1)
                current_text = []
            elif line.startswith('## **6.') and 'Testing Evidence' not in line and 'Summary' not in line:
                pass
            elif line.startswith('# **7.') or line.startswith('## **6.5'):
                if current_item:
                    testing.append({'title': current_item, 'text': clean_text(' '.join(current_text))})
                current_item = None
                state = None
            elif current_item and not line.startswith('!['):
                current_text.append(line)

    return team_work, implementation, deployment, testing


team_work, impl, dep, test = parse_md()

# Filter/clean teamwork table to be presentable
cleaned_team = []
for t in team_work:
    if len(t['role']) > 2 and len(t['task']) > 2 and '---' not in t['role']:
        cleaned_team.append(t)

# Fallbacks if parsing fails completely
if not cleaned_team:
    cleaned_team = [{"role": "Project Team", "task": "Work Breakdown extracted from Report Table 1-3"}]
if not impl:
    impl = [{"title": "Snippets Extracted", "text": "Hardware, Firebase, Backend, Application implementation details."}]
if not dep:
    dep = [{"title": "Deployment Sections", "text": "ESP32, Backend Node, Database MySQL, Flask AI, Mobile Flutter."}]
if not test:
    test = [{"title": "Test Cases", "text": "Unit, Component, Integration, and System Tests from TC-UT-01 to TC-ST-10."}]

def chunk_list(lst, n):
    return [lst[i:i + n] for i in range(0, len(lst), n)]

slides = []

# Title slide handled in HTML

# 1. Implementation Slides (3 per slide)
for idx, chunk in enumerate(chunk_list(impl, 3)):
    cards = []
    for item in chunk:
        cards.append(f'<div class="card reveal-block"><h2>{item["title"]}</h2><p>{item["text"][:300]}...</p></div>')
    slides.append(f'''
    <div class="slide" data-section="Implementation">
      <div class="slide-content">
        <h1 class="reveal-block">System Implementation {f"(Part {idx+1})" if idx > 0 else ""}</h1>
        <div class="grid cols-3" style="margin-top: 30px;">
          {''.join(cards)}
        </div>
      </div>
    </div>
    ''')

# 2. Testing Slides (3 per slide)
for idx, chunk in enumerate(chunk_list(test, 3)):
    cards = []
    for item in chunk:
        text = item["text"]
        res = re.sub(r'Actual Result:', '<br><strong>Actual Result:</strong>', text)
        res = re.sub(r'Expected Result:', '<br><strong>Expected Result:</strong>', res)
        cards.append(f'<div class="card reveal-block"><h2>{item["title"]}</h2><p style="font-size:0.9rem;">{res[:350]}...</p></div>')
    slides.append(f'''
    <div class="slide" data-section="Testing">
      <div class="slide-content">
        <h1 class="reveal-block">System Testing {f"(Part {idx+1})" if idx > 0 else ""}</h1>
        <div class="grid cols-3" style="margin-top: 30px;">
          {''.join(cards)}
        </div>
      </div>
    </div>
    ''')

# 3. Deployment Slides (3 per slide)
for idx, chunk in enumerate(chunk_list(dep, 3)):
    cards = []
    for item in chunk:
        cards.append(f'<div class="card reveal-block"><h2>{item["title"]}</h2><p>{item["text"][:300]}...</p></div>')
    slides.append(f'''
    <div class="slide" data-section="Deployment">
      <div class="slide-content">
        <h1 class="reveal-block">System Deployment {f"(Part {idx+1})" if idx > 0 else ""}</h1>
        <div class="grid cols-3" style="margin-top: 30px;">
          {''.join(cards)}
        </div>
        <div class="card dark reveal-block" style="margin-top:20px;">
            <p><strong>Note for Images:</strong> Include deployment architecture diagrams in the <code>images/</code> folder (e.g., <code>images/deployment.png</code>) to display them here.</p>
        </div>
      </div>
    </div>
    ''')

# 4. Teamwork Slide (Table)
trs = []
for item in cleaned_team:
    trs.append(f'<tr><td>{item["role"]}</td><td>{item["task"]}</td></tr>')
table_html = f'''
<table style="width:100%; border-collapse: collapse; margin-top:20px; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
  <tr style="background: var(--brand); color: white;">
    <th style="padding: 12px; text-align: left;">Role/Module</th>
    <th style="padding: 12px; text-align: left;">Task Description</th>
  </tr>
  {''.join(trs)}
</table>
'''
slides.append(f'''
<div class="slide" data-section="Team Work">
  <div class="slide-content">
    <h1 class="reveal-block">Team Work & Breakdown Structure</h1>
    <div class="reveal-block" style="max-height: 70vh; overflow-y: auto;">
      {table_html}
    </div>
  </div>
</div>
''')

# Build the final HTML
html_template = f"""
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Final Exam - Smart AI Powered Agriculture System</title>
  <style>
    * {{ margin: 0; padding: 0; box-sizing: border-box; }}
    :root {{
      --ink: #102118;
      --muted: #4a5c52;
      --line: #d8e7dd;
      --brand: #1f9d55;
      --brand-2: #0d7c66;
      --blue: #2563eb;
      --dark: #07140f;
      --panel: #ffffff;
    }}
    body {{
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #ecfdf3, #eff6ff);
      color: var(--ink);
      overflow: hidden;
    }}
    .slides-container {{
      position: relative;
      width: 100%;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }}
    .slide {{
      position: absolute;
      width: 100%;
      height: 100%;
      opacity: 0;
      pointer-events: none;
      transition: opacity .55s ease-in-out;
      display: flex;
      align-items: center;
      justify-content: center;
    }}
    .slide.active {{ opacity: 1; z-index: 10; pointer-events: auto; }}
    
    .slide-content {{
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
    }}
    .title-slide {{
      justify-content: center;
      background:
        radial-gradient(circle at 74% 22%, rgba(134,239,172,.25), transparent 28%),
        radial-gradient(circle at 14% 76%, rgba(59,130,246,.22), transparent 24%),
        linear-gradient(135deg, #06120d 0%, #123d2a 56%, #0f172a 100%);
      color: white;
    }}
    .title-slide p {{ color: #d9fbe3; }}
    .eyebrow {{
      color: #bbf7d0;
      text-transform: uppercase;
      letter-spacing: .12em;
      font-weight: 900;
      margin-bottom: 14px;
    }}
    h1 {{
      font-size: clamp(2rem, 3.7vw, 4.5rem);
      line-height: 1.06;
      letter-spacing: 0;
      margin-bottom: 18px;
    }}
    .slide-content > h1 {{
      font-size: clamp(1.8rem, 2.8vw, 3rem);
      color: var(--dark);
      padding-bottom: 14px;
      border-bottom: 4px solid var(--brand);
      margin-bottom: 30px;
    }}
    h2 {{
      color: var(--brand-2);
      font-size: clamp(1.15rem, 1.4vw, 1.3rem);
      margin: 10px 0 10px;
    }}
    p, li {{
      font-size: 1.05rem;
      line-height: 1.5;
      color: var(--muted);
      margin-bottom: 10px;
    }}
    
    .hero-grid, .grid {{
      display: grid;
      gap: 20px;
      margin-top: 16px;
    }}
    .hero-grid {{ grid-template-columns: 1.1fr .9fr; align-items: center; gap: 34px; }}
    .cols-3 {{ grid-template-columns: repeat(3, minmax(0, 1fr)); }}
    
    .card {{
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: 12px;
      padding: 24px;
      box-shadow: 0 10px 28px rgba(16, 33, 24, .08);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      display: flex;
      flex-direction: column;
    }}
    .card:hover {{
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(16, 33, 24, .12);
    }}
    .card.dark {{
      background: var(--dark);
      border-color: rgba(255,255,255,.18);
      color: white;
    }}
    .card.dark h2 {{ color: #86efac; }}
    .card.dark p {{ color: #d1fae5; }}
    
    .metric {{ padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); }}
    .metric:last-child {{ border-bottom: none; }}
    .metric strong {{ font-size: 1.4rem; color: #fff; }}

    td {{ border-bottom: 1px solid #eee; padding: 10px; font-size: 1.05rem; }}

    .nav-buttons {{
      position: fixed;
      bottom: 28px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 12px;
      z-index: 100;
    }}
    .nav-btn {{
      background: white;
      border: 2px solid var(--brand);
      color: var(--brand);
      padding: 11px 18px;
      border-radius: 999px;
      cursor: pointer;
      font-weight: 900;
      transition: all .25s;
    }}
    .nav-btn:hover {{ background: var(--brand); color: white; transform: translateY(-2px); }}
    .slide-counter {{
      position: fixed;
      right: 28px; bottom: 28px;
      z-index: 101;
      background: rgba(255,255,255,.94);
      border: 1px solid var(--line);
      border-radius: 999px;
      padding: 9px 14px;
      font-weight: 900;
      color: var(--brand-2);
    }}
    .section-label {{
      position: fixed;
      right: 28px; top: 20px;
      z-index: 101;
      background: rgba(255,255,255,.94);
      border: 1px solid var(--line);
      border-radius: 999px;
      padding: 9px 14px;
      font-weight: 900;
      color: var(--brand-2);
    }}
    .progress {{
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 5px;
      background: rgba(31,157,85,.16);
      z-index: 102;
    }}
    .progress span {{
      display: block;
      height: 100%;
      width: 0;
      background: linear-gradient(90deg, var(--brand), var(--blue));
      transition: width .3s ease;
    }}
    
    .reveal-block {{
      opacity: 0;
      transform: translateY(20px) scale(.992);
      pointer-events: none;
      transition: opacity .52s ease, transform .52s cubic-bezier(.22, 1, .36, 1);
      will-change: opacity, transform;
    }}
    .reveal-block.revealed {{
      opacity: 1;
      transform: translateY(0) scale(1);
      pointer-events: auto;
    }}
    
    @media (max-width: 900px) {{
      .hero-grid, .cols-3 {{ grid-template-columns: 1fr; }}
    }}
  </style>
</head>
<body>
  <div class="slides-container" id="slidesContainer">
    <div class="slide active" data-section="Welcome">
      <div class="slide-content title-slide">
        <div class="hero-grid">
          <div class="reveal-block revealed">
            <div class="eyebrow">Final Defense Presentation</div>
            <h1>Smart AI Powered Agriculture System</h1>
            <p style="font-size:1.3rem;max-width:780px;margin-bottom:20px;">A comprehensive, in-depth review of System Implementation, Testing, Deployment, and Team Collaboration directly from the Project Report.</p>
            <p style="font-size: 1.2rem; font-weight: 800; color: #ffffff;">Muhammad Awais (BSE223112)<br>Hamza Bashir (BSE223108)<br>Junaid Amin (BSE223107)</p>
            <p style="font-size: 1.1rem; margin-top: 14px;">Supervisor: Adnan Karamat</p>
          </div>
          <div class="card dark reveal-block revealed">
            <h2>Detailed Agenda</h2>
            <div class="metric"><p>Chapter 4</p><strong>15+ Implementation Snippets</strong></div>
            <div class="metric"><p>Chapter 5</p><strong>Full System Deployment</strong></div>
            <div class="metric"><p>Chapter 6</p><strong>18+ Formal Test Cases</strong></div>
            <div class="metric"><p>Section 1.6</p><strong>Team Work Breakdown</strong></div>
          </div>
        </div>
      </div>
    </div>
    
    {''.join(slides)}
    
  </div>

  <div class="section-label" id="sectionLabel">Welcome</div>
  <div class="nav-buttons">
    <button class="nav-btn" onclick="previousSlide()">← Previous</button>
    <button class="nav-btn" onclick="nextSlide()">Next →</button>
  </div>
  <div class="slide-counter"><span id="slideNumber">1</span> / <span id="totalSlides"></span></div>
  <div class="progress"><span id="progressBar"></span></div>

  <script>
    const slides = document.querySelectorAll('.slide');
    let currentSlide = 1;
    let currentBlock = 0;

    function initPresentation() {{
      document.getElementById('totalSlides').textContent = slides.length;
      updateUI();
    }}

    function updateUI() {{
      slides.forEach((slide, index) => {{
        if (index === currentSlide - 1) {{
          slide.classList.add('active');
          let blocks = slide.querySelectorAll('.reveal-block');
          blocks.forEach((b, i) => {{
            if (i <= currentBlock) b.classList.add('revealed');
            else b.classList.remove('revealed');
          }});
          document.getElementById('sectionLabel').textContent = slide.getAttribute('data-section') || 'Presentation';
        }} else {{
          slide.classList.remove('active');
        }}
      }});
      document.getElementById('slideNumber').textContent = currentSlide;
      document.getElementById('progressBar').style.width = `${{(currentSlide / slides.length) * 100}}%`;
    }}

    function nextSlide() {{
      const activeSlide = slides[currentSlide - 1];
      const blocks = activeSlide.querySelectorAll('.reveal-block');
      
      if (currentBlock < blocks.length - 1) {{
        currentBlock++;
        updateUI();
        blocks[currentBlock].scrollIntoView({{ behavior: 'smooth', block: 'center' }});
      }} else if (currentSlide < slides.length) {{
        currentSlide++;
        currentBlock = 0;
        updateUI();
        slides[currentSlide - 1].scrollTop = 0;
      }}
    }}

    function previousSlide() {{
      const activeSlide = slides[currentSlide - 1];
      
      if (currentBlock > 0) {{
        currentBlock--;
        updateUI();
      }} else if (currentSlide > 1) {{
        currentSlide--;
        const prevBlocks = slides[currentSlide - 1].querySelectorAll('.reveal-block');
        currentBlock = prevBlocks.length - 1;
        updateUI();
      }}
    }}

    document.addEventListener('keydown', (e) => {{
      if (e.key === 'ArrowRight' || e.key === ' ') nextSlide();
      if (e.key === 'ArrowLeft') previousSlide();
      if (e.key === 'Home') {{ currentSlide = 1; currentBlock=0; updateUI(); }}
      if (e.key === 'End') {{ currentSlide = slides.length; currentBlock=0; updateUI(); }}
    }});

    initPresentation();
  </script>
</body>
</html>
"""

with open('Final_Exam_FYP_Presentation.html', 'w', encoding='utf-8') as f:
    f.write(html_template)

print("Generated Final Presentation with", len(slides), "slides")
