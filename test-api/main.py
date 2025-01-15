from fastapi import FastAPI, Request, Response, HTTPException
from fastapi.responses import RedirectResponse, HTMLResponse
from fastapi.templating import Jinja2Templates
import httpx
import os
from urllib.parse import urlencode
from fastapi.staticfiles import StaticFiles

app = FastAPI()
templates = Jinja2Templates(directory="templates")

# Keycloak settings
KEYCLOAK_URL = "http://localhost:8080"
REALM_NAME = "myrealm"
CLIENT_ID = "test-client"
CLIENT_SECRET = "your-client-secret"  # Replace with your client secret
REDIRECT_URI = "http://localhost:8000/callback"

# OAuth endpoints
AUTH_URL = f"{KEYCLOAK_URL}/realms/{REALM_NAME}/protocol/openid-connect/auth"
TOKEN_URL = f"{KEYCLOAK_URL}/realms/{REALM_NAME}/protocol/openid-connect/token"
LOGOUT_URL = f"{KEYCLOAK_URL}/realms/{REALM_NAME}/protocol/openid-connect/logout"

@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse(
        "index.html",
        {"request": request}
    )

@app.get("/login")
async def login():
    params = {
        "client_id": CLIENT_ID,
        "response_type": "code",
        "redirect_uri": REDIRECT_URI,
        "scope": "openid profile email"
    }
    auth_url = f"{AUTH_URL}?{urlencode(params)}"
    return RedirectResponse(auth_url)

@app.get("/callback")
async def callback(code: str):
    token_data = {
        "grant_type": "authorization_code",
        "code": code,
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "redirect_uri": REDIRECT_URI
    }
    
    async with httpx.AsyncClient() as client:
        response = await client.post(TOKEN_URL, data=token_data)
        if response.status_code != 200:
            raise HTTPException(status_code=400, detail="Token exchange failed")
        
        tokens = response.json()
        return RedirectResponse(url="/dashboard")

@app.get("/dashboard", response_class=HTMLResponse)
async def dashboard(request: Request):
    return templates.TemplateResponse(
        "dashboard.html",
        {"request": request}
    )

@app.get("/logout")
async def logout():
    params = {
        "redirect_uri": "http://localhost:8000/"
    }
    logout_url = f"{LOGOUT_URL}?{urlencode(params)}"
    return RedirectResponse(logout_url)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
