import { motion } from "framer-motion";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useRef } from "react";

const IMAGES = [
  "hardware.png", "hardware_wiring_layout.png", "sensor_pump_wiring_setup.png",
  "hardware_wiring_layout1.jpg", "ai_dataset_sample.png", "sensor_reading_validation.png",
  "E1U1.png", "E1U2.png", "E1U3.png", "E2U1.png", "E2U2.png", "E2U3.png", 
  "E3U1.png", "E3U2.png", "E3U3.png", "E4U1.png", "E4U2.png", "E4U3.png", 
  "E5U1.png", "E5U2.png", "E5U3.png", "E6U1.png", "E6U2.png", "E6U3.png"
];

export function ImageGallery() {
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollAmount = clientWidth * 0.8;
      scrollRef.current.scrollTo({
        left: direction === "left" ? scrollLeft - scrollAmount : scrollLeft + scrollAmount,
        behavior: "smooth"
      });
    }
  };

  return (
    <section id="gallery" className="py-24 bg-slate-50 overflow-hidden relative">
      <div className="container mx-auto px-4 md:px-6 relative z-10">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="inline-block mb-4 px-3 py-1 rounded-full bg-green-100/50 text-green-700 text-sm font-semibold tracking-wide uppercase border border-green-200/50"
          >
            Gallery
          </motion.div>
          <motion.h2 
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="text-3xl md:text-4xl font-extrabold text-slate-900 mb-4"
          >
            System & App Gallery
          </motion.h2>
          <motion.p 
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-lg text-slate-600"
          >
            Explore our hardware implementation and Flutter mobile app interface.
          </motion.p>
        </div>

        <div className="relative group">
          {/* Custom Navigation Buttons */}
          <button 
            onClick={() => scroll("left")}
            className="absolute left-2 md:-left-6 top-1/2 -translate-y-1/2 z-20 bg-white/90 backdrop-blur-md text-slate-800 p-3 rounded-full shadow-[0_0_20px_rgba(0,0,0,0.1)] border border-slate-100 opacity-0 group-hover:opacity-100 hover:bg-white hover:scale-110 hover:text-green-600 transition-all duration-300 focus:outline-none hidden md:block"
            aria-label="Scroll left"
          >
            <ChevronLeft size={24} />
          </button>
          
          <button 
            onClick={() => scroll("right")}
            className="absolute right-2 md:-right-6 top-1/2 -translate-y-1/2 z-20 bg-white/90 backdrop-blur-md text-slate-800 p-3 rounded-full shadow-[0_0_20px_rgba(0,0,0,0.1)] border border-slate-100 opacity-0 group-hover:opacity-100 hover:bg-white hover:scale-110 hover:text-green-600 transition-all duration-300 focus:outline-none hidden md:block"
            aria-label="Scroll right"
          >
            <ChevronRight size={24} />
          </button>

          {/* Scroll Container */}
          <div 
            ref={scrollRef}
            className="flex overflow-x-auto gap-6 pb-8 pt-4 px-4 -mx-4 snap-x snap-mandatory scrollbar-hide items-center"
            style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
          >
            {IMAGES.map((img, idx) => (
              <motion.div
                key={img}
                initial={{ opacity: 0, scale: 0.95 }}
                whileInView={{ opacity: 1, scale: 1 }}
                viewport={{ once: true, margin: "-50px" }}
                transition={{ delay: Math.min(idx * 0.05, 0.5) }}
                className="snap-center shrink-0 rounded-2xl overflow-hidden shadow-sm hover:shadow-xl border border-slate-200/60 group/item relative bg-white flex items-center justify-center p-2"
              >
                <img 
                  src={`${import.meta.env.BASE_URL}images/${img}`} 
                  alt={`Gallery Image ${idx + 1}`}
                  loading={idx === 0 ? "eager" : "lazy"}
                  className="h-[400px] md:h-[500px] w-auto max-w-[85vw] md:max-w-[900px] object-contain object-center group-hover/item:scale-[1.02] transition-transform duration-500 ease-out rounded-xl"
                />
              </motion.div>
            ))}
          </div>
        </div>
      </div>
      
      {/* Global style to hide scrollbar for webkit */}
      <style>{`
        .scrollbar-hide::-webkit-scrollbar {
          display: none;
        }
      `}</style>
    </section>
  );
}
