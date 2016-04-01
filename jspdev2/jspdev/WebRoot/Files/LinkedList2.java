
public class LinkedList2 {
private static class Node{
	int val;
	Node next;
	Node prev;
	public Node(int v,Node n,Node p){
		val=v;
		next=n;
		prev=p;
	}
}
private Node head;
public LinkedList2(){
	head=null;
}
public void addFirst(int v){
	head=new Node(v,head,null);
}
public void addLast(int v){
	Node ptr=head;
	if(ptr==null)
		return;
	while(ptr.next!=null){
		ptr=ptr.next;
	}
	ptr.next=new Node(v,null,ptr);
}
public void insertMiddle(int tar,int v){
	Node temp;
	for(Node p=head;p!=null;p=p.next){
		if(p.val==tar){
			temp=p.prev;
			p.prev=new Node(v,p,p.prev);
			if(temp!=null)
				temp.next=p.prev;
		}
	}
}
}








