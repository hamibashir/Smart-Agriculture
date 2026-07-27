import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { Hero } from "@/components/sections/Hero";
import { Features } from "@/components/sections/Features";
import { TechStack } from "@/components/sections/TechStack";
import { ImageGallery } from "@/components/sections/ImageGallery";
import { Team } from "@/components/sections/Team";
import { Downloads } from "@/components/sections/Downloads";

function App() {
  return (
    <div className="min-h-screen bg-background flex flex-col font-sans overflow-x-hidden w-full relative">
      <Navbar />
      <main className="flex-1">
        <Hero />
        <Features />
        <TechStack />
        <ImageGallery />
        <Team />
        <Downloads />
      </main>
      <Footer />
    </div>
  );
}

export default App;
