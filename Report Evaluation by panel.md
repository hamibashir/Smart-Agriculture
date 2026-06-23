Critical Template Compliance Audit Report
Smart AI Powered Agriculture System
Compared with SE FYP Hardware-Based Template
Overall Verdict: Extremely Poor / Not Acceptable in Current Form

Audit basis: The submitted report was reviewed against the SE FYP Hardware-Based template. The evaluation focuses on formatting compliance, mandatory structure, hardware-based technical artifacts, originality of evidence, AI/ML grounding, code quality, figures/tables, and completeness of final sections.
Critical conclusion: The report  fails the hardware-based template in substance. It is built largely from generic images, tables and bullet points, while mandatory preliminary pages, real hardware evidence, real circuit/design diagrams, proper code explanation, and technical validation are missing or weak.
 
1. Executive Evaluation Summary
Finding	Critical evaluation	Impact
Mandatory preliminary pages are missing	The PDF moves from the title page directly to the Table of Contents, which is labelled viii. This indicates that pages ii-vii required by the template are missing from the compiled report: Project Report, Approval Certificate, Declaration, Acknowledgements, Dedication (optional) and Executive Summary.	Major revision required before acceptance
Hardware-based evidence is absent	For a hardware-based FYP, the report should show real hardware, actual wiring, circuit schematic, pin-level design, component placement, test setup and prototype photographs. The report does not provide a single real image of the hardware prototype.	Major revision required before acceptance
Design artifacts are not real engineering artifacts	The report contains polished architecture and hardware integration images, but they are not acceptable substitutes for circuit diagrams, component diagrams, activity diagrams, wiring diagrams or verified hardware-design outputs. Several visuals appear generic or AI-generated/presentation-style rather than actual design evidence.	Major revision required before acceptance
AI/ML model claim is unsupported	The report claims AI-based crop recommendation, but it lacks dataset description, preprocessing, model architecture, algorithm justification, training/testing split, performance metrics, confusion matrix, feature importance, model version and deployment evidence.	Major revision required before acceptance
Code snippets are poor	The code section contains fragments rather than complete modules. It lacks repository reference, file names, line numbers, imports, error handling, execution evidence and clear mapping to user stories/test cases.	Major revision required before acceptance
Report writing is weak	The report is dominated by tables, bullet lists and screenshots. There are few explanatory paragraphs, weak critical discussion, limited technical reasoning and insufficient explanation of figures and tables.	Major revision required before acceptance
Final template sections are incomplete	Bibliography and plagiarism report are present, but the template-required Report Approval Certificate is missing and the Appendix is not meaningfully provided despite being listed in the TOC.	Major revision required before acceptance
2. Hardware-Based Template Requirements vs Submitted Report
Template area	Template expectation	Submitted report evidence	Severity	Correction required
Preliminary pages	Template requires title page followed by Project Report, Approval Certificate, Declaration, Acknowledgements, Dedication (optional), Executive Summary, then TOC.	PDF page 2 starts with Table of Contents labelled viii immediately after title page. Required preliminary pages are absent.	Critical	Revise according to the hardware-based template and provide verifiable technical evidence.
Chapter structure	Hardware template expects Chapter 1 Introduction, Chapter 2 Requirement Specification and Analysis, Chapter 3 System Design, Chapter 4 Software Development, Chapter 5 Software Deployment, References, Plagiarism Report, Report Approval Certificate, Appendix.	Report adds Chapter 6 System Testing and Chapter 7 Conclusion/Future Work, while the required Report Approval Certificate is missing. Appendix is only listed and not properly developed.	Major	Revise according to the hardware-based template and provide verifiable technical evidence.
Hardware system design	Hardware-based template requires System Design with software architecture, components/connectors, hardware specifications, communication protocols, data modeling, workflow diagram and dependencies.	Sections exist, but they are mostly generic text/tables and images. There is no real circuit schematic, component diagram, activity diagram, breadboard/PCB layout, sensor wiring photo or actual hardware prototype image.	Critical	Revise according to the hardware-based template and provide verifiable technical evidence.
Figures and tables	Every figure/table must be labelled, centered and referenced in the text with more than a one-line mention.	Figures and tables are numerous but weakly explained. Some visuals are small and unclear. The report relies on figures/tables instead of technical paragraphs.	Major	Revise according to the hardware-based template and provide verifiable technical evidence.
Code snippets	Software Development should explain important functions and connect implementation to user stories/test results.	Code snippets are incomplete fragments. They lack file/module names, line numbers, imports, complete functions, execution evidence, GitHub link and technical explanation.	Critical	Revise according to the hardware-based template and provide verifiable technical evidence.
AI/ML module	If AI is claimed, the model must be technically verifiable.	No dataset evidence, training process, model architecture, validation metrics, comparison baseline or deployment proof is provided. The AI claim remains ungrounded.	Critical	Revise according to the hardware-based template and provide verifiable technical evidence.
Deployment/testing evidence	Deployment should include installation/deployment process and evidence of working system.	Textual deployment and all-pass testing claims are present, but no real hardware testing photos, serial monitor logs, field setup photos or actual sensor output evidence are provided.	Critical	Revise according to the hardware-based template and provide verifiable technical evidence.
3. Detailed Evidence Table with Page Numbers
Criteria	Page evidence	Severity	What is wrong	Required correction
Formatting and preliminary pages	PDF p.1-2	Critical	Only the title page is followed by Table of Contents. Mandatory preliminary pages required by the hardware-based template are not present in the compiled PDF.	Insert Project Report, Approval Certificate, Declaration, Acknowledgements, Dedication if required, and Executive Summary before TOC.
Page numbering	PDF p.2	Critical	TOC is labelled viii even though pages ii-vii are missing. This creates false preliminary pagination.	Rebuild the document using the template and apply correct Roman numerals before Chapter 1.
Report structure	PDF p.2-7	Major	TOC shows a structure that differs from the hardware-based template by adding Chapter 6 and Chapter 7, while missing Report Approval Certificate after plagiarism report.	Follow the prescribed chapter sequence or obtain supervisor approval for extra chapters; add Report Approval Certificate.
Appendix	PDF p.7	Major	TOC lists Appendix B as "Something Else", showing placeholder/incomplete final material.	Replace placeholder appendix with user manual, hardware setup guide, pin configuration, dataset/model details and troubleshooting.
Title page	PDF p.1	Minor	Title page uses Spring 2026 correctly, but supervisor surname capitalization appears as "karamat" instead of "Karamat".	Correct name formatting and ensure all title-page details match departmental style.
Header style	Whole report	Major	Chapter name appears in the header, but spacing and formatting are inconsistent across sections; some pages show excessive blank space.	Apply the template header and paragraph spacing consistently.
WBS visual quality	PDF p.15	Major	The Work Breakdown Structure is a generic generated-looking image and is not supported by detailed team responsibilities, durations and deliverables.	Create a clear WBS table/diagram with real task ownership, duration and deliverables.
Gantt chart quality	PDF p.16	Major	The Gantt chart is a screenshot-style image with limited readability and minimal explanation.	Use a properly readable Gantt chart and explain dependencies, milestones and responsibilities.
UI prototype dominance	PDF p.26-49	Major	The report devotes many pages to UI mockups, but a hardware-based report should prioritize real hardware design, circuit, wiring and prototype evidence.	Reduce generic UI mockups; add actual hardware design artifacts and concise explanatory text.
Unverified generated visuals	PDF p.15-16, 26-49, 53, 60, 62, 68	Critical	Most visuals appear as generic or AI/presentation-generated images. They do not demonstrate actual design work, fabrication or implemented hardware.	Replace with verified diagrams from design tools and actual photos/screenshots from implementation.
Missing circuit diagram	Whole report	Critical	No circuit schematic is provided for ESP32, sensors, relay, pump/valve, power supply and communication pins.	Add a proper circuit diagram using Proteus, Fritzing, KiCad or similar, with pin labels and power lines.
Missing component diagram	Whole report	Critical	No formal component diagram is provided despite the project being hardware-based and template requiring component/connector explanation.	Add UML/component diagram showing modules, interfaces, data flow and hardware/software boundaries.
Missing activity diagram	Whole report	Major	No activity diagram is included for irrigation control, sensor reading, AI recommendation or alert workflow.	Add activity diagrams for the major hardware/software workflows.
No real hardware evidence	Whole report	Critical	There is not a single real image of the actual hardware prototype, assembled ESP32 setup, sensors, pump/relay, field setup or testing environment.	Insert real photographs of assembled hardware, wiring, field prototype, power supply and test setup.
Hardware integration figure	PDF p.63	Critical	Figure 3.2 is a polished generic diagram, not an actual wiring/circuit design. It cannot verify that the team built the hardware.	Replace or supplement with real schematic, wiring layout and hardware photographs.
Hardware specifications	PDF p.64-66	Major	Hardware discussion is mainly bullet points and tables. Datasheets, operating ranges, tolerances, calibration details and integration limitations are weak or absent.	Add datasheet-based specifications, calibration method, pin mapping, power budget and design constraints.
Power and safety design	PDF p.58-59, 66	Major	Power discussion is not supported by measured current, battery/adapter rating, relay safety, pump surge current or protection details.	Add power calculation, protection circuit, measured current values and safety precautions.
AI/ML model grounding	PDF p.4, 10-11, 72, 88-89, 96, 111	Critical	The report claims an AI crop recommendation model, but does not provide dataset source, preprocessing, model architecture, training/testing split, metrics or model file evidence.	Add AI methodology section with dataset, features, model selection, algorithm, training, evaluation metrics, screenshots/logs and limitations.
AI confidence score	PDF p.20-21, 40-41	Major	Confidence score is shown as a UI feature, but no statistical method or calibration for the confidence value is explained.	Explain how confidence is calculated and validate it with test data.
Raw citation keys	PDF p.8, 11-12, 56	Major	The report contains unresolved citation keys such as saha2024automated and akkem2024enhancing, which indicates broken reference processing.	Fix all unresolved citations and regenerate references.
Code snippet quality	PDF p.72-81	Critical	Code snippets are poorly written fragments: no complete file context, no imports, no line numbers, no repository reference, and weak explanation.	Provide clean snippets from actual source files with file names, line numbers, comments, and explanation of logic.
Testing credibility	PDF p.91-118	Critical	The report claims all tests passed, but provides mostly table-based statements and no real logs, screenshots, sensor values, serial monitor output, hardware testing photos or field results.	Attach real test evidence, hardware logs, screenshots, measured readings and failed/resolved cases.
Figures not explained	Multiple pages	Major	Many figures are inserted with short captions and minimal explanation. The template requires figures to be referenced and discussed in the text, not just placed.	Write a paragraph after each figure explaining purpose, components, notation and relevance.
Tables not explained	Multiple pages	Major	Tables dominate the report, but many are not critically discussed. The report reads like generated tables rather than an engineering narrative.	Explain each major table and reduce unnecessary table-heavy content.
Paragraph quality	Whole report	Major	The report has few substantive technical paragraphs and too many bullets/lists. It lacks critical reasoning and engineering trade-off discussion.	Rewrite sections in paragraph form with clear technical explanations.
Formatting of captions	Whole report	Major	Figure/table numbering uses decimal style (e.g., 1.1) instead of the template-style Figure 1-1 / Table 1-1 format.	Standardize captions and regenerate List of Figures/List of Tables.
Bibliography heading	PDF p.124	Minor	The template uses References, while this report uses Bibliography.	Use the heading required by the departmental template unless otherwise allowed.
Plagiarism/final sequence	PDF p.128-144	Critical	Plagiarism report is included, but the required Report Approval Certificate and proper appendix content are missing from the final document sequence.	Add Report Approval Certificate and complete Appendix/User Manual after the plagiarism report.
4. Technical Ground Evaluation
4.1 Hardware Design Deficiency
The project is hardware-based, but the report does not provide credible hardware design evidence. A hardware-based FYP should show how the ESP32 is wired to sensors, relay module, pump/valve, power supply and communication interface. The submitted report uses a generic hardware integration diagram and tables, but does not include an actual circuit diagram, component diagram, activity diagram, wiring schematic, breadboard/PCB layout, prototype photographs, sensor calibration evidence, power measurements or physical testing images. As a result, the report does not prove that the proposed system was physically designed or implemented.
4.2 AI/ML Model Deficiency
The report repeatedly claims AI-driven crop recommendations, but the AI module is not technically grounded. There is no dataset table, no source dataset description, no feature list with units, no preprocessing pipeline, no model architecture, no train-test split, no hyperparameter values, no confusion matrix or accuracy/F1/precision/recall metrics, no comparison with baseline models, no saved model version, no API input/output example, and no evidence that the model was actually trained or deployed. The "confidence score" displayed in the UI is also not mathematically justified. In its current form, the AI/ML component is a claim, not an evaluated engineering artifact.
4.3 Code Snippet Deficiency
The code snippets are weak and fragmented. They appear as short blocks inserted into the report rather than complete, reviewable implementation evidence. A proper Chapter 4 should include important functions with file/module names, line numbers, input/output explanation, comments, exception handling, dependency context, and connection to user stories and tests. The current snippets do not demonstrate a complete firmware, backend, AI service or mobile application implementation.
4.4 Visual Evidence Deficiency
The report relies heavily on generic visual material. Several images appear generated or mockup-based rather than real design outputs. They are also small or not sufficiently visible for technical review. For a hardware-based report, figures must not only look polished; they must verify the actual design. The submitted visuals do not show real components, real wiring, real hardware assembly, real sensor calibration, real pump/relay setup or real field testing.
5. Required Remediation Before Resubmission
• Rebuild the preliminary pages exactly according to the hardware-based template: Project Report, Approval Certificate, Declaration, Acknowledgements, Dedication if required, Executive Summary, TOC, List of Figures and List of Tables.
• Add a real circuit schematic for the ESP32, all sensors, relay, pump/valve, power source and communication interface.
• Add formal component diagram, activity diagram and communication protocol diagram using standard notation.
• Add real photographs of the hardware prototype, wiring, sensors, pump/relay setup, field test setup and running system.
• Replace generic/AI-generated visuals with actual design artifacts created in tools such as Proteus, Fritzing, KiCad, draw.io, StarUML or equivalent.
• Rewrite diagram and table sections using paragraphs that explain purpose, notation, components, assumptions, limitations and how each artifact supports implementation.
• Provide a complete AI/ML methodology section with dataset, preprocessing, model choice, training details, evaluation metrics, model version and deployment screenshots/logs.
• Replace poor code fragments with clean, formatted snippets from actual implementation files, with file names, line numbers, comments and clear explanations.
• Provide real testing evidence: serial monitor logs, sensor readings, API outputs, screenshots of backend/mobile dashboard, hardware photos during tests and sample pass/fail records.
• Complete the final section sequence: References, Plagiarism Report, Report Approval Certificate and Appendix/User Manual.
 
6. Screenshot Evidence Appendix
The following screenshots are included as examples of the issues observed in the submitted report. They are not exhaustive; they illustrate the main template and technical-compliance problems.
Evidence 1 - Title page
 
PDF page 1: Title page. The term is Spring 2026, but the report moves directly into contents after this page; the full preliminary-page sequence is not present.
Evidence 2 - TOC begins at viii after title page
 
PDF page 2: Table of Contents appears immediately after the title page and is labelled viii, proving that mandatory preliminary pages are missing from the compiled report.
Evidence 3 - TOC ending lacks Report Approval Certificate
 
PDF page 7: The TOC ends with Bibliography, Plagiarism Report and Appendix, but the required Report Approval Certificate is absent and Appendix B is still vague/incomplete.
Evidence 4 - List of figures formatting and figure-heavy report
 
PDF page 8: List of Figures uses decimal figure numbering and lists many UI/mockup figures; the hardware-based template expects figure numbering/captions and meaningful technical artifacts.
Evidence 5 - List of tables formatting and table-heavy report
 
PDF page 9: List of Tables is long and dominated by test cases and schemas; the report becomes table-heavy rather than explanatory.
Evidence 6 - Generic WBS image
 
PDF page 15: WBS is a generic generated-looking image with limited project-specific explanation.
Evidence 7 - Generic Gantt chart image
 
PDF page 16: Gantt chart is a screenshot-style image, not a formal project management table/chart with detailed explanation and ownership.
Evidence 8 - Generic architecture and hardware integration visuals
 
PDF page 63: The report shows polished generic architecture/hardware visuals but no real circuit schematic, PCB/breadboard diagram, or actual hardware prototype evidence.
Evidence 9 - Hardware specifications only in table form
 
PDF page 66: Hardware discussion is mainly a table; no real component photographs, datasheet references, wiring evidence, or tested setup are shown.
Evidence 11 - Plagiarism report without approval certificate follow-up
 
PDF page 138: Plagiarism report is included, but the required Report Approval Certificate and meaningful appendix/user manual are not properly provided after it.
