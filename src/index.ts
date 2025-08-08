// if (process.env.NODE_ENV !== "production") {
//   require("dotenv/config"); // Load .env only in development
// }

import { serve } from "@hono/node-server";
import { allRoutes } from "./routes/routes-index";

// import { serve } from "@hono/node-server";
// import { allRoutes } from "./routes/routes-index";

// serve(allRoutes, (info) => {
//   console.log(`Server is running on http://localhost:${info.port}`);
// });

const port = parseInt(process.env.PORT || "3000");

serve({
  fetch: allRoutes.fetch,
  port,
}, (info) => {
  console.log(`✅ Server is running on http://localhost:${info.port}`);
});
