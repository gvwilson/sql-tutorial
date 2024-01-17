(
    for table in staff experiment performed plate invalidated
    do
	echo ".mode list"
	echo ".headers off"
	echo "select '';"
	echo "select '**${table}**';"
	echo "select '';"
	echo ".mode markdown"
	echo ".headers on"
	echo "pragma table_info('${table}');"
    done
) | sqlite3 assays.db | tail -n +2
