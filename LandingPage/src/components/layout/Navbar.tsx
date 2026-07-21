import { useState, useEffect } from "react";
import { Menu, X } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";

const NAV_LINKS = [
  { name: "Features", href: "#features" },
  { name: "Tech Stack", href: "#tech-stack" },
  { name: "Team", href: "#team" },
  { name: "Downloads", href: "#downloads" },
];

export function Navbar() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <header
      className={`fixed top-4 md:top-6 left-1/2 -translate-x-1/2 z-50 w-[calc(100%-2rem)] max-w-4xl transition-all duration-300 rounded-full border border-white/40 bg-white/80 backdrop-blur-xl shadow-lg shadow-slate-900/5 ${
        isScrolled ? "py-1" : "py-2"
      }`}
    >
      <div className="px-4 md:px-6 h-12 flex items-center justify-between">
        <a href="#" className="flex items-center gap-2">
          <span className="font-bold text-xl tracking-tight text-slate-900">
            Smart<span className="text-primary">Agri</span>
          </span>
        </a>

        {/* Desktop Nav */}
        <nav className="hidden md:flex items-center gap-8">
          {NAV_LINKS.map((link) => (
            <a
              key={link.name}
              href={link.href}
              className="text-sm font-semibold text-slate-600 hover:text-primary transition-colors"
            >
              {link.name}
            </a>
          ))}
          <a href="/SmartAgri.apk" download className={buttonVariants({ variant: "default", size: "sm", className: "rounded-full px-6 shadow-md shadow-green-500/20" })}>
            Download App
          </a>
        </nav>

        {/* Mobile Menu Toggle */}
        <button
          className="md:hidden p-2 text-slate-700 hover:bg-slate-100 rounded-full transition-colors"
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
        >
          {isMobileMenuOpen ? <X size={20} /> : <Menu size={20} />}
        </button>
      </div>

      {/* Mobile Nav Dropdown */}
      {isMobileMenuOpen && (
        <div className="absolute top-full left-0 right-0 mt-3 bg-white/95 backdrop-blur-xl border border-slate-200/50 p-4 flex flex-col gap-4 shadow-2xl rounded-3xl md:hidden">
          {NAV_LINKS.map((link) => (
            <a
              key={link.name}
              href={link.href}
              className="text-sm font-semibold text-slate-700 hover:text-green-600 transition-colors py-2 px-4 hover:bg-slate-50 rounded-xl"
              onClick={() => setIsMobileMenuOpen(false)}
            >
              {link.name}
            </a>
          ))}
          <a href="/SmartAgri.apk" download className={buttonVariants({ variant: "default", className: "w-full mt-2 rounded-xl py-6" })} onClick={() => setIsMobileMenuOpen(false)}>
            Download App
          </a>
        </div>
      )}
    </header>
  );
}
