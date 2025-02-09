const String supabaseUrl = 'https://lgawdazyjaqhazwrbgqf.supabase.co/rest/v1';
const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxnYXdkYXp5amFxaGF6d3JiZ3FmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NDEwOTYsImV4cCI6MjA1NDQxNzA5Nn0.cSMzuqIYnDoAyRL8vbKEaKngN6PLwj766zRy8-oMQYE';
const Map<String, String> supabaseHeaders = {
  'apikey': supabaseKey,
  'Authorization': 'Bearer $supabaseKey',
  'Content-Type': 'application/json',
  'Prefer': 'return=minimal',
};
