## kubectl-rb

The Kubernetes CLI, eg. [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) distributed as a Rubygem.

## Intro

Kubectl is the command-line interface for Kubernetes.

It's wrapped up as a Rubygem here to make it easy to distribute with Ruby apps, and was originally created for the [Kuby](https://github.com/getkuby/kuby-core) project.

## Usage

There is only one method that returns the absolute path to the kubectl executable:

```ruby
require 'kubectl-rb'

# /Users/me/.rbenv/versions/2.5.6/lib/ruby/gems/2.5.0/gems/kubectl-rb-0.1.0-x86_64-darwin/vendor/kubectl
KubectlRb.executable
```

The version of kubectl can be obtained like so:

```ruby
require 'kubectl-rb/version'

# "1.18.3"
KubectlRb::KUBECTL_VERSION
```

## License

Kubernetes and kubectl are licensed under the Apache 2 license. The LICENSE file contains a copy.

## Authors

* Cameron C. Dutro: http://github.com/camertron
