# Code Reconstruction

Fast React + Supabase contest application for code-line reconstruction exams.

## Setup

1. Create a Supabase project and run [supabase/schema.sql](supabase/schema.sql) in its SQL editor.
2. Create the administrator in Supabase Auth, then insert that user's UUID into `admin_profiles` as shown at the end of the schema file.
3. Copy `.env.example` to `.env` and supply the project's URL and **anon** key (never a service-role key).
4. Run `npm install`, then `npm run dev`.

The SQL schema enforces unique normalized roll numbers, active unique four-digit access codes, server-side scoring/submission, admin RLS policies, and ranking by correct lines then elapsed time. The browser uses the Visibility API and blur events for the strongest browser-level leave-window detection; operating-system switches cannot be detected universally by a web page.
