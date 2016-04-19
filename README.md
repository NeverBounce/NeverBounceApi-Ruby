NeverBounce API Ruby Wrapper
---

This is the official NeverBounce API Ruby wrapper. It provides helpful methods to quickly implement our API in your Ruby applications.

Installation
===

```
$ gem install NeverBounce
```

Usage
===

To start using the wrapper sign up for an account [here](https://app.neverbounce.com/register) and get your api keys [here](https://app.neverbounce.com/settings/api).

To initialize the wrapper use the following snippet, substituting in your `api key` and `api secret key`...

```
neverbounce = NeverBounce::API.new(API_KEY, API_SECRET_KEY)
```

You can now access the verify method from this class. To validate a single email use the following...

```
result = neverbounce.single.verify(EMAIL)
```

The `result` will contain a VerificationResult class instance. It provides several helper methods documented below...

```
result.getResultCode # Numeric result code; ex: 0, 1, 2, 3, 4
result.getResultTextCode # Textual result code; ex: valid, invalid, disposable, catchall, unknown
result.is(0) # Returns true if result is valid
result.is([0,3,4]) # Returns true if result is valid, catchall, or unknown
result.not(1) # Returns true if result is not invalid
result.not([1,2]) # Returns true if result is not invalid or disposable
```
