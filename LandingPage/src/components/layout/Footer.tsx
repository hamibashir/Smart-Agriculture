import { Code2, Briefcase, Mail } from "lucide-react";

export function Footer() {
  return (
    <footer className="bg-slate-900 text-slate-300 py-12">
      <div className="container mx-auto px-4 md:px-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
          <div className="md:col-span-2">
            <h3 className="text-xl font-bold text-white mb-4">
              Smart<span className="text-primary">Agri</span>
            </h3>
            <p className="text-slate-400 max-w-sm">
              An AI-powered, IoT-enabled smart agriculture system designed for modern farming. 
              Built for our Final Year Project to solve real-world agricultural challenges.
            </p>
          </div>
          <div>
            <h4 className="text-white font-semibold mb-4">Quick Links</h4>
            <ul className="space-y-2">
              <li><a href="#features" className="hover:text-primary transition-colors">Features</a></li>
              <li><a href="#tech-stack" className="hover:text-primary transition-colors">Tech Stack</a></li>
              <li><a href="#team" className="hover:text-primary transition-colors">Team</a></li>
              <li><a href="#downloads" className="hover:text-primary transition-colors">Downloads</a></li>
            </ul>
          </div>
          <div>
            <h4 className="text-white font-semibold mb-4">Connect</h4>
            <div className="flex gap-4">
              <a href="#" className="hover:text-white transition-colors" aria-label="GitHub">
                <Code2 size={20} />
              </a>
              <a href="#" className="hover:text-white transition-colors" aria-label="LinkedIn">
                <Briefcase size={20} />
              </a>
              <a href="#" className="hover:text-white transition-colors" aria-label="Email">
                <Mail size={20} />
              </a>
            </div>
            <p className="mt-4 text-sm text-slate-400">
              Department of Computer Science<br />
              Final Year Project 2026
            </p>
          </div>
        </div>
        <div className="pt-8 border-t border-slate-800 text-sm text-center text-slate-500">
          &copy; {new Date().getFullYear()} Smart Agriculture Team. All rights reserved.
        </div>
      </div>
    </footer>
  );
}
