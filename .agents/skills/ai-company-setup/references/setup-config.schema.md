# Setup Config Schema

`init-ai-company.sh --config <file.json>`

```json
{
  "workspaceName": "taiyo-ai-company",
  "destinationRoot": "/Users/kimurataiyou/ai-company",
  "companySlug": "kimura-taiyo",
  "businessSlug": "consulting",
  "ownerName": "木村 太陽",
  "ownerEmail": "4869nanataitai@gmail.com",
  "migrationMode": "COPY_ONLY",
  "language": "ja",
  "sourcePaths": []
}
```

## Fields

- `workspaceName`: human-readable workspace label
- `destinationRoot`: absolute path for DESTINATION_ROOT (required)
- `companySlug`: folder name under `02-company_knowledge/`
- `businessSlug`: folder name under `01-Business content/`
- `ownerName`, `ownerEmail`: written into `USER.md`
- `migrationMode`: `PLAN_ONLY | COPY_ONLY | APPLY_AFTER_CONFIRMATION`
- `language`: `ja` only for now
- `sourcePaths`: optional list of folders to stage later with `stage-raw-data.sh`
