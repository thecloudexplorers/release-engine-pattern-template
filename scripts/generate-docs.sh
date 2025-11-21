#!/bin/bash
set -e

echo "🚀 Starting documentation generation..."

# Create downloads directory if it doesn't exist
mkdir -p downloads

# List of documents to generate
declare -A DOCUMENTS=(
    ["README"]="README.md"
    ["PATTERNS_OVERVIEW"]="docs/PATTERNS_OVERVIEW.md"
    ["resource_group_scope_pattern"]="patterns/resource_group_scope_pattern/README.md"
    ["subscription_scope_pattern"]="patterns/subscription_scope_pattern/README.md"
    ["multi_stage_pattern"]="patterns/multi_stage_pattern/README.md"
)

echo "📄 Generating DOCX files using Pandoc..."
for key in "${!DOCUMENTS[@]}"; do
    source_file="${DOCUMENTS[$key]}"
    output_file="downloads/${key}.docx"
    
    if [ -f "$source_file" ]; then
        echo "  Converting $source_file to $output_file"
        pandoc "$source_file" \
            -f gfm \
            -t docx \
            -o "$output_file" \
            --standalone \
            --toc \
            --toc-depth=3 \
            --metadata title="Release Engine - $(basename $key)" \
            2>/dev/null || echo "    ⚠️  Warning: Could not convert $source_file (mermaid diagrams will be skipped in DOCX)"
    else
        echo "  ⚠️  Warning: Source file $source_file not found, skipping"
    fi
done

echo "📑 Generating PDF files using Pandoc with wkhtmltopdf..."
for key in "${!DOCUMENTS[@]}"; do
    source_file="${DOCUMENTS[$key]}"
    output_file="downloads/${key}.pdf"
    
    if [ -f "$source_file" ]; then
        echo "  Converting $source_file to $output_file"
        # First convert markdown to HTML, then use wkhtmltopdf for PDF
        pandoc "$source_file" \
            -f gfm \
            -t html \
            --standalone \
            --toc \
            --toc-depth=3 \
            --metadata title="Release Engine - $(basename $key)" \
            -o "downloads/${key}.html" \
            2>/dev/null || echo "    ⚠️  Warning: Could not convert $source_file to HTML"
        
        # Convert HTML to PDF using wkhtmltopdf if available
        if command -v wkhtmltopdf &> /dev/null; then
            wkhtmltopdf \
                --enable-local-file-access \
                --page-size A4 \
                --margin-top 20mm \
                --margin-bottom 20mm \
                --margin-left 15mm \
                --margin-right 15mm \
                "downloads/${key}.html" \
                "$output_file" \
                2>/dev/null || echo "    ⚠️  Warning: wkhtmltopdf failed for $source_file"
            
            # Clean up intermediate HTML file
            rm -f "downloads/${key}.html"
        else
            echo "    ℹ️  wkhtmltopdf not found, using pandoc for PDF generation"
            pandoc "$source_file" \
                -f gfm \
                -t pdf \
                -o "$output_file" \
                --standalone \
                --toc \
                --toc-depth=3 \
                --pdf-engine=xelatex \
                --metadata title="Release Engine - $(basename $key)" \
                2>/dev/null || echo "    ⚠️  Warning: Could not convert $source_file to PDF"
        fi
    else
        echo "  ⚠️  Warning: Source file $source_file not found, skipping"
    fi
done

echo "✅ Documentation generation complete!"
echo "📦 Generated files are in the 'downloads' directory"
ls -lh downloads/
