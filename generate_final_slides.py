import re

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
      --muted: #607268;
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
      color: #bbf7d0;
      text-transform: uppercase;
      letter-spacing: .12em;
      font-weight: 900;
      margin-bottom: 14px;
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
      padding: 24px;
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
    const reportData = [
      {
        section: "System Implementation",
        title: "Software & Hardware Implementation",
        cards: [
          {
            heading: "Hardware Configuration (Snippets 1-2)",
            text: "The ESP32 firmware initializes with precise pin mappings (ADC, GPIO outputs). Sensor thresholds are configured with safe defaults: Dry threshold at 30%, wet at 70%, and rain safety threshold at 400. This ensures offline autonomy."
          },
          {
            heading: "Timing & Execution Logic",
            text: "Implementation utilizes a three-tier timing system: SENSOR_INTERVAL (2s), TELEMETRY_INTERVAL (30s), and COMMAND_POLL_INTERVAL (5s) for decoupled execution. Safe system initialization verifies all I/O configurations."
          },
          {
            heading: "Backend Integration",
            text: "Sensor values are converted to standardized percentages (0-100%) and uploaded to the Node.js backend using HTTP POST over Wi-Fi, alongside a fallback relay synchronization logic for network failures."
          }
        ]
      },
      {
        section: "System Testing",
        title: "Comprehensive System Validation",
        cards: [
          {
            heading: "Unit & Component Testing",
            text: "Verified independent functions. E.g., TC-UT-01 ensures User Registration securely hashes passwords in the users table. TC-CT-01 confirmed Automatic Irrigation Triggers work independently of the network."
          },
          {
            heading: "Integration Testing",
            text: "Tested interactions between layers. TC-IT-01 verified ESP32 to Backend Sensor Telemetry, ensuring data arrives formatted. TC-IT-05 ensured Backend to AI Service integration passes field parameters reliably."
          },
          {
            heading: "End-to-End System Testing",
            text: "TC-ST-02 validated Automated Irrigation with Rain Safety: ensuring the pump halts when the rain sensor detects precipitation, end-to-end, logging the event safely into MySQL."
          }
        ]
      },
      {
        section: "System Deployment",
        title: "Installation & Deployment Architecture",
        cards: [
          {
            heading: "Field Unit Installation",
            text: "Sensors are placed strategically (moisture at roots, rain sensor exposed). The final prototype is waterproofed. ESP32 firmware is flashed via Arduino IDE with pre-configured target farm Wi-Fi and API URLs."
          },
          {
            heading: "Server Infrastructure",
            text: "Backend Node.js service is deployed with environment configurations containing MySQL credentials. AI prediction service runs on a Flask server, exposing a REST API for the Node application."
          },
          {
            heading: "Mobile Application",
            text: "The Flutter mobile application is built and configured to securely communicate with the live backend endpoints for authentication, dashboard data viewing, and realtime IoT control."
          }
        ]
      },
      {
        section: "Team Work",
        title: "Work Breakdown & Collaboration",
        cards: [
          {
            heading: "Collaborative Engineering",
            text: "The project's complexity demanded close coordination. Development was divided into Hardware & IoT, Backend APIs & Database, Mobile UI & UX, and AI Modeling layers among the three team members."
          },
          {
            heading: "Integration Efforts",
            text: "Team members successfully integrated their respective modules—IoT endpoints with Backend APIs, Backend APIs with Flutter state management, and AI models with user-facing recommendation engines."
          },
          {
            heading: "Validation & Documentation",
            text: "Extensive joint effort was required in end-to-end system testing, verifying physical prototypes in field environments, and compiling a comprehensive 130+ page formal engineering report."
          }
        ]
      }
    ];

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
                <p style="font-size:1.3rem;max-width:780px;margin-bottom:20px;">A comprehensive review of Implementation, Testing, Deployment, and Team Collaboration extracted directly from the Project Report.</p>
                <p style="font-size: 1.2rem; font-weight: 800; color: #ffffff;">Muhammad Awais (BSE223112)<br>Hamza Bashir (BSE223108)<br>Junaid Amin (BSE223107)</p>
                <p style="font-size: 1.1rem; margin-top: 14px;">Supervisor: Adnan Karamat</p>
              </div>
              <div class="card dark reveal-block revealed">
                <h2>Agenda Highlights</h2>
                <div class="metric"><p>Chapter 4</p><strong>Software Implementation</strong></div>
                <div class="metric"><p>Chapter 5</p><strong>System Deployment</strong></div>
                <div class="metric"><p>Chapter 6</p><strong>Formal Testing</strong></div>
                <div class="metric"><p>Section 1.6</p><strong>Team Work Breakdown</strong></div>
              </div>
            </div>
          </div>
        </div>`);
    }

    function addDataSlides() {
      reportData.forEach(data => {
        let cardsHtml = data.cards.map(card => `
          <div class="card reveal-block">
            <h2>${card.heading}</h2>
            <p>${card.text}</p>
          </div>
        `).join('');
        
        slidesContainer.insertAdjacentHTML('beforeend', `
          <div class="slide">
            <div class="slide-content">
              <h1 class="reveal-block">${data.title}</h1>
              <div class="grid cols-3" style="margin-top: 30px;">
                ${cardsHtml}
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

print("Created highly custom Final_Exam_FYP_Presentation.html based on report data.")
