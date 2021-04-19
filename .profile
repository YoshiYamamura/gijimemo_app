echo ${GOOGLE_CREDENTIALS} > /app/gcp_key.json
worker: bundle exec rake jobs:work