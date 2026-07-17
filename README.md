# LLW-CS

Ruby on Rails application for LLW Consulting Services.

## Requirements

* Ruby 3.3.2
* PostgreSQL

## Local Development

```bash
bundle install
bin/rails db:setup
bin/rails server
```

## Deployment (Render)

The app is deployed on [Render](https://render.com) using the `render.yaml`
infrastructure-as-code file in the repository root. The build script is
`bin/render-build.sh`.

### Fixing the SSL Certificate / `net::ERR_CERT_COMMON_NAME_INVALID` Error

The `net::ERR_CERT_COMMON_NAME_INVALID` browser error means the SSL certificate
presented by the server does not match the domain being visited (e.g.
`www.llw-cs.com`). Render provisions SSL certificates automatically for custom
domains, but only **after** the domain is added in the Render dashboard and the
DNS records are correctly pointing to Render.

Follow these steps **in Render's dashboard** to resolve the error:

1. Open your web service in the [Render dashboard](https://dashboard.render.com).
2. Go to **Settings → Custom Domains**.
3. Add both `llw-cs.com` and `www.llw-cs.com` as custom domains.
4. Render will display the DNS records you need to create (typically `CNAME` or
   `ALIAS`/`ANAME` records).
5. In your DNS provider (e.g. GoDaddy, Cloudflare, Namecheap), create the
   records shown by Render:
   - `www.llw-cs.com` → CNAME → `<your-service>.onrender.com`
   - `llw-cs.com`     → ALIAS/ANAME (or CNAME if supported) → `<your-service>.onrender.com`
6. Wait for DNS propagation (up to 48 hours, usually much faster).
7. Render will automatically provision a free Let's Encrypt certificate once it
   can verify ownership of the domain. The SSL status in the dashboard will
   change from **Pending** to **Verified**.

> **Note:** If you are redirecting `llw-cs.com` → `www.llw-cs.com` at the DNS
> level, make sure Render has issued a certificate for **both** names so the
> redirect itself is served over HTTPS without a certificate error.

### Rails SSL Configuration

The production environment (`config/environments/production.rb`) is already
configured with:

```ruby
config.assume_ssl = true   # tells Rails it sits behind an SSL-terminating proxy
config.force_ssl  = true   # redirects HTTP → HTTPS and sets HSTS header
config.hosts      = ["llw-cs.com", "www.llw-cs.com"]
```

These settings are correct for a Render deployment and **do not need to be
changed**. The certificate error can only be resolved by completing the custom
domain setup in the Render dashboard as described above.
