<?php
require_once ("Heap.php");
require_once ("Stack.php");
require_once ("Queue.php");
class AdjNode {
	public $source;
	public $destination;
	public $cost;
	public $next;
	Function __construct($src, $dst, $cst = 1) {
		$this->source = $src;
		$this->destination = $dst;
		$this->cost = $cst;
		$this->next = NULL;
	}
	Function comp($node) {
		if ($node == NULL || $node->cost >= $this->cost) {
			return FALSE;
		} else {
			return TRUE;
		}
	}
}
class AdjList {
	public $head;
}

/*
 * $queue = new Heap ( NULL, TRUE );
 * $node = new AdjNode ( $source, $source, 0 );
 * $this->arr [$i] = new AdjList ();
 * $que = new Queue ();
 * $stk = new Stack ();
 *
 */
class Graph {
	public $count;
	public $arr;
	Function __construct($cnt) {
		$this->count = $cnt;
		$this->arr = array ();
		for($i = 0; ($i < $cnt); ++ $i) {
			$this->arr [$i] = new AdjList ();
			$this->arr [$i]->head = NULL;
		}
	}
	public Function AddEdge($source, $destination, $cost = 1) {
		$node = new AdjNode ( $source, $destination, $cost );
		$node->next = $this->arr [$source]->head;
		$this->arr [$source]->head = $node;
	}
	public Function AddBiEdge($source, $destination, $cost = 1) {
		$this->AddEdge ( $source, $destination, $cost );
		$this->AddEdge ( $destination, $source, $cost );
	}
	public Function Display() {
		$ad = NULL;
		for($i = 0; ($i < $this->count); ++ $i) {
			$ad = $this->arr [$i]->head;
			if ($ad != NULL) {
				echo ("Vertex " . $i . " is connected to : ");
				while ( ($ad != NULL) ) {
					echo (($ad->destination . " "));
					$ad = $ad->next;
				}
				echo ("<br/>");
			}
		}
	}
}
Function Dijkstra($gph, $source) {
	$previous = array ();
	$dist = array ();
	for($i = 0; ($i < $gph->count); ++ $i) {
		$previous [$i] = - 1;
		$dist [$i] = 999999;
	}
	$dist [$source] = 0;
	$previous [$source] = - 1;
	$queue = new Heap ( NULL, TRUE );
	$node = new AdjNode ( $source, $source, 0 );
	$queue->add ( $node );
	while ( ($queue->isEmpty () != TRUE) ) {
		$node = $queue->peek ();
		$queue->remove ();
		$adl = $gph->arr [$node->destination];
		$adn = $adl->head;
		while ( ($adn != NULL) ) {
			$alt = ($adn->cost + $dist [$adn->source]);
			if (($alt < $dist [$adn->destination])) {
				$dist [$adn->destination] = $alt;
				$previous [$adn->destination] = $adn->source;
				$node = new AdjNode ( $adn->source, $adn->destination, $alt );
				$queue->add ( $node );
			}
			$adn = $adn->next;
		}
	}
	$count = $gph->count;
	for($i = 0; ($i < $count); ++ $i) {
		if ($dist [$i] == 999999) {
			echo (" node id " . $i . " prev " . $previous [$i] . " distance : Unreachable" . "<br/>");
		} else {
			echo (" node id " . $i . " prev " . $previous [$i] . " distance : " . $dist [$i] . "<br/>");
		}
	}
}
Function Prims($gph) {
	$previous = array ();
	$dist = array ();
	$source = 1;
	for($i = 0; ($i < $gph->count); ++ $i) {
		$previous [$i] = - 1;
		$dist [$i] = 999999;
	}
	$dist [$source] = 0;
	$previous [$source] = - 1;
	$queue = new Heap ( NULL, TRUE );
	$node = new AdjNode ( $source, $source, 0 );
	$queue->add ( $node );
	while ( ($queue->isEmpty () != TRUE) ) {
		$node = $queue->peek ();
		$queue->remove ();
		$adl = $gph->arr [$node->destination];
		$adn = $adl->head;
		while ( ($adn != NULL) ) {
			$alt = $adn->cost;
			if (($alt < $dist [$adn->destination])) {
				$dist [$adn->destination] = $alt;
				$previous [$adn->destination] = $adn->source;
				$node = new AdjNode ( $adn->source, $adn->destination, $alt );
				$queue->add ( $node );
			}
			$adn = $adn->next;
		}
	}
	$count = $gph->count;
	for($i = 0; ($i < $count); ++ $i) {
		if (($dist [$i] == 999999)) {
			echo (" node id " . $i . " prev " . $previous [$i] . " distance : Unreachable"."<br/>");
		} else {
			echo (" node id " . $i . " prev " . $previous [$i] . " distance : " . $dist [$i]."<br/>");
		}
	}
}
Function TopologicalSortDFS($gph, $index, $visited, $stk) {
	$head = $gph->arr [$index]->head;
	while ( ($head != NULL) ) {
		if (($visited [$head->destination] == 0)) {
			$visited [$head->destination] = 1;
			TopologicalSortDFS ( $gph, $head->destination, $visited, $stk );
		}
		$head = $head->next;
	}
	$stk->push ( $index );
}
Function TopologicalSort($gph) {
	$stk = new Stack ();
	$count = $gph->count;
	$visited = array ();
	for($i = 0; ($i <= $count); ++ $i) {
		$visited [$i] = 0;
	}
	
	for($i = 0; ($i < $count); ++ $i) {
		if (($visited [$i] == 0)) {
			$visited [$i] = 1;
			TopologicalSortDFS ( $gph, $i, $visited, $stk );
		}
	}
	while ( ($stk->isEmpty () != TRUE) ) {
		echo ((" " . $stk->pop ()));
	}
}
Function PathExist($gph, $source, $destination) {
	$count = $gph->count;
	$visited = array ();
	for($i = 0; ($i < $count); ++ $i) {
		$visited [$i] = 0;
	}
	$visited [$source] = 1;
	DFSRec ( $gph, $source, $visited );
	return $visited [$destination];
}
Function DFSRec($gph, $index, $visited) {
	$head = $gph->arr [$index]->head;
	while ( ($head != NULL) ) {
		if (($visited [$head->destination] == 0)) {
			$visited [$head->destination] = 1;
			DFSRec ( $gph, $head->destination, $visited );
		}
		$head = $head->next;
	}
}
Function DFSStack($gph) {
	$count = $gph->count;
	$visited = array ();
	$curr = NULL;
	$stk = new Stack ();
	for($i = 0; ($i < $count); ++ $i) {
		$visited [$i] = 0;
	}
	$visited [0] = 1;
	$stk->push ( 0 );
	while ( ($stk->isEmpty () == FALSE) ) {
		$curr = $stk->pop ();
		$head = $gph->arr [$curr]->head;
		while ( ($head != NULL) ) {
			if (($visited [$head->destination] == 0)) {
				$visited [$head->destination] = 1;
				$stk->push ( $head->destination );
			}
			$head = $head->next;
		}
	}
}
Function DFS($gph) {
	$count = $gph->count;
	$visited = array ();
	// for ($i = 0; ($i$visited[$i];
	// }
	for($i = 0; ($i <= $count); ++ $i) {
		if ($visited [$i] == 0) {
			$visited [$i] = 1;
			DFSRec ( $gph, $i, $visited );
		}
	}
}
Function BFSQueue($gph, $index, $visited) {
	$curr = NULL;
	$que = new LinkedList ();
	$visited [$index] = 1;
	$que->add ( $index );
	while ( ($que->isEmpty () == FALSE) ) {
		$curr = $que->remove ();
		$head = $gph->arr [$curr]->head;
		while ( ($head != NULL) ) {
			if (($visited [$head->destination] == 0)) {
				$visited [$head->destination] = 1;
				$que->add ( $head->destination );
			}
			$head = $head->next;
		}
	}
}
Function BFS($gph) {
	$count = $gph->count;
	$visited = array ();
	for($i = 0; ($i <= $count); ++ $i) {
		$visited [$i] = 0;
	}
	
	for($i = 0; ($i < $count); ++ $i)
		if ($visited [$i] == 0) {
			$this->BFSQueue ( $gph, $i, $visited );
		}
}
Function isConnected($gph) {
	$count = $gph->count;
	$visited = array ();
	for($i = 0; ($i < $count); ++ $i) {
		$visited [$i] = 0;
	}
	$visited [0] = 1;
	DFSRec ( $gph, 0, $visited );
	for($i = 0; ($i < $count); ++ $i) {
		if (($visited [$i] == 0)) {
			return FALSE;
		}
	}
	return TRUE;
}
Function ShortestPath($gph, $source) {
	$curr = NULL;
	$count = $gph->count;
	$distance = array ();
	$path = array ();
	$que = new LinkedList ();
	for($i = 0; ($i < $count); ++ $i) {
		$distance [$i] = - 1;
	}
	$que->add ( $source );
	$distance [$source] = 0;
	while ( ($que->isEmpty () == FALSE) ) {
		$curr = $que->remove ();
		$head = $gph->arr [$curr]->head;
		while ( ($head != NULL) ) {
			if (($distance [$head->destination] == - 1)) {
				$distance [$head->destination] = ($distance [$curr] + 1);
				$path [$head->destination] = $curr;
				$que->add ( $head->destination );
			}
			$head = $head->next;
		}
	}
	for($i = 0; ($i < $count); ++ $i) {
		echo ($path [$i] . " to " . $i . " weight " . $distance [$i]);
	}
}
Function BellmanfordShortestPath($gph, $source) {
	$count = $gph->count;
	$distance = array ();
	$path = array ();
	for($i = 0; ($i < $count); ++ $i) {
		$distance [$i] = 999999;
	}
	$distance [$source] = 0;
	for($i = 0; ($i < ($count - 1)); ++ $i) {
		for($j = 0; ($j < $count); ++ $j) {
			$head = $gph->arr [$j]->head;
			while ( ($head != NULL) ) {
				$newDistance = ($distance [$j] + $head->cost);
				if ($distance [$head->destination] > $newDistance) {
					$distance [$head->destination] = $newDistance;
					$path [$head->destination] = $j;
				}
				$head = $head->next;
			}
		}
	}
	for($i = 0; ($i < $count); ++ $i) {
		echo ($path [$i] . " to " . $i . " weight " . $distance [$i]);
	}
}
Function main() {
	$gph = new Graph ( 9 );
	$gph->AddBiEdge ( 0, 2, 1 );
	$gph->AddBiEdge ( 1, 2, 5 );
	$gph->AddBiEdge ( 1, 3, 7 );
	$gph->AddBiEdge ( 1, 4, 9 );
	$gph->AddBiEdge ( 3, 2, 2 );
	$gph->AddBiEdge ( 3, 5, 4 );
	$gph->AddBiEdge ( 4, 5, 5 );
	$gph->AddBiEdge ( 4, 5, 3 );
	$gph->AddBiEdge ( 5, 7, 1 );
	$gph->AddBiEdge ( 5, 7, 7 );
	$gph->AddBiEdge ( 7, 8, 17 );
	Dijkstra ( $gph, 1 );
	Prims($gph);
}
Function main2() {
	$g = new Graph ( 6 );
	$g->AddEdge ( 5, 2 );
	$g->AddEdge ( 5, 0 );
	$g->AddEdge ( 4, 0 );
	$g->AddEdge ( 4, 1 );
	$g->AddEdge ( 2, 3 );
	$g->AddEdge ( 3, 1 );
	echo ("Following is the Topological Sort of the given Graph.<br/>");
	TopologicalSort ( $g );
}
main ();
main2 ();
?>