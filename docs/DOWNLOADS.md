# Documentation Downloads

This page provides easy access to downloadable versions of all Release Engine Workload Patterns documentation in PDF and DOCX formats.

## 📥 Available Formats

All documentation is available in two formats:
- **PDF**: Best for printing and archiving, preserves formatting
- **DOCX**: Microsoft Word format, ideal for editing and collaboration

## 📚 Main Documentation

### Repository Overview
Complete overview of the Release Engine Workload Patterns template repository.

- [📄 README.pdf](../downloads/README.pdf)
- [📝 README.docx](../downloads/README.docx)

## 🏗️ Architecture Documentation

### Patterns Overview
Comprehensive guide to all available workload patterns, including comparison matrices, selection guides, and technical architecture details.

- [📄 PATTERNS_OVERVIEW.pdf](../downloads/PATTERNS_OVERVIEW.pdf)
- [📝 PATTERNS_OVERVIEW.docx](../downloads/PATTERNS_OVERVIEW.docx)

## 📋 Pattern-Specific Documentation

### Resource Group Scope Pattern
The simplest deployment pattern demonstrating single resource deployments within a resource group.

- [📄 resource_group_scope_pattern.pdf](../downloads/resource_group_scope_pattern.pdf)
- [📝 resource_group_scope_pattern.docx](../downloads/resource_group_scope_pattern.docx)

### Subscription Scope Pattern
Intermediate pattern for subscription-level resource deployments and resource group creation.

- [📄 subscription_scope_pattern.pdf](../downloads/subscription_scope_pattern.pdf)
- [📝 subscription_scope_pattern.docx](../downloads/subscription_scope_pattern.docx)

### Multi Stage Pattern
Advanced pattern showcasing complex, multi-stage deployments with dependencies and parallel execution.

- [📄 multi_stage_pattern.pdf](../downloads/multi_stage_pattern.pdf)
- [📝 multi_stage_pattern.docx](../downloads/multi_stage_pattern.docx)

## 🔄 Document Generation

These documents are automatically generated from the repository's markdown documentation whenever changes are pushed to the main branch. The generation process:

1. **Source**: Markdown files in the repository
2. **PDF Generation**: Uses Pandoc with wkhtmltopdf for high-quality PDF output
3. **DOCX Generation**: Uses Pandoc for Microsoft Word-compatible documents
4. **Automation**: GitHub Actions workflow runs on every documentation update

### Regenerating Documents

To regenerate the documentation locally:

```bash
# Requires Pandoc and wkhtmltopdf installed
bash scripts/generate-docs.sh
```

### Prerequisites for Local Generation

Install the required tools:

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y pandoc wkhtmltopdf texlive-xetex texlive-fonts-recommended
```

**macOS:**
```bash
brew install pandoc
brew install --cask wkhtmltopdf
```

**Windows:**
- Download Pandoc from: https://pandoc.org/installing.html
- Download wkhtmltopdf from: https://wkhtmltopdf.org/downloads.html

## 📝 Notes on Document Formats

### PDF Documents
- Include table of contents with hyperlinks
- Preserve most formatting from markdown
- **Note**: Mermaid diagrams may not render in PDF format. For best diagram viewing, refer to the online documentation.
- Optimized for A4 paper size with appropriate margins

### DOCX Documents
- Fully editable in Microsoft Word or compatible applications
- Include table of contents
- Preserve most markdown formatting as Word styles
- **Note**: Mermaid diagrams are not included in DOCX format. For diagrams, refer to the online documentation or PDF exports.
- Can be customized with your organization's branding

## 🔗 Related Resources

- [Main Repository](../README.md)
- [Architecture Overview](PATTERNS_OVERVIEW.md)
- [Release Engine Core](https://github.com/thecloudexplorers/release-engine-core)
- [Configuration Template](https://github.com/thecloudexplorers/release-engine-config-template)

## 📮 Feedback

If you encounter issues with the generated documents or have suggestions for improvements:
- Open an issue in the repository
- Contribute improvements to the generation scripts
- Share your feedback with the Release Engine team

---

*Documents are automatically updated on every main branch commit that modifies markdown documentation.*
