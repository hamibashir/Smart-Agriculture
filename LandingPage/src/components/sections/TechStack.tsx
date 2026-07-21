import { motion } from "framer-motion";
import { TECHNOLOGIES } from "@/data";

export function TechStack() {
  return (
    <section id="tech-stack" className="relative py-32 bg-white overflow-hidden">
      <div className="container mx-auto px-4 md:px-6 relative z-10">
        <div className="text-center max-w-3xl mx-auto mb-20">
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="inline-block mb-4 px-3 py-1 rounded-full bg-green-100/50 text-green-700 text-sm font-semibold tracking-wide uppercase border border-green-200/50"
          >
            Powered By
          </motion.div>
          <motion.h2 
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="text-4xl md:text-5xl font-extrabold text-slate-900 mb-6 tracking-tight"
          >
            Technology Stack
          </motion.h2>
          <motion.p 
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-xl text-slate-600 font-light leading-relaxed"
          >
            Built with a modern, robust, and scalable set of tools covering hardware,
            backend, and frontend development.
          </motion.p>
        </div>

        <div className="flex flex-wrap justify-center gap-6 max-w-6xl mx-auto">
          {Object.entries(TECHNOLOGIES).map(([category, techs], idx) => (
            <motion.div
              key={category}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: idx * 0.1, duration: 0.5, ease: "easeOut" }}
              className="w-full md:w-[calc(50%-0.75rem)] lg:w-[calc(33.333%-1rem)] group relative bg-slate-50/50 p-8 rounded-3xl border border-slate-200 hover:bg-white hover:border-green-300 hover:shadow-xl hover:shadow-green-500/5 transition-all duration-500"
            >
              <h3 className="text-xl font-bold text-slate-900 mb-6 group-hover:text-green-700 transition-colors duration-300">
                {category}
              </h3>
              <div className="flex flex-wrap gap-3">
                {techs.map((tech) => (
                  <span
                    key={tech}
                    className="px-4 py-1.5 rounded-full text-sm font-medium bg-white text-slate-600 border border-slate-200 group-hover:border-green-200 group-hover:bg-green-50 group-hover:text-green-700 transition-all duration-300 shadow-sm"
                  >
                    {tech}
                  </span>
                ))}
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
