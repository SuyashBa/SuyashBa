public class ScheduledMarkForDelete implements Schedulable {
    public void execute(SchedulableContext ctx) {
      DeleteMarked markForDelete = new DeleteMarked();
      database.executeBatch(markForDelete);
    }
}