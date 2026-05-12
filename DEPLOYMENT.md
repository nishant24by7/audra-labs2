# Audra Labs Deployment Guide

## Quick Deployment Options

### Option 1: Vercel (Recommended - Fastest)

1. **Prerequisites**
   - GitHub account with repository
   - Vercel account (free tier available)
   - Anthropic API key

2. **Deploy**
   ```bash
   # 1. Push code to GitHub
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/YOUR_USERNAME/Audra-Labs.git
   git push -u origin main
   
   # 2. Go to https://vercel.com/import
   # 3. Select your repository
   # 4. Add ANTHROPIC_API_KEY to Environment Variables
   # 5. Click Deploy
   ```

3. **Verification**
   - Vercel provides a live URL (e.g., `audra-labs.vercel.app`)
   - All subsequent pushes auto-deploy

### Option 2: Docker + Railway/Render/Heroku

1. **Build Docker image**
   ```bash
   docker build -t audra-labs .
   docker run -p 5000:5000 -e ANTHROPIC_API_KEY=your_key audra-labs
   ```

2. **Deploy to Railway**
   ```bash
   # Install Railway CLI
   npm i -g @railway/cli
   
   # Deploy
   railway up
   ```

3. **Or Render**
   - Connect GitHub repository to Render
   - Select Docker as build method
   - Add ANTHROPIC_API_KEY environment variable
   - Deploy

### Option 3: Traditional VPS/Cloud

1. **SSH into server**
   ```bash
   ssh user@your-server.com
   ```

2. **Clone and setup**
   ```bash
   git clone https://github.com/YOUR_USERNAME/Audra-Labs.git
   cd Audra-Labs
   python -m venv venv
   source venv/bin/activate
   pip install -r backend/requirements.txt
   ```

3. **Configure environment**
   ```bash
   echo "ANTHROPIC_API_KEY=your_key" > .env
   ```

4. **Run with Systemd**
   ```bash
   sudo tee /etc/systemd/system/audra-labs.service > /dev/null <<EOF
   [Unit]
   Description=Audra Labs API
   After=network.target

   [Service]
   Type=notify
   ExecStart=/path/to/venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 backend.api:app
   WorkingDirectory=/path/to/Audra-Labs
   Environment="ANTHROPIC_API_KEY=your_key"
   Restart=always

   [Install]
   WantedBy=multi-user.target
   EOF
   
   sudo systemctl enable audra-labs
   sudo systemctl start audra-labs
   ```

5. **Setup Nginx**
   ```bash
   sudo apt install nginx
   sudo tee /etc/nginx/sites-available/audra-labs > /dev/null <<EOF
   server {
       listen 80;
       server_name your-domain.com;

       location / {
           proxy_pass http://localhost:5000;
           proxy_set_header Host \$host;
           proxy_set_header X-Real-IP \$remote_addr;
       }
   }
   EOF
   
   sudo ln -s /etc/nginx/sites-available/audra-labs /etc/nginx/sites-enabled/
   sudo systemctl restart nginx
   ```

## Environment Variables

Required for production:
```env
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxx
FLASK_ENV=production
DEBUG=False
```

Optional:
```env
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
SENTRY_DSN=https://...
```

## Monitoring

### Sentry (Error Tracking)
```bash
pip install sentry-sdk
```

Add to `backend/api.py`:
```python
import sentry_sdk
from sentry_sdk.integrations.flask import FlaskIntegration

sentry_sdk.init(
    dsn=os.getenv('SENTRY_DSN'),
    integrations=[FlaskIntegration()],
    traces_sample_rate=1.0
)
```

### Prometheus & Grafana
Already configured in Docker and Systemd setup

## SSL/HTTPS

### For Vercel
- Automatic SSL provided

### For custom domains
```bash
# Using Let's Encrypt
sudo apt install certbot python3-certbot-nginx
sudo certbot certonly --nginx -d your-domain.com
```

## Scaling

### For High Traffic
1. Increase Gunicorn workers
2. Add Redis for caching
3. Use PostgreSQL for persistent storage
4. Enable CDN (Cloudflare)

## Performance Checklist

- [ ] API key secure in environment variables
- [ ] CORS configured correctly
- [ ] Security headers enabled
- [ ] Monitoring/Sentry configured
- [ ] Database connection pooling enabled
- [ ] Redis caching active
- [ ] CDN configured
- [ ] SSL/HTTPS enabled
- [ ] Rate limiting configured
- [ ] Error logging enabled

## Support

Issues? Check these resources:
- [Vercel Docs](https://vercel.com/docs)
- [Flask Documentation](https://flask.palletsprojects.com)
- [Anthropic API Docs](https://docs.anthropic.com)
- [GitHub Issues](https://github.com/heygaurav1/Audra-Labs/issues)
