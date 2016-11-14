# Convert currency using the Fixer.io API

using Requests
import Requests: get

currency = Dict("AUD" => "Australian Dollar",
                "BGN" => "Bulgarian Lev",
                "BRL" => "Brazilian Real",
                "CAD" => "Canadian Dollar",
                "CHF" => "Swiss Franc",
                "CNY" => "Yuan Renminbi",
                "CZK" => "Czech Koruna",
                "DKK" => "Danish Krone",
                "GBP" => "Pound Sterling",
                "HKD" => "Hong Kong Dollar",
                "HRK" => "Croatian Kuna",
                "HUF" => "Hungarian Forint",
                "IDR" => "Indonesian Rupiah",
                "ILS" => "Israeli New Shekel",
                "INR" => "Indian Rupee",
                "JPY" => "Japanese Yen",
                "KRW" => "Korean Won",
                "MXN" => "Mexican Nuevo Peso",
                "MYR" => "Malaysian Ringgit",
                "NOK" => "Norwegian Krone",
                "NZD" => "New Zealand Dollar",
                "PHP" => "Philippine Peso",
                "PLN" => "Polish Zloty",
                "RON" => "Romanian New Leu",
                "RUB" => "Russian Ruble",
                "SEK" => "Swedish Krona",
                "SGD" => "Singapore Dollar",
                "THB" => "Thai Baht",
                "TRY" => "Turkish Lira",
                "ZAR" => "South African Rand",
                "EUR" => "Euro",
                "USD" => "US Dollar")

function verify(base::String, target::String)
    if haskey(currency, uppercase(base)) == false
        println("Base currency $base is not supported")
    end
    if haskey(currency, uppercase(target)) == false
        println("Target currency $target is not supported")
    end
end

function getRate(base::String, target::String)
    url = "https://api.fixer.io/latest?base=$base&symbols=$target"
    response = get(url)
    return Requests.json(response)["rates"][target]
end

function amount()
    println("Enter the amount you wish to convert (\$): ")
    ans = chomp(readline())
    ans = parse(Float64, ans)
    return ans
end

function base()
    print("\n")
    println("Choose a base currency: ")
    ans = chomp(readline())
    return ans
end

function target()
    print("\n")
    println("Choose a target currency: ")
    ans = chomp(readline())
    print("\n")
    return ans
end

function supported()
    println("The following currency are supported: ")
    for code in currency
        print("$(code[1])")
        print("\t")
    end
    println("\n")
end

supported()
amount_insert = amount()
base_insert = uppercase(base())
target_insert = uppercase(target())
verify_insert = verify(base_insert,target_insert)
getRate_insert = getRate(base_insert,target_insert)

println("$amount_insert $base_insert is $(amount_insert*getRate_insert) $target_insert")