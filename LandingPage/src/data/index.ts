import {
  Sprout,
  Droplets,
  Radio,
  Smartphone,
  Cloud,
  Shield,
  FileCode2,
  FileText,
  Presentation,
  Download
} from "lucide-react";

export const TEAM_MEMBERS = [
  {
    name: "Muhammad Awais",
    role: "AI & Backend Engineer",
    image: "https://api.dicebear.com/7.x/avataaars/svg?seed=Awais&backgroundColor=10B981",
    linkedin: "#",
    github: "https://github.com/muhammadawais42",
  },
  {
    name: "Hamza Bashir",
    role: "IoT & Hardware Engineer",
    image: "https://api.dicebear.com/7.x/avataaars/svg?seed=Hamza&backgroundColor=10B981",
    linkedin: "#",
    github: "https://github.com/hamibashir",
  },
  {
    name: "Junaid Ameen",
    role: "Mobile App Developer",
    image: "https://api.dicebear.com/7.x/avataaars/svg?seed=Junaid&backgroundColor=10B981",
    linkedin: "#",
    github: "https://github.com/JunaidAminnn",
  },
];

export const FEATURES = [
  {
    title: "AI Crop Recommendation",
    description: "Machine learning models suggesting the best crops based on soil and weather data.",
    icon: Sprout,
  },
  {
    title: "Smart Irrigation",
    description: "Automated and manual water pump control based on real-time soil moisture.",
    icon: Droplets,
  },
  {
    title: "IoT Sensor Monitoring",
    description: "Real-time tracking of temperature, humidity, and soil metrics.",
    icon: Radio,
  },
  {
    title: "Flutter Mobile App",
    description: "Cross-platform application for farmers to monitor and control their fields.",
    icon: Smartphone,
  },
  {
    title: "Cloud Dashboard",
    description: "Centralized analytics and historical data visualization.",
    icon: Cloud,
  },
  {
    title: "Blockchain Security",
    description: "Ensuring data integrity and secure transactions for agricultural supply chains.",
    icon: Shield,
  },
];

export const TECHNOLOGIES = {
  Frontend: ["Flutter"],
  Backend: ["Node.js", "Express"],
  Database: ["MySQL"],
  IoT: ["ESP32", "DHT22", "Soil Moisture", "LDR", "Rain Sensor"],
  AI: ["Random Forest"],
};

export const DOWNLOADS = [
  {
    title: "Android APK",
    description: "Download the latest version of our smart farming app.",
    icon: Download,
    link: "/SmartAgri.apk",
  },
  {
    title: "Source Code",
    description: "View our open-source repositories on GitHub.",
    icon: FileCode2,
    link: "https://github.com/hamibashir/Smart-Agriculture",
  },
  {
    title: "Documentation",
    description: "Read the full system architecture and API documentation.",
    icon: FileText,
    link: "#",
  },
  {
    title: "Presentation Slides",
    description: "Download the FYP mid-evaluation presentation slides.",
    icon: Presentation,
    link: "#",
  },
];
