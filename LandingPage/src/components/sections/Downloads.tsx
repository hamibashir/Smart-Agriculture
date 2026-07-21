import { motion } from "framer-motion";
import { DOWNLOADS } from "@/data";
import { buttonVariants } from "@/components/ui/button";

export function Downloads() {
  return (
    <section id="downloads" className="py-24 bg-slate-50">
      <div className="container mx-auto px-4 md:px-6">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-slate-900 mb-4">
            Project Resources
          </h2>
          <p className="text-lg text-slate-600">
            Access the mobile app, source code, and full project documentation.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto">
          {DOWNLOADS.map((item, idx) => (
            <motion.div
              key={item.title}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: idx * 0.1 }}
              className="bg-white rounded-2xl p-6 border border-slate-200 flex items-start gap-4 shadow-sm hover:shadow-md hover:border-green-200 transition-all group"
            >
              <div className="bg-green-50 text-green-600 p-4 rounded-xl group-hover:bg-green-500 group-hover:text-white transition-colors">
                <item.icon size={28} />
              </div>
              <div className="flex-1">
                <h3 className="text-xl font-bold text-slate-900 mb-2">{item.title}</h3>
                <p className="text-slate-600 mb-4">{item.description}</p>
                <a 
                  href={item.link} 
                  target={item.title === "Source Code" ? "_blank" : undefined}
                  rel={item.title === "Source Code" ? "noopener noreferrer" : undefined}
                  className={buttonVariants({ variant: "outline", className: "w-full sm:w-auto" })}
                >
                  {item.title === "Source Code" ? "View GitHub" : "Download"}
                </a>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
