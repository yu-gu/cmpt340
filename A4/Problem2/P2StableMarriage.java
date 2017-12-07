package Problems;
import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Inbox;
import akka.actor.Props;
import akka.actor.UntypedActor;
import scala.concurrent.duration.Duration;
import java.io.Serializable;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;


public class P2StableMarriage {
	
		public static class ManActor extends UntypedActor{
		
		List<ActorRef> prefer;
		List<ActorRef> preflist;
		ActorRef currentMatch;
		
		
		protected void setup(ActorRef[] possibleSpouses){
			this.prefer = new ArrayList<ActorRef>();
			this.preflist = new ArrayList<ActorRef>();
			this.prefer.addAll(Arrays.asList(possibleSpouses));
			Collections.shuffle(this.prefer);
			this.preflist.addAll(this.prefer);
		}
		
		public void onReceive(Object message) throws Throwable {
			if(message instanceof Set.Initialize){
				this.setup((ActorRef[])((Set.Initialize)message).wife );
				getSender().tell(new Set.Initialize(null), getSelf());
			}else 
				if (message instanceof Set.start){
				sendProposal();
			}else if (message instanceof Set.accept){
					this.currentMatch = getSender();
			}else if (message instanceof Set.checkMatch){
				Boolean reply = new Boolean((this.currentMatch != null));
				getSender().tell(reply, getSelf());
			}else if (message instanceof Set.reject){
				sendProposal();
			}
			else if (message instanceof Set.checkPref){
				getSender().tell(new Set.matchPrefs(this.currentMatch, this.preflist), getSelf());
			}else{
				unhandled(message);
			}
		}
		
		public void sendProposal(){
				ActorRef currentPref = prefer.get(0);
				currentPref.tell(new Set.propose(), getSelf());
				prefer.remove(0);
		}
	}
	

	public static class WomanActor extends UntypedActor{
		
		List<ActorRef> prefer;
		List<ActorRef> preflist;
		ActorRef currentMatch;
		
		
		protected void setup(ActorRef[] possibleSpouses){
			this.prefer = new ArrayList<ActorRef>();
			this.preflist = new ArrayList<ActorRef>();
			this.prefer.addAll(Arrays.asList(possibleSpouses));
			Collections.shuffle(this.prefer);
			this.preflist.addAll(this.prefer);
			this.currentMatch = null;
		}
		
		
		public void onReceive(Object message) throws Throwable {
			if(message instanceof Set.Initialize){
				this.setup((ActorRef[])((Set.Initialize)message).wife);
				getSender().tell(new Set.Initialize(null), getSelf());
			} else if (message instanceof Set.propose){
				ActorRef suitor = getSender();
				if(currentMatch == null){
					acceptProposal(suitor);
				}
				else{
					if(isCurrentPerferredOver(suitor)){
						rejectProposal(suitor);
					}else{
						rejectProposal(this.currentMatch);
						acceptProposal(suitor);
					}
				}	
			}else if (message instanceof Set.checkPref){
				getSender().tell(new Set.matchPrefs(this.currentMatch, this.preflist), getSelf());
			}
			else{
				unhandled(message);
			}
		}

		
		public boolean isCurrentPerferredOver(ActorRef male){
			int currentMatchIndex = prefer.indexOf(this.currentMatch);
			int newIndex = prefer.indexOf(male);
			if(currentMatchIndex < newIndex){
				return true;
			}else{
				return false;
			}
		}
		
		
		public void acceptProposal(ActorRef male){
			this.currentMatch = male;
			male.tell(new Set.accept(), getSelf());
		}
		
		public void rejectProposal(ActorRef male){
			male.tell(new Set.reject(), getSelf());
		}
	}
	
	/**
	 * Set class to responce with corresponding message
	 * @author yugu
	 *
	 */
	public static class Set implements Serializable {
		private static final long serialVersionUID = 1L;
		public static class accept {
			
		}
		public static class reject {
			
		}
		public static class propose {
			
		}
		public static class start {
			
		}
		
		public static class checkMatch {
			
		}
		public static class checkPref{
			
		}
		public static class matchPrefs{
			ActorRef match;
			List<ActorRef> prefs;
			public matchPrefs(ActorRef m, List<ActorRef> p ){
				this.match = m;
				this.prefs = p; 
			}
		}
		public static class Initialize{
			ActorRef[] wife;
			public Initialize(ActorRef[] list){
				this.wife = list;
			}
		}
		/**
		 * Create pairs for this marriage
		 */
		public static class General{
			ActorRef man;
			ActorRef woman;
			List<ActorRef> manPrefs;
			List<ActorRef> womanPrefs;
			public General(ActorRef m, ActorRef w,List<ActorRef> mp, List<ActorRef> wp){
				this.man = m;
				this.woman = w;
				this.manPrefs = mp;
				this.womanPrefs = wp;
			}

			public String toString(){
				return man.path().name()+" - "+ woman.path().name() 
						+ "\n"+prettyPrintList(man.path().name(),this.manPrefs)
						+ "\n"+prettyPrintList(woman.path().name(), this.womanPrefs);
			}
			
			private String prettyPrintList(String name, List<ActorRef> l){
				String returnMess = name+" preferenceList: ";
				for (int i = 0; i < l.size(); i++)
				{
					returnMess = returnMess+l.get(i).path().name()+", ";
				}
				return returnMess;
			}
			
			public boolean equals(Object other){
			    if (other == null) return false;
			    if (other == this) return true;
			    if (!(other instanceof General))return false;
			    General x = (General)other;
				return ((this.man.path().name() == x.man.path().name()) && (this.woman.path().name() == x.woman.path().name()));
			}
		}	
	}

	public static void main(String[] args) {
		System.out.println("Please enter number of couple:");
		@SuppressWarnings("resource")
		Scanner in = new Scanner(System.in);
		int couple = in.nextInt();
		int timeout = 6;
		final ActorSystem sys = ActorSystem.create("StableMarriageProblem");
		final Inbox client = Inbox.create(sys);
		ActorRef[] men = new ActorRef[couple];
		ActorRef[] women = new ActorRef[couple];
		List<Set.General> menMatches = new ArrayList<Set.General>();
		List<Set.General> womenMatches = new ArrayList<Set.General>();
		
		for(int i = 0; i < couple; i++){
			men[i] = sys.actorOf(Props.create(ManActor.class), "M"+i);
			women[i] = sys.actorOf(Props.create(WomanActor.class), "W"+i);
		}
		
		for(int i = 0; i < couple; i++){
			client.send(men[i], new Set.Initialize(women.clone()));
			try {
				client.receive(Duration.create(timeout, TimeUnit.SECONDS));
			}
			catch(TimeoutException e){
				System.out.println("timeout waiting for reply from Man:"+men[i].path().name());
			}
			client.send(women[i], new Set.Initialize(men.clone())); 
			try {
				client.receive(Duration.create(timeout, TimeUnit.SECONDS));
			}
			catch(TimeoutException e){
				System.out.println("timeout waiting for reply from woman: "+women[i]);
			}
		}
		
	
			
		for(int i = 0; i < couple; i++){
			men[i].tell(new Set.start(), ActorRef.noSender());
		}

		for(int i = 0; i < couple; i++){
			client.send(men[i], new Set.checkMatch());
			Boolean reply = null;
			try {
				reply = (Boolean) client.receive(Duration.create(timeout, TimeUnit.SECONDS));
				if(reply == false){
				}
			}
			catch(TimeoutException e){
				System.out.println("timeout waiting for reply from"+men[i]);
			}
			client.send(women[i], new Set.checkPref()); 
			Set.matchPrefs reply1 = null;
			try {
				reply1 = (Set.matchPrefs) client.receive(Duration.create(timeout, TimeUnit.SECONDS));
				womenMatches.add(new Set.General(reply1.match, women[i], null, reply1.prefs));//husbands pref List is currently null cause we dont have that information yet
			}
			catch(TimeoutException e){
				System.out.println("timeout waiting for reply from woman: "+women[i]);
			}
		}

		
		
		for(int i = 0; i < couple; i++){
			client.send(men[i], new Set.checkPref()); 
			Set.matchPrefs reply = null;
			try {
				reply = (Set.matchPrefs) client.receive(Duration.create(timeout, TimeUnit.SECONDS));
				menMatches.add(new Set.General(men[i], reply.match, reply.prefs, null));//wifes pref List is currently null cause we dont have that information yet
			}
			catch(TimeoutException e){
				System.out.println("timeout waiting for reply from man: "+men[i]);
			}
		}
		
		List<Set.General> masterMatches = new ArrayList<Set.General>();
		for(int i = 0; i < couple; i++){
			Set.General currentMatch = menMatches.get(i);
			int womenIndex = womenMatches.indexOf(currentMatch); 
			masterMatches.add(new Set.General(currentMatch.man, currentMatch.woman, currentMatch.manPrefs, womenMatches.get(womenIndex).womanPrefs));
			System.out.println(masterMatches.get(i));
		}
		
		//shut down the system
		sys.terminate();
	}
}