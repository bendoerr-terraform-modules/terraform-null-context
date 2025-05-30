package test_test

import (
	"fmt"
	"reflect"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/kr/pretty"
)

func TestExamplesComplete(t *testing.T) {
	rootFolder := "../"
	terraformFolderRelativeToRoot := "examples/complete"

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		VarFiles:     []string{"complete.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Type for capturing shared context
	//nolint:revive,staticcheck // These are external names
	type shared struct {
		Attributes     []string
		Dns_Namespace  string
		Environment    string
		Instance       string
		Instance_Short string
		Namespace      string
		Region         string
		Region_Short   string
		Role           string
		Role_Short     string
		Project        string
		Tags           map[string]string
		Long_DNS       bool
	}

	// Type for running tests
	tests := []struct {
		outputVar string
		shared    shared
	}{
		{
			outputVar: "ctx_full_shared",
			shared: shared{
				Attributes: []string{
					"attr1",
				},
				Dns_Namespace:  "dmo.uw2",
				Environment:    "env",
				Instance:       "demo",
				Instance_Short: "dmo",
				Namespace:      "ex",
				Region:         "us-west-2",
				Region_Short:   "uw2",
				Role:           "production",
				Role_Short:     "prd",
				Project:        "test",
				Tags: map[string]string{
					"ExtraTag":  "ExtraTagValue",
					"Instance":  "demo",
					"Region":    "us-west-2",
					"Role":      "production",
					"Workspace": "default",
					"Project":   "test",
				},
			},
		},
		{
			outputVar: "ctx_full_long_dns_shared",
			shared: shared{
				Attributes: []string{
					"attr1",
				},
				Dns_Namespace:  "dmo.uw2.prd.ex",
				Environment:    "env",
				Instance:       "demo",
				Instance_Short: "dmo",
				Namespace:      "ex",
				Region:         "us-west-2",
				Region_Short:   "uw2",
				Role:           "production",
				Role_Short:     "prd",
				Project:        "test",
				Tags: map[string]string{
					"ExtraTag":  "ExtraTagValue",
					"Instance":  "demo",
					"Region":    "us-west-2",
					"Role":      "production",
					"Workspace": "default",
					"Project":   "test",
				},
			},
		},
		{
			outputVar: "ctx_no_env_shared",
			shared: shared{
				Attributes: []string{
					"attr1",
				},
				Dns_Namespace:  "dmo.uw2",
				Environment:    "prd-uw2-dmo",
				Instance:       "demo",
				Instance_Short: "dmo",
				Namespace:      "ex",
				Region:         "us-west-2",
				Region_Short:   "uw2",
				Role:           "production",
				Role_Short:     "prd",
				Tags: map[string]string{
					"ExtraTag":  "ExtraTagValue",
					"Instance":  "demo",
					"Region":    "us-west-2",
					"Role":      "production",
					"Workspace": "default",
				},
			},
		},
		{
			outputVar: "ctx_no_env_no_instance_shared",
			shared: shared{
				Attributes: []string{
					"attr1",
				},
				Dns_Namespace:  "uw2",
				Environment:    "prd-uw2",
				Instance:       "",
				Instance_Short: "",
				Namespace:      "ex",
				Region:         "us-west-2",
				Region_Short:   "uw2",
				Role:           "production",
				Role_Short:     "prd",
				Tags: map[string]string{
					"ExtraTag":  "ExtraTagValue",
					"Region":    "us-west-2",
					"Role":      "production",
					"Workspace": "default",
				},
			},
		},
		{
			outputVar: "ctx_short_shared",
			shared: shared{
				Attributes: []string{
					"attr1",
				},
				Dns_Namespace:  "uw2",
				Environment:    "prod-uw2",
				Instance:       "",
				Instance_Short: "",
				Namespace:      "ex",
				Region:         "us-west-2",
				Region_Short:   "uw2",
				Role:           "production",
				Role_Short:     "prod",
				Tags: map[string]string{
					"ExtraTag":  "ExtraTagValue",
					"Region":    "us-west-2",
					"Role":      "production",
					"Workspace": "default",
				},
			},
		},
	}

	for _, tc := range tests {
		t.Run(tc.outputVar, func(tt *testing.T) {
			output := shared{}
			terraform.OutputStruct(tt, terraformOptions, tc.outputVar, &output)
			if !reflect.DeepEqual(tc.shared, output) {
				tt.Fatal(makediff(tc.shared, output))
			}
		})
	}
}

func makediff(want, got interface{}) string {
	s := fmt.Sprintf("\nwant: %# v", pretty.Formatter(want))
	s = fmt.Sprintf("%s\ngot: %# v", s, pretty.Formatter(got))
	diffs := pretty.Diff(want, got)
	s += "\ndifferences: "
	for _, d := range diffs {
		s = fmt.Sprintf("%s\n  - %s", s, d)
	}
	return s
}
