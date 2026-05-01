// =============================================
// Configuração do Supabase — InfluencerPro
// =============================================
import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm'

const SUPABASE_URL  = 'https://xxdorcqipxzitihrpezv.supabase.co'
const SUPABASE_KEY  = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh4ZG9yY3FpcHh6aXRpaHJwZXp2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzcyMzQxOTIsImV4cCI6MjA5MjgxMDE5Mn0.ITUMCpqqS2ZSf5qVMbR1TTIb_61NX8uVbuioW2mQ9vo'

export const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)
