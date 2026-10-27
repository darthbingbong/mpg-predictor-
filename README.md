# Fuel Economy Predictor (MPG)

A Shiny app that predicts a car's fuel economy (miles per gallon) from its weight,
horsepower and transmission type, using a linear model fitted on R's built-in `mtcars` data.

- `app/ui.R`, `app/server.R` – the Shiny application (documentation is in the app's "How to use" tab)
- `pitch/mpg_pitch.Rpres` – 5-slide RStudio Presenter pitch with embedded R code

---

## Step-by-step: getting your two submission URLs

### 1. Test the app locally
```r
install.packages(c("shiny", "rsconnect"))
shiny::runApp("app")
```

### 2. Deploy the app to shinyapps.io  →  **Shiny Application URL**
1. Sign up free at https://www.shinyapps.io
2. Account → Tokens → **Show** → copy the `rsconnect::setAccountInfo(...)` line and run it in R.
3. Deploy:
   ```r
   rsconnect::deployApp("app", appName = "mpg-predictor")
   ```
4. Your link will be `https://YOUR-ACCOUNT.shinyapps.io/mpg-predictor/`

### 3. Make the pitch  →  **Presentation URL**
1. Edit `pitch/mpg_pitch.Rpres`: replace `Your Name`, `YOUR-ACCOUNT` and `YOUR-USERNAME`.
2. Open it in RStudio and click **Preview** to check all 5 slides render with no errors.
3. In the Presentation pane click **Publish** (blue icon) → **RPubs** → sign in → publish.
4. Copy the RPubs link. The assignment asks for **http://** (not https), e.g.
   `http://rpubs.com/YOUR-USERNAME/mpg-pitch`

### 4. Put the code on GitHub
```bash
git init
git add .
git commit -m "MPG predictor Shiny app and pitch"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/mpg-predictor.git
git push -u origin main
```

### 5. Submit
- **Project Title:** Fuel Economy Predictor (MPG)
- **Shiny Application URL:** your shinyapps.io link
- **Presentation URL:** your http:// RPubs link
