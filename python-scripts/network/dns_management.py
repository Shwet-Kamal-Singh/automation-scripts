import dns.resolver
import dns.zone
from dns import reversename, query

def lookup_dns(domain, record_type='A'):
    """
    Perform a DNS lookup for the specified domain and record type.
    """
    try:
        answers = dns.resolver.resolve(domain, record_type)
        return [str(rdata) for rdata in answers]
    except dns.resolver.NXDOMAIN:
        return f"Domain {domain} does not exist."
    except dns.resolver.NoAnswer:
        return f"No {record_type} record found for {domain}."
    except Exception as e:
        return f"An error occurred: {str(e)}"

def reverse_dns_lookup(ip_address):
    """
    Perform a reverse DNS lookup for the given IP address.
    """
    try:
        domain = reversename.from_address(ip_address)
        return str(dns.resolver.resolve(domain, "PTR")[0])
    except Exception as e:
        return f"An error occurred: {str(e)}"

def transfer_zone(domain, nameserver):
    """
    Attempt a zone transfer for the specified domain from the given nameserver.
    """
    try:
        z = dns.zone.from_xfr(query.xfr(nameserver, domain))
        return [f"{name} {z[name].to_text(name)}" for name in z.nodes.keys()]
    except Exception as e:
        return f"Zone transfer failed: {str(e)}"

def main():
    # Example usage
    print(lookup_dns("example.com", "MX"))
    print(reverse_dns_lookup("8.8.8.8"))
    print(transfer_zone("example.com", "ns1.example.com"))

if __name__ == "__main__":
    main()