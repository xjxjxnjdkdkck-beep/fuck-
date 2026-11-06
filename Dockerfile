FROM node:20-alpine
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@10.18.0 --activate
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# السطرين دول هما "الحل النووي": بينشئوا مجلد الباتش والملف الفاضي جوه السيرفر
RUN mkdir -p patches && touch patches/wouter@3.7.1.patch

RUN pnpm install
COPY . .
RUN pnpm build
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["node", "dist/index.js"]
