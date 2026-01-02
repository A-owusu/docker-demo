# Copilot / AI Agent Instructions for docker-demo

This file captures repository-specific facts and patterns to help an AI coding agent be immediately productive.

High-level architecture
- The project is a minimal, containerized Flask service. The runnable app used for Docker is in `app/main.py` (Dockerfile copies `app/` into the image).
- Dockerfile: `python:3.10-slim` base, installs `app/requirements.txt`, copies `app/` and runs `python main.py` exposing port `5000`.
- There is also a top-level `main.py` (local convenience) but production image uses `app/main.py`.

Developer workflows & CI/CD
- Local build: `docker build -t docker-demo .` then `docker run -p 5000:5000 docker-demo`.
- Jenkins pipeline in `Jenkinsfile` builds, (placeholder) tests, pushes to Docker Hub, and deploys by stopping any `flask-app` container and running the new image.
- Jenkins expects a credential named `dockerhub` and uses environment variables referenced as `DOCKERHUB_USR` / `DOCKERHUB_PSW` when logging in and pushing. Agents modifying CI should preserve these names or confirm Jenkins credential setup.
- The `Test` stage currently only echoes a line — there are no unit tests in the repo. Avoid adding tests that change workflow assumptions without user approval.

Project-specific conventions & patterns
- Dockerfile pattern: copy `app/requirements.txt` first, `pip install` it, then copy the rest. Follow this ordering to keep image layer caching behavior intact.
- Port: service listens on `0.0.0.0:5000`. Use port `5000` when running or mapping containers.
- Requirements: top-level `requirements.txt` pins `Flask==2.3.2`, while `app/requirements.txt` uses `flask` (un-pinned). The Dockerfile installs from `app/requirements.txt` — agents should prefer that as the source of truth for container builds unless asked to reconcile versions.
- Shell usage in CI: `Jenkinsfile` uses `sh` steps (Unix shell). Assume Linux-based Jenkins agents with Docker available.

Integration points & external dependencies
- Docker Hub: image name is hardcoded in `Jenkinsfile` as `owusu495/flask-app`. Changing this affects CI; confirm with maintainers before renaming.
- Jenkins: pipeline expects a Docker-enabled executor and Jenkins credentials named `dockerhub`.

What to change (guidance for agents)
- Non-invasive improvements are welcome: small readability edits, updating README examples to match Dockerfile, fixing obvious typos.
- Avoid changing CI credential names, image names, or the Dockerfile layering without explicit user approval.
- If you introduce tests or new build steps, add a corresponding update to `Jenkinsfile` and explain required Jenkins credential/agent changes in the PR description.

Examples (use these when editing or adding code)
- Build image (local): `docker build -t docker-demo .`
- Run container (local): `docker run -d -p 5000:5000 --name flask-app docker-demo`
- Jenkins image reference: `owusu495/flask-app:latest` (see `Jenkinsfile`)

Files to inspect when making changes
- `Dockerfile` — image layering and entrypoint
- `app/main.py` — containerized app logic
- `main.py` (repo root) — local dev convenience
- `Jenkinsfile` — CI/CD flow and credentials
- `app/requirements.txt` and `requirements.txt` — dependency pins (note the mismatch)

If anything here is unclear or you want me to adjust scope (e.g., reconcile requirements, update Jenkinsfile, or add tests), tell me which area to prioritize.
