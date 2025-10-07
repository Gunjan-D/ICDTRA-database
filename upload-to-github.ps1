# ICDTRA Website GitHub Upload Script
# Run this script after creating your GitHub repository

echo "🚀 ICDTRA Website GitHub Upload Script"
echo "======================================"
echo ""

# Initialize git repository
echo "📁 Initializing Git repository..."
git init

# Add all files
echo "📂 Adding all website files..."
git add .

# Create initial commit
echo "💾 Creating initial commit..."
git config user.name "ICDTRA Developer"
git config user.email "your-email@example.com"
git commit -m "Initial commit: ICDTRA Website with all pages and assets"

echo ""
echo "✅ Files prepared for upload!"
echo ""
echo "🔗 Next Steps:"
echo "1. Replace 'YOUR_USERNAME' and 'YOUR_REPO_NAME' in the command below"
echo "2. Copy and paste this command in PowerShell:"
echo ""
echo "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "📖 After upload, enable GitHub Pages:"
echo "1. Go to your repository on GitHub"
echo "2. Click 'Settings' tab"
echo "3. Scroll to 'Pages' section"
echo "4. Under 'Source', select 'Deploy from a branch'"
echo "5. Choose 'main' branch and '/ (root)' folder"
echo "6. Click 'Save'"
echo ""
echo "🌐 Your website will be available at:"
echo "   https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/"