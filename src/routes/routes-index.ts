import { Hono } from "hono";
import { authenticationsRoutes } from "./authentications/authentication-routes";
import { usersRoutes } from "./users/users-routes";
import { postsRoutes } from "./posts/posts-routes";
import { likesRoutes } from "./likes/likes-routes";
import { commentsRoutes } from "./comments/comments-routes";
import { cors } from "hono/cors";
import { webClientUrl } from "../../environment";

export const allRoutes = new Hono();

// ✅ Health check endpoint
allRoutes.get("/health", (c) => c.text("✅ Backend is running fine!"));

// Enable CORS
allRoutes.use(
  cors({
    origin: webClientUrl,
    allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allowHeaders: ["Authorization", "Content-Type"],
    exposeHeaders: ["Content-Length"],
    credentials: true,
    maxAge: 600,
  })
);

// API routes
allRoutes.route("/authentications", authenticationsRoutes);
allRoutes.route("/users", usersRoutes);
allRoutes.route("/posts", postsRoutes);
allRoutes.route("/likes", likesRoutes);
allRoutes.route("/comments", commentsRoutes);
