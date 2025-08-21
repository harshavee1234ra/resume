import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          user_type: string
          first_name: string | null
          last_name: string | null
          company_name: string | null
          phone: string | null
          location: string | null
          website: string | null
          linkedin: string | null
          avatar_url: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          user_type?: string
          first_name?: string | null
          last_name?: string | null
          company_name?: string | null
          phone?: string | null
          location?: string | null
          website?: string | null
          linkedin?: string | null
          avatar_url?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_type?: string
          first_name?: string | null
          last_name?: string | null
          company_name?: string | null
          phone?: string | null
          location?: string | null
          website?: string | null
          linkedin?: string | null
          avatar_url?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      resumes: {
        Row: {
          id: string
          user_id: string
          title: string
          personal_info: any
          summary: string | null
          experience: any
          education: any
          skills: any
          projects: any
          custom_sections: any
          template_id: string
          ats_score: number | null
          personal_info: any
          summary: string | null
          experience: any
          education: any
          skills: any
          projects: any
          is_default: boolean
          is_published: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          title: string
          personal_info?: any
          summary?: string | null
          experience?: any
          education?: any
          skills?: any
          projects?: any
          custom_sections?: any
          template_id?: string
          ats_score?: number | null
          personal_info?: any
          summary?: string | null
          experience?: any
          education?: any
          skills?: any
          projects?: any
          is_default?: boolean
          is_published?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          title?: string
          personal_info?: any
          summary?: string | null
          experience?: any
          education?: any
          skills?: any
          projects?: any
          custom_sections?: any
          template_id?: string
          ats_score?: number | null
          personal_info?: any
          summary?: string | null
          experience?: any
          education?: any
          skills?: any
          projects?: any
          is_default?: boolean
          is_published?: boolean
          created_at?: string
          updated_at?: string
        }
      }
      cover_letters: {
        Row: {
          id: string
          user_id: string
          resume_id: string
          title: string
          content: string
          job_description: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          resume_id: string
          title: string
          content: string
          job_description: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          resume_id?: string
          title?: string
          content?: string
          job_description?: string
          created_at?: string
          updated_at?: string
        }
      }
    }
  }
}