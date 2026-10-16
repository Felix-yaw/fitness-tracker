/// Filter for the recent-activity list on the home screen.
enum ActivityFilter {
  all('All'),
  morning('Morning activities'),
  recovery('Recovery');

  const ActivityFilter(this.label);

  final String label;
}
