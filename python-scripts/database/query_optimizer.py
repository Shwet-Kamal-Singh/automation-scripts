import re
import sqlparse
from typing import List, Dict
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def analyze_query(query: str) -> Dict[str, any]:
    parsed = sqlparse.parse(query)[0]
    tables = [token.value for token in parsed.tokens if isinstance(token, sqlparse.sql.Identifier)]
    where_clause = next((token for token in parsed.tokens if isinstance(token, sqlparse.sql.Where)), None)
    joins = re.findall(r'\bJOIN\b', query, re.IGNORECASE)
    subqueries = len(re.findall(r'\(SELECT', query, re.IGNORECASE))
    
    return {
        "tables": tables,
        "has_where": bool(where_clause),
        "join_count": len(joins),
        "subquery_count": subqueries
    }

def suggest_optimizations(analysis: Dict[str, any]) -> List[str]:
    suggestions = []
    
    if not analysis["has_where"]:
        suggestions.append("Consider adding a WHERE clause to filter results")
    
    if analysis["join_count"] > 2:
        suggestions.append("Review join operations, consider denormalizing if appropriate")
    
    if analysis["subquery_count"] > 0:
        suggestions.append("Evaluate subqueries, consider using JOINs instead")
    
    if len(analysis["tables"]) > 3:
        suggestions.append("Review table usage, consider breaking down into smaller queries")
    
    return suggestions

def optimize_query(query: str) -> str:
    # Basic query optimizations
    optimized = query.upper()
    optimized = re.sub(r'SELECT \*', 'SELECT [specific_columns]', optimized)
    optimized = re.sub(r'LIKE \'\%(.+?)\%\'', r"= '\1'", optimized)
    optimized = re.sub(r'OR', 'UNION', optimized)
    
    return optimized

def main(query: str):
    logging.info("Original query:")
    logging.info(query)
    
    analysis = analyze_query(query)
    logging.info(f"Query analysis: {analysis}")
    
    suggestions = suggest_optimizations(analysis)
    if suggestions:
        logging.info("Optimization suggestions:")
        for suggestion in suggestions:
            logging.info(f"- {suggestion}")
    else:
        logging.info("No specific optimization suggestions.")
    
    optimized_query = optimize_query(query)
    logging.info("Optimized query:")
    logging.info(optimized_query)

if __name__ == "__main__":
    sample_query = """
    SELECT * FROM users u
    LEFT JOIN orders o ON u.id = o.user_id
    LEFT JOIN products p ON o.product_id = p.id
    WHERE u.name LIKE '%John%' OR u.email LIKE '%@example.com%'
    """
    main(sample_query)