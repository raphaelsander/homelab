# Media Server

## Install Dependencies

```bash
sudo apt install ansible
```

## Como usar

```bash
# 1) edite group_vars/all.yml (IPs, zone, token CF, etc)
# 2) instale as collections
ansible-galaxy collection install -r requirements.yml

# 3) rode o playbook completo
ansible-playbook site.yml
```

### Renovação de certificados

- **dns-01 (Ansible)**: agende um cron/CI para executar somente o último play (localhost) periodicamente.
- **http-01 (VyOS nativo)**: o VyOS agenda renovações automaticamente; você pode forçar com `renew certbot` (op-mode).

---

## Notas importantes

- Para Let’s Encrypt **http-01**, a porta **80** do domínio precisa chegar no VyOS.
- Para Let’s Encrypt **dns-01**, a zona pública deve ser administrada pelo Cloudflare (ou adapte o módulo DNS do seu provedor).
- Para a delegação de `*.local.blackcat.dev.br` ao VyOS, configure os **NS** no DNS pai (ex.: Cloudflare) apontando para o IP público do VyOS. Internamente a automação cria o `NS @ → vyos.local.blackcat.dev.br` e `A vyos → 192.168.0.4` (ajuste conforme exposto).
- Ajuste `allow-from` do DNS para as suas redes; evite recursor aberto.
- Se o backend `172.16.1.2:9443` usa certificado self‑signed, estamos usando `ssl` sem verificação (no‑verify) implicitamente; para validação, importe a CA e use `ssl ca-certificate` no backend.
