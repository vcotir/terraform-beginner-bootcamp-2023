// the main package is a special package that serves as the entry point for your Go programs. 
	// Unlike other packages in Go, the main package is the one that allows you to create executable programs.
package main 

// The fmt package in Go's standard library provides functions for formatted input and output operations, 
	// including printing and reading data with format specifiers, string formatting, and error message formatting.
import (
	// "log"
	"fmt"
	// https://developer.hashicorp.com/terraform/plugin/sdkv2/guides/v2-upgrade-guide#version-2-of-the-module
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	// https://developer.hashicorp.com/terraform/tutorials/providers/provider-setup
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	// "github.com/google/uuid"
)

func main () {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// Format.PrintLine
		// Prints to standard output
		fmt.Println("Hello, World!")

}


// Go lang has interfaces, not clases
// In golang, titlecase function will get exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		// Resources to pull in
		ResourcesMap: map[string]*schema.Resource{

		},
		// Fields to be used
		DataSourcesMap: map[string]*schema.Resource{
			
		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Required: true,
				Sensitive: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				// ValidateFunct: validateUUID,
			},
		},
	}
	// p.ConfigureContextFunc = providerConfigure(p)

	// schema at provider level, 
		// schema are resource level (interacting with resources)
	return p
}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
// 	log.Print('validateUUID:start')
// 	value := v.(string)
// 	if _, err = uuid.Parse(value); err != nill {
// 		errors = append(error, fmt.Errorf("Invalid UUID format"))
// 	}
// 	log.Print("validateUUID:end")
// }
	