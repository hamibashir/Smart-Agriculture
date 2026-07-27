import { motion } from "framer-motion";
import { Download, Code2, PlayCircle, Smartphone } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";

export function Hero() {
  return (
    <section className="relative min-h-screen flex items-center justify-center pt-20 overflow-hidden bg-slate-950">
      {/* Animated Background Image (Ken Burns Effect) */}
      <motion.div 
        initial={{ scale: 1.1, opacity: 0 }}
        animate={{ scale: 1.02, opacity: 1 }}
        transition={{ duration: 1.5, ease: "easeOut" }}
        className="absolute -inset-4 z-0 bg-cover bg-center bg-no-repeat opacity-80"
        style={{ backgroundImage: `url('${import.meta.env.BASE_URL}hero-bg.png')` }}
      />
      
      {/* Premium Dark Gradient Overlay */}
      <div className="absolute inset-0 z-0 bg-gradient-to-b from-slate-950/90 via-slate-900/60 to-slate-950/90" />
      <div className="absolute inset-0 z-0 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-green-900/20 via-transparent to-transparent" />
      
      <div className="container mx-auto px-4 md:px-6 relative z-10 flex flex-col items-center text-center">
        <motion.div
          initial={{ opacity: 0, y: 20, scale: 0.95 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={{ duration: 0.6, delay: 0.1, ease: "easeOut" }}
          className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-white/5 text-green-300 text-sm font-medium mb-8 border border-white/10 backdrop-blur-md shadow-lg"
        >
          <span className="flex h-2 w-2 rounded-full bg-green-400 animate-pulse shadow-[0_0_10px_rgba(52,211,153,0.8)]"></span>
          Final Year Project 2026
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.2, ease: "easeOut" }}
          className="text-5xl md:text-7xl lg:text-8xl font-extrabold tracking-tight text-white max-w-5xl mb-6 drop-shadow-2xl leading-tight"
        >
          Smart AI Powered <br className="hidden md:block" />
          <span className="text-transparent bg-clip-text bg-gradient-to-br from-green-300 via-green-400 to-green-500 drop-shadow-sm">
            Agriculture System
          </span>
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.3, ease: "easeOut" }}
          className="text-lg md:text-2xl text-slate-300 max-w-3xl mb-12 drop-shadow-lg font-light leading-relaxed"
        >
          An intelligent, AI-powered and IoT-enabled ecosystem that optimizes crop yields, 
          automates irrigation, and monitors field health in real-time.
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.4, ease: "easeOut" }}
          className="flex flex-col sm:flex-row gap-5 w-full sm:w-auto"
        >
          <a 
            href={`${import.meta.env.BASE_URL}SmartAgri.apk`} 
            download
            className={buttonVariants({ 
              size: "lg", 
              className: "rounded-full gap-2 w-full sm:w-auto px-8 h-14 text-base font-semibold shadow-[0_0_40px_rgba(16,185,129,0.3)] bg-gradient-to-r from-green-600 to-green-600 hover:from-green-500 hover:to-green-500 text-white border-none transition-all duration-300 hover:scale-105" 
            })}
          >
            <Download size={20} /> Download APK
          </a>
          <a 
            href="https://deploygate.com/distributions/c3532f4def5054757001b00626686210de9e1819"
            target="_blank"
            rel="noopener noreferrer"
            className={buttonVariants({ 
              size: "lg", 
              variant: "outline", 
              className: "rounded-full gap-2 w-full sm:w-auto px-8 h-14 text-base font-medium bg-emerald-950/30 border-emerald-500/30 text-emerald-400 hover:bg-emerald-900/40 hover:text-emerald-300 hover:border-emerald-500/50 backdrop-blur-md transition-all duration-300" 
            })}
          >
            <Smartphone size={20} /> Get on DeployGate
          </a>
          <a 
            href="https://github.com/hamibashir/Smart-Agriculture"
            target="_blank"
            rel="noopener noreferrer"
            className={buttonVariants({ 
              size: "lg", 
              variant: "outline", 
              className: "rounded-full gap-2 w-full sm:w-auto px-8 h-14 text-base font-medium bg-white/5 border-white/20 text-white hover:bg-white/10 hover:text-white backdrop-blur-md transition-all duration-300" 
            })}
          >
            <Code2 size={20} /> View GitHub
          </a>
          <a 
            href="#demo" 
            className={buttonVariants({ 
              size: "lg", 
              variant: "ghost", 
              className: "rounded-full gap-2 w-full sm:w-auto px-8 h-14 text-base font-medium text-slate-200 hover:bg-white/10 hover:text-white transition-all duration-300" 
            })}
          >
            <PlayCircle size={20} /> Watch Demo
          </a>
        </motion.div>

      </div>
    </section>
  );
}
