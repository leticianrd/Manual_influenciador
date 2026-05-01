// =============================================
// Configuração do Supabase — InfluencerPro
// =============================================
import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm'

const SUPABASE_URL  = 'https://xxdorcqipxzitihrpezv.supabase.co'
const SUPABASE_KEY  = 'SUPABASE_ANON_KEY' // substitua pela sua anon key

export const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)
