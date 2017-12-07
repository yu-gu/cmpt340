package Problems;

import java.io.Serializable;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Inbox;
import akka.actor.Props;
import akka.actor.UntypedActor;
import akka.pattern.Patterns;
import akka.util.Timeout;
import scala.concurrent.Await;
import scala.concurrent.Future;
import scala.concurrent.duration.Duration;
import java.util.Scanner;


public class P1Fibonacci{
		
	/**
	 * actor to accept FibRequestMessage and
	 * returns the fib number at that index.
	 *
	 */
	public static class FibActor extends UntypedActor {
		
		@Override
		public void onReceive(Object request) throws Throwable {
	
			if(request instanceof requestMessage){
				int requestedFibNum = ((requestMessage)request).requestedFibNum;
				long maxTime = ((requestMessage)request).maxTime;
				//calculate the current fib number
				GetMessage result = concurrentFib(requestedFibNum, maxTime);
				getSender().tell(result, getSelf());
			}else{
				unhandled(request);
			}			
		}
		
		/*
		 * calculates the nth number using child actors 
		 */
		private GetMessage concurrentFib(int fibNum, long maxTime){
			//regular base cases
			if(fibNum == 0){
				return new GetMessage(0);
			}
			else if (fibNum < 3){
				return new GetMessage(1);
			}
			else{
				//create 2 child actors
				final ActorRef firstChild = getContext().actorOf(Props.create(FibActor.class),(fibNum+"-child1"));
				final ActorRef secondChild = getContext().actorOf(Props.create(FibActor.class),(fibNum+"-child2"));
				
				Timeout t = new Timeout(Duration.create(maxTime, TimeUnit.SECONDS));
	
				//Create 2 subproblems
				Future<Object> object1 = Patterns.ask(firstChild, new requestMessage(fibNum-1, maxTime), t);
				Future<Object> object2 = Patterns.ask(secondChild, new requestMessage(fibNum-2, maxTime), t);
				
				GetMessage res1 = null;
				GetMessage res2 = null;
				
				//waits for the allotted time to get the results, otherwise it errors
				try {
					res1 = (GetMessage)Await.result(object1, t.duration());
					res2 = (GetMessage)Await.result(object2, t.duration());
				} catch (Exception e) {
					System.out.println("Timed out message");
				}
				return new GetMessage(res1.result +  res2.result);
			}
		}	
	}

	/**
	 * Message used to signal a FibActor to calculate 
	 * the fibonacci number with proper index 
	 */
	public static class requestMessage implements Serializable{
		private static final long serialVersionUID = 1L;
		public int requestedFibNum;
		public long maxTime;
		
		//sets the requestedFibNum
		public requestMessage(int fibnum, long maxTime)
		{
			this.requestedFibNum = fibnum;
			this.maxTime = maxTime;
		}
	}
	
	/**
	 * To return the message from result
	 */
	public static class GetMessage implements Serializable{
		private static final long serialVersionUID = 1L;
		public long result;
		public GetMessage(long message){
			this.result = message;
		}
	}
	

	public static void main(String[] args) {
		int Time_duration = 2;
		
		System.out.println("Please give the Fibonacci index:");
		Scanner in = new Scanner(System.in);
		int fibIndex = in.nextInt();	
		in.close();
		
		// Create an actor system
		final ActorSystem fibonacciSystem = ActorSystem.create("Fibonacci");	

		// Create an actor
		final ActorRef fibonacciActor = fibonacciSystem.actorOf(Props.create(FibActor.class), "fibActor");

		// Create an inbox 
		final Inbox client = Inbox.create(fibonacciSystem);
		
		
		// Ask the actor for a number message
		client.send(fibonacciActor, new requestMessage(fibIndex, Time_duration));
		
		GetMessage reply = null;
		try {
			reply = (GetMessage) client.receive(Duration.create(Time_duration, TimeUnit.SECONDS));
		}
		catch(TimeoutException e){
			System.out.println("timeout waiting for reply");
		}
		
		// Print the reply received
		System.out.println("Your fibonacci index is: " + fibIndex);
		System.out.println("Your fibonacci result is: " + reply.result);	
		
		//close down the actor system
		fibonacciSystem.terminate();
	}
}
