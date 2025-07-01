-- PhishGuardAI Database Initialization Script
-- This script creates the initial database schema

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table for authentication
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    firebase_uid VARCHAR(255) UNIQUE,
    company_name VARCHAR(255),
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Email templates table
CREATE TABLE email_templates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    subject VARCHAR(500) NOT NULL,
    content TEXT NOT NULL,
    template_type VARCHAR(100), -- e.g., 'google_reset', 'microsoft_login', 'bank_alert'
    difficulty_level VARCHAR(20) DEFAULT 'medium', -- 'easy', 'medium', 'hard'
    is_ai_generated BOOLEAN DEFAULT false,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Phishing campaigns table
CREATE TABLE campaigns (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    template_id UUID REFERENCES email_templates(id),
    created_by UUID REFERENCES users(id),
    status VARCHAR(50) DEFAULT 'draft', -- 'draft', 'active', 'completed', 'paused'
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    target_count INTEGER DEFAULT 0,
    emails_sent INTEGER DEFAULT 0,
    total_opens INTEGER DEFAULT 0,
    total_clicks INTEGER DEFAULT 0,
    total_submissions INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Campaign targets (recipients)
CREATE TABLE campaign_targets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    campaign_id UUID REFERENCES campaigns(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department VARCHAR(100),
    tracking_id UUID UNIQUE DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Email tracking and metrics
CREATE TABLE email_metrics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    campaign_id UUID REFERENCES campaigns(id) ON DELETE CASCADE,
    target_id UUID REFERENCES campaign_targets(id) ON DELETE CASCADE,
    email_sent BOOLEAN DEFAULT false,
    email_sent_at TIMESTAMP,
    email_opened BOOLEAN DEFAULT false,
    email_opened_at TIMESTAMP,
    link_clicked BOOLEAN DEFAULT false,
    link_clicked_at TIMESTAMP,
    form_submitted BOOLEAN DEFAULT false,
    form_submitted_at TIMESTAMP,
    submitted_data JSONB, -- Store form submission data
    user_agent TEXT,
    ip_address INET,
    location_data JSONB, -- Store geolocation data if available
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Training materials and tips
CREATE TABLE training_tips (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    tip_type VARCHAR(100), -- 'general', 'email_security', 'password', 'phishing_signs'
    difficulty_level VARCHAR(20) DEFAULT 'beginner',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports table
CREATE TABLE reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    campaign_id UUID REFERENCES campaigns(id) ON DELETE CASCADE,
    report_type VARCHAR(100) DEFAULT 'campaign_summary',
    report_data JSONB NOT NULL,
    pdf_path VARCHAR(500),
    generated_by UUID REFERENCES users(id),
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for better performance
CREATE INDEX idx_campaigns_created_by ON campaigns(created_by);
CREATE INDEX idx_campaigns_status ON campaigns(status);
CREATE INDEX idx_campaign_targets_campaign_id ON campaign_targets(campaign_id);
CREATE INDEX idx_campaign_targets_tracking_id ON campaign_targets(tracking_id);
CREATE INDEX idx_email_metrics_campaign_id ON email_metrics(campaign_id);
CREATE INDEX idx_email_metrics_target_id ON email_metrics(target_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_firebase_uid ON users(firebase_uid);

-- Insert some default email templates
INSERT INTO email_templates (name, subject, content, template_type, difficulty_level, is_ai_generated) VALUES
(
    'Google Password Reset',
    'Security Alert: Password Reset Request',
    'Dear User,<br><br>We received a request to reset your Google account password. If you did not make this request, please click the link below to secure your account:<br><br><a href="{{tracking_link}}">Reset Password Now</a><br><br>This link will expire in 24 hours.<br><br>Best regards,<br>Google Security Team',
    'google_reset',
    'medium',
    false
),
(
    'Microsoft Account Login Alert',
    'Unusual sign-in activity detected',
    'Hello,<br><br>We noticed a new sign-in to your Microsoft account from an unusual location:<br><br>Location: {{location}}<br>Time: {{time}}<br>Device: {{device}}<br><br>If this was you, you can safely ignore this email. If not, please <a href="{{tracking_link}}">secure your account immediately</a>.<br><br>Microsoft Account Team',
    'microsoft_login',
    'easy',
    false
),
(
    'Bank Security Alert',
    'URGENT: Suspicious Activity on Your Account',
    'Dear Valued Customer,<br><br>We have detected suspicious activity on your account. For your security, we have temporarily limited access.<br><br>To restore full access, please verify your identity by clicking the link below:<br><br><a href="{{tracking_link}}">Verify Account Now</a><br><br>Failure to verify within 24 hours may result in permanent account suspension.<br><br>Security Department',
    'bank_alert',
    'hard',
    false
);

-- Insert some default training tips
INSERT INTO training_tips (title, content, tip_type, difficulty_level) VALUES
(
    'Check the Sender Address',
    'Always verify the sender''s email address. Legitimate companies use official domain names. Be suspicious of addresses with misspellings or unusual domains.',
    'email_security',
    'beginner'
),
(
    'Hover Before You Click',
    'Before clicking any link, hover your mouse over it to see the actual destination URL. Phishing emails often use misleading link text.',
    'phishing_signs',
    'beginner'
),
(
    'Look for Urgency Tactics',
    'Phishing emails often create false urgency with phrases like "act now," "urgent action required," or "account will be suspended." Take time to verify before acting.',
    'phishing_signs',
    'intermediate'
),
(
    'Verify Through Official Channels',
    'If you receive a suspicious email claiming to be from a company, contact them directly through their official website or phone number, not through the email.',
    'general',
    'intermediate'
),
(
    'Enable Two-Factor Authentication',
    'Use 2FA on all important accounts. Even if your password is compromised, 2FA provides an additional layer of security.',
    'password',
    'advanced'
);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers to automatically update updated_at columns
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_email_templates_updated_at BEFORE UPDATE ON email_templates FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_campaigns_updated_at BEFORE UPDATE ON campaigns FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_email_metrics_updated_at BEFORE UPDATE ON email_metrics FOR EACH ROW EXECUTE FUNCTION update_updated_at_column(); 