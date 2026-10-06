# Terraform DNS Training — User Guide

## 1. Project Purpose

This project is a small Terraform project for managing a DigitalOcean DNS `A` record.

The project was intentionally developed and tested locally first.

No DigitalOcean DNS record has been created by this project.

Repository:

`DeeRathnayaka/terraform-dns`

## 2. Project Structure

```text
terraform-dns/
├── .gitignore
├── .terraform.lock.hcl
├── README.md
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
```

## 3. Terraform Configuration

The DNS resource is defined in `main.tf`:

```hcl
resource "digitalocean_record" "dns_record" {
  domain = var.domain_name
  type   = "A"
  name   = var.record_name
  value  = var.record_value
  ttl    = var.ttl
}
```

The required inputs are declared in `variables.tf`:

```text
domain_name
record_name
record_value
ttl
```

The actual local values are provided through `terraform.tfvars`.

Example:

```hcl
domain_name  = "example.com"
record_name  = "training"
record_value = "203.0.113.20"
ttl          = 300
```

`terraform.tfvars` is intentionally ignored by Git.

## 4. DigitalOcean Authentication

When testing against DigitalOcean, provide the DigitalOcean Personal Access Token through the environment.

Do not put the token into `main.tf`, `provider.tf`, or `terraform.tfvars`.

On the machine running Terraform:

```bash
export DIGITALOCEAN_TOKEN="YOUR_DIGITALOCEAN_TOKEN"
```

Verify that the variable exists without displaying its value:

```bash
if [ -n "$DIGITALOCEAN_TOKEN" ]; then
  echo "DIGITALOCEAN_TOKEN is set"
else
  echo "DIGITALOCEAN_TOKEN is NOT set"
fi
```

The Terraform provider configuration is intentionally minimal:

```hcl
provider "digitalocean" {
}
```

The provider reads the authentication information from the environment.

## 5. Configure the DNS Test

Create the local variables file if it does not already exist:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit it:

```bash
nano terraform.tfvars
```

Use a **non-production/test domain** for the first test.

Example:

```hcl
domain_name  = "example.com"
record_name  = "training"
record_value = "203.0.113.20"
ttl          = 300
```

Do not use a production DNS zone without approval.

## 6. Initialize Terraform

From the project directory:

```bash
cd ~/devops-training/terraform-dns
```

Run:

```bash
terraform init
```

Expected result:

```text
Terraform has been successfully initialized!
```

## 7. Format and Validate

Run:

```bash
terraform fmt
terraform validate
```

Expected validation result:

```text
Success! The configuration is valid.
```

## 8. Test Authentication / Provider Access

Run:

```bash
terraform plan
```

Terraform should authenticate with DigitalOcean and evaluate the requested DNS resource.

Review the plan carefully.

The expected resource is:

```text
digitalocean_record.dns_record
```

The first successful plan should indicate that Terraform wants to create one DNS record.

For example:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

## 9. Review Before Apply

**Do not apply automatically.**

Check that the plan contains only the intended DNS record:

```text
domain = <approved test domain>
type   = "A"
name   = <approved record name>
value  = <approved IPv4 address>
ttl    = 300
```

There should not be unexpected resources.

If the plan is correct and the DNS change has been explicitly approved, continue.

## 10. Apply

After review and approval:

```bash
terraform apply
```

Terraform will display the proposed changes and request confirmation.

Enter:

```text
yes
```

only after confirming the plan is correct.

## 11. Verify Terraform State

After a successful apply:

```bash
terraform state list
```

Expected:

```text
digitalocean_record.dns_record
```

Check the Terraform outputs:

```bash
terraform output
```

The project exposes:

```text
dns_record_fqdn
dns_record_id
```

## 12. Verify the DNS Record

Verify the DNS record using an appropriate DNS lookup tool:

```bash
dig <record-name>.<domain>
```

or:

```bash
nslookup <record-name>.<domain>
```

The returned address should match the configured IPv4 address.

Remember that DNS propagation and caching can affect the result.

## 13. Destroy Test Infrastructure

If the record was created only for testing and should be removed:

```bash
terraform destroy
```

Review the destruction plan carefully.

Only confirm with:

```text
yes
```

after verifying that Terraform is removing only the intended test record.

## 14. Important Safety Checks

Before applying:

```bash
git status
```

The repository should remain clean except for intentionally ignored local files.

Check that sensitive/local Terraform files are not tracked:

```bash
git ls-files | grep -E 'terraform\.tfvars$|\.tfstate$|\.tfstate\.|\.terraform/'
```

This should produce no output.

## 15. Expected Test Flow

The complete testing sequence is:

```text
Set DigitalOcean authentication
        ↓
Configure terraform.tfvars
        ↓
terraform init
        ↓
terraform fmt
        ↓
terraform validate
        ↓
terraform plan
        ↓
Review plan
        ↓
Senior approval
        ↓
terraform apply
        ↓
terraform state list
        ↓
DNS verification
        ↓
terraform destroy (if test resource should be removed)
```

## 16. Current Project Scope

The current project intentionally supports only a DNS `A` record.

It is a training project and has not been designed yet for:

* Multiple DNS record types
* Production DNS management
* Remote Terraform state
* State locking
* CI/CD deployment
* Automated production changes

Those can be introduced as later improvements after the basic Terraform workflow is understood.
