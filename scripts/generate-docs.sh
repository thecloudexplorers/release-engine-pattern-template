#!/bin/bash
set -e

echo "🚀 Starting documentation generation..."

# Create downloads directory and logs directory if they don't exist
mkdir -p downloads
mkdir -p /tmp/doc-generation-logs

# List of documents to generate with friendly titles
declare -A DOCUMENTS=(
    ["README"]="README.md"
    ["PATTERNS_OVERVIEW"]="docs/PATTERNS_OVERVIEW.md"
    ["resource_group_scope_pattern"]="patterns/resource_group_scope_pattern/README.md"
    ["subscription_scope_pattern"]="patterns/subscription_scope_pattern/README.md"
    ["multi_stage_pattern"]="patterns/multi_stage_pattern/README.md"
)

# Document titles for better PDF/DOCX metadata
declare -A TITLES=(
    ["README"]="Release Engine Workload Patterns - Repository Overview"
    ["PATTERNS_OVERVIEW"]="Release Engine - Patterns Overview and Architecture Guide"
    ["resource_group_scope_pattern"]="Resource Group Scope Pattern Documentation"
    ["subscription_scope_pattern"]="Subscription Scope Pattern Documentation"
    ["multi_stage_pattern"]="Multi Stage Pattern Documentation"
)

echo "📄 Generating DOCX files using Pandoc..."
for key in "${!DOCUMENTS[@]}"; do
    source_file="${DOCUMENTS[$key]}"
    output_file="downloads/${key}.docx"
    log_file="/tmp/doc-generation-logs/${key}_docx.log"
    
    if [ -f "$source_file" ]; then
        echo "  Converting $source_file to $output_file"
        if pandoc "$source_file" \
            -f gfm \
            -t docx \
            -o "$output_file" \
            --standalone \
            --toc \
            --toc-depth=3 \
            --metadata title="${TITLES[$key]}" \
            2>"$log_file"; then
            echo "    ✅ Successfully generated $output_file"
        else
            echo "    ⚠️  Warning: Could not convert $source_file (mermaid diagrams will be skipped in DOCX)"
            echo "    📝 Check log file: $log_file"
        fi
    else
        echo "  ⚠️  Warning: Source file $source_file not found, skipping"
    fi
done

echo "📑 Generating PDF files using Pandoc with wkhtmltopdf..."
for key in "${!DOCUMENTS[@]}"; do
    source_file="${DOCUMENTS[$key]}"
    output_file="downloads/${key}.pdf"
    log_file="/tmp/doc-generation-logs/${key}_pdf.log"
    
    if [ -f "$source_file" ]; then
        echo "  Converting $source_file to $output_file"
        # First convert markdown to HTML, then use wkhtmltopdf for PDF
        if pandoc "$source_file" \
            -f gfm \
            -t html \
            --standalone \
            --toc \
            --toc-depth=3 \
            --metadata title="${TITLES[$key]}" \
            -o "downloads/${key}.html" \
            2>"${log_file}.html"; then
            
            # Convert HTML to PDF using wkhtmltopdf if available
            if command -v wkhtmltopdf &> /dev/null; then
                if wkhtmltopdf \
                    --enable-local-file-access \
                    --page-size A4 \
                    --margin-top 20mm \
                    --margin-bottom 20mm \
                    --margin-left 15mm \
                    --margin-right 15mm \
                    "downloads/${key}.html" \
                    "$output_file" \
                    2>"$log_file"; then
                    echo "    ✅ Successfully generated $output_file"
                else
                    echo "    ⚠️  Warning: wkhtmltopdf failed for $source_file"
                    echo "    📝 Check log file: $log_file"
                fi
                
                # Clean up intermediate HTML file
                rm -f "downloads/${key}.html"
            else
                echo "    ℹ️  wkhtmltopdf not found, using pandoc for PDF generation"
                if pandoc "$source_file" \
                    -f gfm \
                    -t pdf \
                    -o "$output_file" \
                    --standalone \
                    --toc \
                    --toc-depth=3 \
                    --pdf-engine=xelatex \
                    --metadata title="${TITLES[$key]}" \
                    2>"$log_file"; then
                    echo "    ✅ Successfully generated $output_file"
                else
                    echo "    ⚠️  Warning: Could not convert $source_file to PDF"
                    echo "    📝 Check log file: $log_file"
                fi
            fi
        else
            echo "    ⚠️  Warning: Could not convert $source_file to HTML"
            echo "    📝 Check log file: ${log_file}.html"
        fi
    else
        echo "  ⚠️  Warning: Source file $source_file not found, skipping"
    fi
done

echo "✅ Documentation generation complete!"
echo "📦 Generated files are in the 'downloads' directory"
ls -lh downloads/
