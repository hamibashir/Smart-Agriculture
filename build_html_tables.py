import re
import json

with open('Smart AI Powered Agriculture System.md', 'r', encoding='utf-8') as f:
    text = f.read()

def clean_text(text):
    text = re.sub(r'\[\d+\]', '', text)
    text = re.sub(r'#+', '', text)
    text = re.sub(r'\*\*', '', text)
    text = text.replace('\ufffd', '-')
    text = re.sub(r'Requirement Specification and Analysis\s+\d+\s+', '', text)
    text = re.sub(r'System Deployment\s+\d+\s+', '', text)
    text = re.sub(r'Introduction\s+\d+\s+', '', text)
    text = text.replace('<br>', ' ')
    text = re.sub(r'\s+', ' ', text)
    return text.strip()

def extract_section(text, start_marker, end_marker):
    start = text.find(start_marker)
    if start == -1: return ""
    end = text.find(end_marker, start)
    if end == -1: end = len(text)
    return text[start:end]

# --- EXTRACT EPICS ---
epics_text = extract_section(text, '**2.1. Epics**', '**2.2. User Stories**')
epics = {}
epic_pattern = re.compile(r'\*\*(2\.1\.\d+\.\s+)(E\d+):\s*(.*?)\*\*(.*?)\*\*Description:\*\*(.*?)(?=\*\*2\.1\.\d+\.|\Z)', re.DOTALL)

for match in epic_pattern.finditer(epics_text):
    e_id = clean_text(match.group(2))
    e_title = clean_text(match.group(3))
    e_desc = clean_text(match.group(5))
    epics[e_id] = {
        "title": e_title,
        "description": e_desc,
        "user_stories": []
    }

# --- EXTRACT REQUIREMENTS (USER STORIES) ---
req_text = extract_section(text, '**2.2. User Stories**', '**2.3. Test-cases**')
matches = re.finditer(r'\*\*(E\d+)-(US\d+):\s*(.*?)\*\*(.*?)\*\*Acceptance Criteria:\*\*(.*?)(?=\*\*(?:E\d+-US\d+)|$)', req_text, re.DOTALL)

for match in matches:
    epic_id = clean_text(match.group(1))
    us_id = clean_text(match.group(2))
    story_id = f"{epic_id}-{us_id}"
    title = clean_text(match.group(3))
    description = clean_text(match.group(4))
    acceptance = clean_text(match.group(5))
    
    if epic_id in epics:
        epics[epic_id]["user_stories"].append({
            "id": story_id,
            "title": title,
            "description": description,
            "acceptance": acceptance
        })

# --- BUILD SLIDES DATA ---
slides_data = []

# Introduction Section
slides_data.append({
    "is_section_intro": True,
    "section_title": "Introduction",
    "topic": "Project Overview",
    "description": "An overview of the Smart AI Powered Agriculture System, its goals, and how it addresses modern farming challenges."
})

slides_data.append({
    "section_type": "Introduction: Project Overview",
    "is_epic": False,
    "heading": "What is the Smart AI Agriculture System?",
    "description": "Our project addresses water shortages and low productivity by bringing modern tools to farmers.",
    "rows": [
        {"key": "IoT Monitoring", "val": "Uses advanced sensors to monitor soil moisture, temperature, humidity, light, and rainfall in real time."},
        {"key": "Automated Irrigation", "val": "Controls water pumps automatically based on sensor readings to save water and reduce manual labor."},
        {"key": "AI Crop Recommendation", "val": "Applies Artificial Intelligence to analyze field conditions and recommend the most suitable crops for maximum yield."}
    ]
})

# Section 1 Intro Slide
slides_data.append({
    "is_section_intro": True,
    "section_title": "Section 1",
    "topic": "System Requirements",
    "description": "In this section, we will review the comprehensive system requirements broken down into high-level Epics and their corresponding User Stories. This covers the functional boundaries and acceptance criteria agreed upon for the Smart Agriculture System."
})

# Section 1 slides
for epic_id, epic_data in epics.items():
    if len(epic_data["user_stories"]) == 0:
        continue
        
    stories_list = [f"• {us['title']} ({us['id']})" for us in epic_data["user_stories"]]
    
    slides_data.append({
        "section_type": "Section 1: System Requirements",
        "is_epic": True,
        "heading": f"Epic {epic_id}: {epic_data['title']}",
        "description": epic_data['description'],
        "stories_list": stories_list
    })
    
    for us in epic_data["user_stories"]:
        slides_data.append({
            "section_type": "Section 1: System Requirements",
            "is_epic": False,
            "heading": f"{us['id']}: {us['title']}",
            "description": "User Story Details and Acceptance Criteria",
            "rows": [
                {"key": "Epic", "val": f"{epic_id}: {epic_data['title']}"},
                {"key": "User Story ID", "val": us['id']},
                {"key": "Title", "val": us['title']},
                {"key": "Description", "val": us['description']},
                {"key": "Acceptance Criteria", "val": us['acceptance']}
            ]
        })

# Section 2 Intro Slide
slides_data.append({
    "is_section_intro": True,
    "section_title": "Section 2",
    "topic": "System Testing",
    "description": "In this section, we will evaluate the formal test cases designed to validate the requirements established in Section 1. Each test case demonstrates the system's compliance, providing expected vs. actual results to confirm system stability and functionality."
})

# --- EXTRACT TEST CASES ---
test_cases_text = extract_section(text, '**2.3. Test-cases**', '**Chapter 3**')
tc_pattern = re.compile(r'\*\*(2\.3\.\d+\.\s+.*?)\*\*(.*?)(?=\*\*2\.3\.\d+\.|\Z)', re.DOTALL)

for match in tc_pattern.finditer(test_cases_text):
    heading = clean_text(match.group(1))
    content = match.group(2).strip()
    
    desc_match = re.search(r'(.*?)(?:_Table|\|)', content, re.DOTALL)
    description = ""
    if desc_match:
        description = clean_text(desc_match.group(1))
        
    rows = []
    for line in content.split('\n'):
        line = line.strip()
        if line.startswith('|') and not line.startswith('|---'):
            cols = [clean_text(c) for c in line.strip('|').split('|')]
            if len(cols) >= 2:
                key = clean_text(cols[0].replace('**', ''))
                val = clean_text(cols[1].replace('<br>', ' '))
                rows.append({"key": key, "val": val})
                
    slides_data.append({
        "section_type": "Section 2: System Testing",
        "is_epic": False,
        "heading": heading,
        "description": description,
        "rows": rows
    })

# Section 3 Intro Slide
slides_data.append({
    "is_section_intro": True,
    "section_title": "Section 3",
    "topic": "System Deployment",
    "description": "In this section, we cover the comprehensive deployment strategy of our system. It includes frontend distribution across multiple platforms, robust backend hosting, and the setup of the IoT hardware in the field."
})

# Section 3 Custom App Deployment Overview
slides_data.append({
    "section_type": "Section 3: System Deployment",
    "is_epic": False,
    "heading": "High-Level Architecture & Hosting Overview",
    "description": "Our application components are distributed reliably across modern cloud services and app distribution platforms to ensure maximum accessibility and uptime.",
    "rows": [
        {"key": "Frontend (Flutter App)", "val": "<ul style='padding-left: 20px;'><li>Google Play Store</li><li>Project Landing Page (Direct APK Download)</li><li>DeployGate (App Store Alternative)</li></ul>"},
        {"key": "Backend & Cloud Services", "val": "<ul style='padding-left: 20px;'><li>Node.js (API Backend)</li><li>MySQL (Relational Database)</li><li>Python (AI Recommendation Model)</li></ul><i>All hosted on a secure Digital Ocean VPS Server.</i>"}
    ]
})

# --- NO FURTHER EXTRACTION FOR SECTION 3 AS PER USER REQUEST ---

# --- SECTION 4: TEAM WORK ---
slides_data.append({
    "is_section_intro": True,
    "section_title": "Section 4",
    "topic": "Team Work & WBS",
    "description": "In this section, we outline the separation of work and the detailed Work Breakdown Structure (WBS), showcasing how the workload was divided among team members."
})

wbs_start = text.find('_Table 1-3:')
wbs_end = text.find('_Table 1-4:', wbs_start)
if wbs_start != -1 and wbs_end != -1:
    wbs_text = text[wbs_start:wbs_end]
    wbs_rows = []
    
    for line in wbs_text.split('\n'):
        line = line.strip()
        if line.startswith('|') and not line.startswith('|---') and not 'ID**|**Task' in line:
            cols = [clean_text(c) for c in line.strip('|').split('|')]
            # Discard broken or continuation rows
            if len(cols) >= 5 and cols[0] != "" and not cols[0].startswith("Continued"):
                row_id = cols[0]
                
                # Reassign ownership based on user instructions
                owner = cols[3]
                if row_id.startswith('1'):
                    owner = "Muhammad Awais"
                elif row_id.startswith('2'):
                    owner = "Hamza Bashir"
                elif row_id.startswith('3'):
                    owner = "Hamza Bashir"
                elif row_id.startswith('4'):
                    owner = "Junaid Amin"
                    
                wbs_rows.append({
                    "id": row_id,
                    "task": cols[1],
                    "duration": cols[2],
                    "owner": owner,
                    "deliverable": cols[4]
                })

    # Chunk into slides of ~5-6 rows
    chunk_size = 6
    for i in range(0, len(wbs_rows), chunk_size):
        chunk = wbs_rows[i:i+chunk_size]
        slide_rows = []
        for r in chunk:
            # We use a custom table format in JS, but for now we map it to existing key/val structure
            # Or we can pass a special "wbs_rows" flag and render a 5-column table.
            # Let's pass a 'wbs_rows' array so JS can render a custom 5-col table.
            pass
            
        slides_data.append({
            "section_type": "Section 4: Team Work (WBS)",
            "is_epic": False,
            "heading": f"Work Breakdown Structure (Part {i//chunk_size + 1})",
            "description": "Distribution of tasks and responsibilities across the development phases.",
            "wbs_rows": chunk
        })


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
      --bg-gradient: linear-gradient(135deg, #f8fafc, #f1f5f9);
    }
    body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: var(--bg-gradient);
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
      padding: 48px 10vw 96px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
      align-items: center;
      background: #ffffff;
    }
    
    .title-slide {
      justify-content: center;
      background: linear-gradient(135deg, #06120d 0%, #123d2a 56%, #0f172a 100%);
      color: white;
      text-align: center;
    }
    .title-slide p { color: #d9fbe3; }
    
    .section-intro-slide {
      justify-content: center;
      background: linear-gradient(135deg, #1f9d55 0%, #0d7c66 100%);
      color: white;
      text-align: center;
    }
    .section-intro-slide .section-large {
      font-size: clamp(4rem, 6vw, 6rem);
      font-weight: 900;
      margin-bottom: 10px;
      letter-spacing: -0.02em;
    }
    .section-intro-slide .topic-large {
      font-size: clamp(2rem, 3.5vw, 3.5rem);
      color: #bbf7d0;
      margin-bottom: 30px;
      padding-bottom: 30px;
      border-bottom: 2px solid rgba(255,255,255,0.2);
      width: 100%;
      max-width: 800px;
    }
    .section-intro-slide .desc-large {
      font-size: 1.4rem;
      line-height: 1.6;
      color: #ecfdf3;
      max-width: 800px;
    }
    
    .eyebrow {
      color: var(--brand-2);
      text-transform: uppercase;
      letter-spacing: .12em;
      font-weight: 900;
      margin-bottom: 14px;
      text-align: center;
    }
    .title-slide .eyebrow {
      color: #bbf7d0;
    }
    h1 {
      font-size: clamp(2rem, 3vw, 3.2rem);
      line-height: 1.1;
      letter-spacing: 0;
      margin-bottom: 18px;
      text-align: center;
    }
    .slide-content > h1 {
      color: var(--dark);
      padding-bottom: 14px;
      margin-bottom: 20px;
    }
    .slide-desc {
      font-size: 1.25rem;
      line-height: 1.6;
      color: var(--muted);
      margin-bottom: 30px;
      text-align: center;
      max-width: 900px;
    }
    
    table {
      width: 100%;
      max-width: 1100px;
      border-collapse: collapse;
      margin-top: 20px;
      background: var(--panel);
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
      border-radius: 8px;
      overflow: hidden;
    }
    th, td {
      padding: 14px 18px;
      text-align: left;
      border-bottom: 1px solid var(--line);
      font-size: 1.05rem;
    }
    th {
      background: #f8fafc;
      font-weight: 700;
      color: var(--dark);
      border-right: 1px solid var(--line);
      vertical-align: top;
    }
    /* Default table (2-column) width mapping */
    table:not(.wbs-table) th {
      width: 25%;
    }
    
    .wbs-table th { background: #07140f; color: #fff; border-right: none; }
    .wbs-table td { border-right: 1px solid var(--line); }
    .wbs-table tr:nth-child(even) { background: #fafafa; }
    .wbs-row-main td { font-weight: 800; background: #eef2f6 !important; }
    
    td {
      color: var(--muted);
      line-height: 1.6;
    }
    tr:last-child th, tr:last-child td {
      border-bottom: none;
    }
    
    .epic-card {
      background: var(--dark);
      color: white;
      padding: 40px;
      border-radius: 12px;
      margin-top: 20px;
      width: 100%;
      max-width: 800px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.15);
      border: 1px solid rgba(255,255,255,0.1);
    }
    .epic-card h3 {
      color: #86efac;
      margin-bottom: 20px;
      font-size: 1.6rem;
      border-bottom: 1px solid rgba(255,255,255,0.1);
      padding-bottom: 10px;
    }
    .epic-card ul {
      list-style: none;
      padding-left: 0;
    }
    .epic-card li {
      font-size: 1.25rem;
      color: #d1fae5;
      margin-bottom: 12px;
      display: flex;
      align-items: center;
    }
    .epic-card li::before {
      content: '✓';
      color: var(--brand);
      margin-right: 12px;
      font-weight: bold;
    }
    
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
          <div class="slide-content title-slide" style="align-items: center; text-align: center;">
            <div class="reveal-block revealed">
              <div class="eyebrow">Final Defense Presentation</div>
              <h1 style="max-width: 900px;">Smart AI Powered Agriculture System</h1>
              <p style="font-size:1.4rem;max-width:780px;margin: 20px auto;">Intro: Project Overview<br>Section 1: System Requirements<br>Section 2: System Testing<br>Section 3: System Deployment<br>Section 4: Team Work (WBS)</p>
              <div style="margin-top: 40px; background: rgba(255,255,255,0.1); padding: 20px; border-radius: 12px; border: 1px solid rgba(255,255,255,0.2); display: inline-block;">
                  <p style="font-size: 1.2rem; font-weight: 800; color: #ffffff; margin-bottom: 0;">Muhammad Awais (BSE223112)<br>Hamza Bashir (BSE223108)<br>Junaid Amin (BSE223107)</p>
                  <p style="font-size: 1.1rem; margin-top: 14px; margin-bottom: 0;">Supervisor: Adnan Karamat</p>
              </div>
            </div>
          </div>
        </div>`);
    }

    function addDataSlides() {
      reportData.forEach(data => {
        if (data.is_section_intro) {
            slidesContainer.insertAdjacentHTML('beforeend', `
              <div class="slide">
                <div class="slide-content section-intro-slide">
                  <div class="reveal-block" style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
                      <div class="section-large">${data.section_title}</div>
                      <div class="topic-large">${data.topic}</div>
                      <p class="desc-large">${data.description}</p>
                  </div>
                </div>
              </div>
            `);
            return;
        }
      
        let contentHtml = '';
        if (data.is_epic) {
            let listHtml = data.stories_list.map(s => `<li>${s.replace('• ', '')}</li>`).join('');
            contentHtml = `
              <div class="epic-card reveal-block">
                  <h3>Included Use Cases / Stories:</h3>
                  <ul>${listHtml}</ul>
              </div>
            `;
        } else if (data.wbs_rows) {
            let wbsHtml = data.wbs_rows.map(r => {
                let isMain = !r.id.includes('.');
                let rowClass = isMain ? 'wbs-row-main' : '';
                return `
                <tr class="${rowClass}">
                    <td>${r.id}</td>
                    <td>${r.task}</td>
                    <td>${r.duration}</td>
                    <td>${r.owner}</td>
                    <td>${r.deliverable}</td>
                </tr>
                `;
            }).join('');
            contentHtml = `
                <table class="reveal-block wbs-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Task / Phase</th>
                            <th>Duration</th>
                            <th>Ownership</th>
                            <th>Deliverable</th>
                        </tr>
                    </thead>
                    <tbody>${wbsHtml}</tbody>
                </table>
            `;
        } else if (data.rows) {
            let tableRows = data.rows.map(r => `
              <tr>
                <th>${r.key}</th>
                <td>${r.val}</td>
              </tr>
            `).join('');
            contentHtml = tableRows ? `<table class="reveal-block"><tbody>${tableRows}</tbody></table>` : '';
        }

        slidesContainer.insertAdjacentHTML('beforeend', `
          <div class="slide">
            <div class="slide-content">
              <div class="eyebrow reveal-block">${data.section_type}</div>
              <h1 class="reveal-block" style="border-bottom: none; padding-bottom: 0;">${data.heading}</h1>
              ${data.description ? `<p class="slide-desc reveal-block">${data.description}</p>` : ''}
              ${contentHtml}
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

print("Successfully generated final presentation with Section 4: Team Work.")
