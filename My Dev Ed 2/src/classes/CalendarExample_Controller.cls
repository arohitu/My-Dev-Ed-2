public class CalendarExample_Controller {

    public Date today {get;set;}

    public Boolean includeMyEvents {get;set;}

    public list<calEvent> events {get;set;}

    

    //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly

    String dtFormat = 'yyyy-MM-dd HH:mm:ss';

    

    //constructor

    public CalendarExample_Controller() {

        //Default showing my events to on

        includeMyEvents = true;

    }

    

    public PageReference pageLoad() {
        today = System.today();
        events = new list<calEvent>();

        //Get Contact's Birthdays

        /*for(Contact cont : [select Id, Birthdate, FirstName, LastName from Contact where Birthdate != null]){

            //here we need to replace the birth year with the current year so that it will show up on this years calendar

            DateTime startDT = datetime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());

            calEvent bday = new calEvent();

            

            bday.title = cont.FirstName + ' ' + cont.LastName + '\'s Birthday!';

            bday.allDay = true;

            bday.startString = startDT.format(dtFormat);

            //Because this is an all day event that only spans one day, we can leave the send date null

            bday.endString = '';

            bday.url = '/' + cont.Id;

            bday.className = 'event-birthday';

            events.add(bday);

        }
        
        

        //Get Campaigns

        for(Campaign camp : [select Id, Name, StartDate, EndDate from Campaign where IsActive = true]){

            DateTime startDT = camp.StartDate;

            DateTime endDT = camp.EndDate;

            calEvent campEvent = new calEvent();

            

            campEvent.title = camp.Name;

            campEvent.allDay = true;

            campEvent.startString = startDT.format(dtFormat);

            campEvent.endString = endDT.format(dtFormat);

            campEvent.url = '/' + camp.Id;

            campEvent.className = 'event-campaign';

            events.add(campEvent);

        }
        */
        

        //Get my Events if we have selected the correct option

        if(includeMyEvents){

            for(Event evnt: [select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime, OwnerId, CreatedById from Event]){

                DateTime startDT = evnt.StartDateTime;

                DateTime endDT = evnt.EndDateTime;

                if(evnt.OwnerId == '00528000000L1CS') {
                calEvent myEvent = new calEvent();
                myEvent.title = evnt.Subject;
                myEvent.allDay = evnt.isAllDayEvent;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + evnt.Id;
                if(evnt.CreatedById == evnt.OwnerId) {
                    myEvent.className = 'event-janet';
                }
                else {
                    myEvent.className = 'event-janet-others';
                }
                events.add(myEvent);
                }
                else if(evnt.OwnerId == '00528000000L0rm') {
                calEvent myEvent = new calEvent();
                myEvent.title = evnt.Subject;
                myEvent.allDay = evnt.isAllDayEvent;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + evnt.Id;
                if(evnt.CreatedById == evnt.OwnerId) {
                    myEvent.className = 'event-rohit';
                }
                else {
                    myEvent.className = 'event-rohit-others';
                }
                events.add(myEvent);
                }

            }

        }

        return null;

    }

    

    public PageReference toggleMyEvents() {

        if(includeMyEvents){

            includeMyEvents = false;

        }

        else{

            includeMyEvents = true;

        }

        pageload();

        return null;

    }



    

    //Class to hold calendar event data

    public class calEvent{

        public String title {get;set;}

        public Boolean allDay {get;set;}

        public String startString {get;private set;}

        public String endString {get;private set;}

        public String url {get;set;}

        public String className {get;set;}

    }

}