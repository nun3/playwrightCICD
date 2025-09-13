#!/bin/bash

echo "🛑 Parando ambiente Jenkins..."

# Parar containers
docker-compose down

echo "✅ Ambiente Jenkins parado!"
echo ""
echo "💡 Para remover completamente (incluindo dados):"
echo "   docker-compose down -v"
echo "   docker system prune -f"
