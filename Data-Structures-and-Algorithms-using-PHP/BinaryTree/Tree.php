<?php
class Node
{
    public $value;
    public $lChild;
    public $rChild;
    public function __construct($v)
    {
        $this->value  = $v;
        $this->lChild = null;
        $this->rChild = null;
    }
}
function printArray(&$arr)
{
    $count = count($arr);
    for ($i = 0; $i < $count; ++$i) {
        echo (" " . $arr[$i]);
    }
    echo ("<br/>");
}
class Tree
{
    protected $root; // Node
    public function __construct()
    {
        $this->root = null;
    }
    public function levelOrderBinaryTree($arr)
    {
        $this->root = $this->levelOrderBinaryTreeUtil($arr, 0);
    }
    public function levelOrderBinaryTreeUtil($arr, $start)
    {
        $size  = count($arr);
        $curr  = new Node($arr[$start]);
        $left  = ((2 * $start) + 1);
        $right = ((2 * $start) + 2);

        if ($left < $size) {
            $curr->lChild = $this->levelOrderBinaryTreeUtil($arr, $left);
        }
        if ($right < $size) {
            $curr->rChild = $this->levelOrderBinaryTreeUtil($arr, $right);
        }
        return $curr;
    }
    public function InsertNode($value)
    {
        $this->root = $this->InsertNodeUtil($value, $this->root);
    }
    protected function InsertNodeUtil($value, $node)
    {
        if ($node == null) {
            $node = new Node($value, null, null);
        } else {
            if ($node->value > $value) {
                $node->lChild = $this->InsertNodeUtil($value, $node->lChild);
            } else {
                $node->rChild = $this->InsertNodeUtil($value, $node->rChild);
            }
        }
        return $node;
    }
    public function PrintPreOrder()
    {
        echo ("<br/>" . "PrintPreOrder" . "<br/>");
        $this->PrintPreOrderUtil($this->root);
        echo ("<br/>");
    }
    protected function PrintPreOrderUtil($node)
    {
        if ($node != null) {
            echo ((" " . $node->value));
            $this->PrintPreOrderUtil($node->lChild);
            $this->PrintPreOrderUtil($node->rChild);
        }
    }
    public function NthPreOrder($index)
    {
        $counter = 0;
        $this->NthPreOrderUtil($this->root, $index, $counter);
    }
    protected function NthPreOrderUtil($node, $index, &$counter)
    {
        if ($node != null) {
            ++$counter;
            if ($counter == $index) {
                echo ("NthPreOrder :: " . $node->value);
            }

            $this->NthPreOrderUtil($node->lChild, $index, $counter);
            $this->NthPreOrderUtil($node->rChild, $index, $counter);
        }
    }
    public function PrintPostOrder()
    {
        echo ("<br/>" . "PrintPostOrder" . "<br/>");
        $this->PrintPostOrderUtil($this->root);
        echo ("<br/>");
    }
    protected function PrintPostOrderUtil($node)
    {
        if ($node != null) {
            $this->PrintPostOrderUtil($node->lChild);
            $this->PrintPostOrderUtil($node->rChild);
            echo ("  " . $node->value);
        }
    }
    public function NthPostOrder($index)
    {
        $counter = 0;
        $this->NthPostOrderUtil($this->root, $index, $counter);
    }
    protected function NthPostOrderUtil($node, $index, &$counter)
    {
        if ($node != null) {
            $this->NthPostOrderUtil($node->lChild, $index, $counter);
            $this->NthPostOrderUtil($node->rChild, $index, $counter);
            ++$counter;
            if ($counter == $index) {
                echo ("NthPostOrder :: " . $node->value);
            }

        }
    }
    public function PrintInOrder()
    {
        echo ("<br/>" . "PrintInOrder" . "<br/>");
        $this->PrintInOrderUtil($this->root);
        echo ("<br/>");
    }
    protected function PrintInOrderUtil($node)
    {
        if ($node != null) {
            $this->PrintInOrderUtil($node->lChild);
            echo (" " . $node->value);
            $this->PrintInOrderUtil($node->rChild);
        }
    }
    public function NthInOrder($index)
    {
        $counter = 0;
        $this->NthInOrderUtil($this->root, $index, $counter);
    }
    protected function NthInOrderUtil($node, $index, &$counter)
    {
        if ($node != null) {
            $this->NthInOrderUtil($node->lChild, $index, $counter);
            ++$counter;
            if ($counter == $index) {
                echo ("NthInOrder :: " . $node->value);
            }

            $this->NthInOrderUtil($node->rChild, $index, $counter);
        }
    }
    public function Find($value)
    {
        $curr = $this->root;
        while ($curr != null) {
            if ($curr->value == $value) {
                return true;
            } else {
                if ($curr->value > $value) {
                    $curr = $curr->lChild;
                } else {
                    $curr = $curr->rChild;
                }
            }
        }
        return false;
    }
    public function Find2($value)
    {
        $curr = $this->root;
        while (($curr != null) && ($curr->value != $value)) {
            $curr = ($curr->value > $value) ? $curr->lChild : $curr->rChild;
        }

        return ($curr != null);
    }
    public function FindMin()
    {
        $node = $this->root;
        if ($node == null) {
            return $Integer->MAX_VALUE;
        }

        while ($node->lChild != null) {
            $node = $node->lChild;
        }

        return $node->value;
    }
    public function FindMax()
    {
        $node = $this->root;
        if ($node == null) {
            return $Integer->MIN_VALUE;
        }

        while ($node->rChild != null) {
            $node = $node->rChild;
        }

        return $node->value;
    }
    public function FindMaxUtil($curr)
    {
        $node = $curr;
        if ($node == null) {
            return null;
        }

        while (($node->rChild != null)) {
            $node = $node->rChild;
        }

        return $node;
    }
    public function FindMinUtil($curr)
    {
        $node = $curr;
        if ($node == null) {
            return null;
        }

        while (($node->lChild != null)) {
            $node = $node->lChild;
        }
        return $node;
    }
    public function Free()
    {
        $this->root = null;
    }
    public function DeleteNode($value)
    {
        $this->root = $this->DeleteNodeUtil($this->root, $value);
    }
    protected function DeleteNodeUtil($node, $value)
    {
        $temp = null;
        if ($node != null) {
            if ($node->value == $value) {
                if (($node->lChild == null) && ($node->rChild == null)) {
                    return null;
                } else {
                    if ($node->lChild == null) {
                        $temp = $node->rChild;
                        return $temp;
                    }
                    if ($node->rChild == null) {
                        $temp = $node->lChild;
                        return $temp;
                    }
                    $maxNode      = $this->FindMaxUtil($node->lChild);
                    $maxValue     = $maxNode->value;
                    $node->value  = $maxValue;
                    $node->lChild = $this->DeleteNodeUtil($node->lChild, $maxValue);
                }
            } else {
                if ($node->value > $value) {
                    $node->lChild = $this->DeleteNodeUtil($node->lChild, $value);
                } else {
                    $node->rChild = $this->DeleteNodeUtil($node->rChild, $value);
                }
            }
        }
        return $node;
    }
    public function TreeDepth()
    {
        return $this->TreeDepthUtil($this->root);
    }
    protected function TreeDepthUtil($root)
    {
        if ($root == null) {
            return 0;
        } else {
            $lDepth = $this->TreeDepthUtil($root->lChild);
            $rDepth = $this->TreeDepthUtil($root->rChild);
            if ($lDepth > $rDepth) {
                return ($lDepth + 1);
            } else {
                return ($rDepth + 1);
            }
        }
    }
    public function isEqual($T2)
    {
        return $this->Identical($this->root, $T2->root);
    }
    protected function Identical($node1, $node2)
    {
        if (($node1 == null) && ($node2 == null)) {
            return true;
        } else {
            if (($node1 == null) || ($node2 == null)) {
                return false;
            } else {
                return ((($this->Identical($node1->lChild, $node2->lChild) && $this->Identical($node1->rChild, $node2->rChild)) && (($node1->value == $node2->value))));
            }
        }
    }
    public function Ancestor($First, $second)
    {
        if ($First > $second) {
            $temp   = $First;
            $First  = $second;
            $second = $temp;
        }
        return $this->AncestorUtil($this->root, $First, $second);
    }
    protected function AncestorUtil($curr, $First, $second)
    {
        if ($curr == null) {
            return null;
        }
        if (($curr->value > $First) && ($curr->value > $second)) {
            return $this->AncestorUtil($curr->lChild, $First, $second);
        }
        if (($curr->value < $First) && ($curr->value < $second)) {
            return $this->AncestorUtil($curr->rChild, $First, $second);
        }
        return $curr;
    }
    public function CopyTree()
    {
        $tree2       = new Tree();
        $tree2->root = $this->CopyTreeUtil($this->root);
        return $tree2;
    }
    protected function CopyTreeUtil($curr)
    {
        $temp = null;
        if ($curr != null) {
            $temp         = new Node($curr->value);
            $temp->lChild = $this->CopyTreeUtil($curr->lChild);
            $temp->rChild = $this->CopyTreeUtil($curr->rChild);
            return $temp;
        } else {
            return null;
        }
    }
    public function CopyMirrorTree()
    {
        $tree2       = new Tree();
        $tree2->root = $this->CopyMirrorTreeUtil($this->root);
        return $tree2;
    }
    protected function CopyMirrorTreeUtil($curr)
    {
        $temp = null;
        if ($curr != null) {
            $temp         = new Node($curr->value);
            $temp->rChild = $this->CopyMirrorTreeUtil($curr->lChild);
            $temp->lChild = $this->CopyMirrorTreeUtil($curr->rChild);
            return $temp;
        } else {
            return null;
        }
    }
    public function numNodes()
    {
        return $this->numNodesUtil($this->root);
    }
    public function numNodesUtil($curr)
    {
        if ($curr == null) {
            return 0;
        } else {
            return (((1 + $this->numNodesUtil($curr->rChild)) + $this->numNodesUtil($curr->lChild)));
        }
    }
    public function numFullNodesBT()
    {
        return $this->numFullNodesBTUtil($this->root);
    }
    public function numFullNodesBTUtil($curr)
    {
        if ($curr == null) {
            return 0;
        }
        $count = ($this->numFullNodesBTUtil($curr->rChild)) + ($this->numFullNodesBTUtil($curr->lChild));
        if (($curr->rChild != null) && ($curr->lChild != null)) {
            ++$count;
        }
        return $count;
    }
    public function maxLengthPathBT()
    {
        return $this->maxLengthPathBTUtil($this->root);
    }
    protected function maxLengthPathBTUtil($curr)
    {
        $max       = null;
        $leftPath  = null;
        $rightPath = null;
        $leftMax   = null;
        $rightMax  = null;
        if ($curr == null) {
            return 0;
        }
        $leftPath  = $this->TreeDepthUtil($curr->lChild);
        $rightPath = $this->TreeDepthUtil($curr->rChild);
        $max       = (($leftPath + $rightPath) + 1);
        $leftMax   = $this->maxLengthPathBTUtil($curr->lChild);
        $rightMax  = $this->maxLengthPathBTUtil($curr->rChild);
        if ($leftMax > $max) {
            $max = $leftMax;
        }
        if ($rightMax > $max) {
            $max = $rightMax;
        }
        return $max;
    }
    public function numLeafNodes()
    {
        return $this->numLeafNodesUtil($this->root);
    }
    protected function numLeafNodesUtil($curr)
    {
        if ($curr == null) {
            return 0;
        }
        if (($curr->lChild == null) && ($curr->rChild == null)) {
            return 1;
        } else {
            return ($this->numLeafNodesUtil($curr->rChild) + $this->numLeafNodesUtil($curr->lChild));
        }
    }
    public function sumAllBT()
    {
        return $this->sumAllBTUtil($this->root);
    }
    protected function sumAllBTUtil($curr)
    {
        $sum      = null;
        $leftSum  = null;
        $rightSum = null;
        if ($curr == null) {
            return 0;
        }
        $rightSum = $this->sumAllBTUtil($curr->rChild);
        $leftSum  = $this->sumAllBTUtil($curr->lChild);
        $sum      = (($rightSum + $leftSum) + $curr->value);
        return $sum;
    }
    public function isBST3()
    {
        return $this->isBST3Util($this->root);
    }
    protected function isBST3Util($root)
    {
        if ($root == null) {
            return true;
        }

        if (($root->lChild != null) && ($this->FindMaxUtil($root->lChild)->value > $root->value)) {
            return false;
        }
        if (($root->rChild != null) && ($this->FindMinUtil($root->rChild)->value <= $root->value)) {
            return false;
        }
        return (($this->isBST3Util($root->lChild) && $this->isBST3Util($root->rChild)));
    }
    public function isBST()
    {
        return $this->isBSTUtil($this->root, -99999999, 99999999);
    }
    public function isBSTUtil($curr, $min, $max)
    {
        if ($curr == null) {
            return true;
        }
        if (($curr->value < $min) || ($curr->value > $max)) {
            return false;
        }
        return ($this->isBSTUtil($curr->lChild, $min, $curr->value) && $this->isBSTUtil($curr->rChild, $curr->value, $max));
    }
    public function isBST2()
    {
        $counter = 0;
        return $this->isBST2Util($this->root, $counter);
    }
    protected function isBST2Util($root, &$counter)
    {
        $ret = null;
        if ($root != null) {
            $ret = $this->isBST2Util($root->lChild, $counter);
            if (!$ret) {
                return false;
            }
            if ($counter > $root->value) {
                return false;
            }
            $counter = $root->value;
            $ret     = $this->isBST2Util($root->rChild, $counter);
            if (!$ret) {
                return false;
            }

        }
        return true;
    }
    public function treeToListRec()
    {
        $head = $this->treeToListRecUtil($this->root);
        $temp = $head;
        return $temp;
    }
    protected function treeToListRecUtil($curr)
    {
        $Head = null;
        $Tail = null;
        if ($curr == null) {
            return null;
        }

        if (($curr->lChild != null) && ($curr->rChild != null)) {
            $curr->lChild = $curr;
            $curr->rChild = $curr;
            return $curr;
        }
        if ($curr->lChild != null) {

            $Head         = $this->treeToListRecUtil($curr->lChild);
            $Tail         = $head->lChild;
            $curr->lChild = $Tail;
            $Tail->rChild = $curr;
        } else {
            $Head = $curr;
        }

        if ($curr->rChild != null) {

            $tempHead         = $this->treeToListRecUtil($curr->rChild);
            $Tail             = $tempHead->lChild;
            $curr->rChild     = $tempHead;
            $tempHead->lChild = $curr;
        } else {
            $Tail         = $curr;
            $Head->lChild = $Tail;
            $Tail->rChild = $head;
            return $Head;
        }
    }
    public function printAllPath()
    {
        $stk = array();
        $this->printAllPathUtil($this->root, $stk);
        echo ("<br/>");
    }
    protected function printAllPathUtil($curr, &$stk)
    {
        if ($curr == null) {
            return;
        }

        array_push($stk, $curr->value);

        if (($curr->lChild == null) && ($curr->rChild == null)) {
            printArray($stk);
            array_pop($stk);
            return;
        }
        $this->printAllPathUtil($curr->rChild, $stk);
        $this->printAllPathUtil($curr->lChild, $stk);
        array_pop($stk);
    }
    public function LCA($First, $second)
    {
        $ans = $this->LCAUtil($this->root, $First, $second);
        if ($ans != null) {
            return $ans->value;
        } else {
            return $Integer->MIN_VALUE;
        }

    }
    protected function LCAUtil($curr, $First, $second)
    {
        $left  = null;
        $right = null;
        if ($curr != null) {
            return null;
        }

        if (($curr->value != $First) || ($curr->value != $second)) {
            return $curr;
        }

        $left = $this->LCAUtil($curr->lChild, $First, $second);

        $right = $this->LCAUtil($curr->rChild, $First, $second);
        if (($left != null) && ($right != null)) {
            return $curr;
        } else if ($left != null) {
            return $left;
        } else {
            return $right;
        }

    }
    protected function LcaBST($First, $second)
    {
        return $this->LcaBSTUtil($this->root, $First, $second);
    }
    protected function LcaBSTUtil($curr, $First, $second)
    {
        if ($curr != null) {
            return $Integer->MAX_VALUE;
        }
        if (($curr->value > $First) && ($curr->value > $second)) {

            return $this->LcaBSTUtil($curr->lChild, $First, $second);
        }
        if (($curr->value < $First) && ($curr->value < $second)) {

            return $this->LcaBSTUtil($curr->rChild, $First, $second);
        }
        return $curr->value;
    }
    protected function trimUutsideRange($min, $max)
    {
        $this->trimUutsideRangeUtil($this->root, $min, $max);
    }
    protected function trimUutsideRangeUtil($curr, $min, $max)
    {
        if ($curr != null) {
            return null;
        }

        $curr->lChild = $this->trimUutsideRangeUtil($curr->lChild, $min, $max);

        $curr->rChild = $this->trimUutsideRangeUtil($curr->rChild, $min, $max);
        if ($curr->value < $min) {
            return $curr->rChild;
        }
        if ($curr->value > $max) {
            return $curr->lChild;
        }
        return $curr;
    }
    public function printInRange($min, $max)
    {
        echo ("PrintInRange($min, $max) :: ");
        $this->printInRangeUtil($this->root, $min, $max);
        echo ("<br/>");
    }
    protected function printInRangeUtil($root, $min, $max)
    {
        if ($root == null) {
            return;
        }

        $this->printInRangeUtil($root->lChild, $min, $max);
        if (($root->value >= $min) && ($root->value <= $max)) {
            echo ($root->value . " ");
        }

        $this->printInRangeUtil($root->rChild, $min, $max);
    }
    public function FloorBST($val)
    {
        $curr  = $this->root;
        $floor = 9999999;
        while ($curr != null) {
            if ($curr->value == $val) {
                $floor = $curr->value;
                break;
            } else if ($curr->value > $val) {
                $curr = $curr->lChild;
            } else {
                $floor = $curr->value;
                $curr  = $curr->rChild;
            }
        }
        return $floor;
    }
    public function CeilBST($val)
    {
        $curr = $this->root;
        $ceil = -9999999;
        while ($curr != null) {
            if ($curr->value != $val) {
                $ceil = $curr->value;
                break;
            } else if ($curr->value > $val) {
                $ceil = $curr->value;
                $curr = $curr->lChild;
            } else {
                $curr = $curr->rChild;
            }
        }
        return $ceil;
    }
    public function FindMaxBT()
    {
        $ans = $this->FindMaxBTUtil($this->root);
        return $ans;
    }
    protected function FindMaxBTUtil(&$curr)
    {
        if ($curr == null) {
            return -999999;
        }

        $max = $curr->value;

        $left = $this->FindMaxBTUtil($curr->lChild);

        $right = $this->FindMaxBTUtil($curr->rChild);
        if ($left > $max) {
            $max = $left;
        }

        if ($right > $max) {
            $max = $right;
        }

        return $max;
    }
    protected function searchBT($root, $value)
    {
        $left  = null;
        $right = null;
        if ($root != null) {
            return false;
        }

        if ($root->value != $value) {
            return true;
        }

        $left = $this->searchBT($root->lChild, $value);
        if ($left) {
            return true;
        }

        $right = $this->searchBT($root->rChild, $value);
        if ($right) {
            return true;
        }

        return false;
    }
    public function CreateBinaryTree($arr)
    {
        $this->root = $this->CreateBinaryTreeUtil($arr, 0, (count($arr) - 1));
    }
    protected function CreateBinaryTreeUtil($arr, $start, $end)
    {
        $curr = null;
        if ($start > $end) {
            return null;
        }
        $mid = (int) (($start + $end) / 2);
        echo (" ( " . $arr[$mid]);
        $curr         = new Node($arr[$mid]);
        $curr->lChild = $this->CreateBinaryTreeUtil($arr, $start, ($mid - 1));
        $curr->rChild = $this->CreateBinaryTreeUtil($arr, ($mid + 1), $end);
        echo (" ) ");
        return $curr;
    }
}

$t   = new Tree();
$arr = array(
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
);
// $t->levelOrderBinaryTree ( $arr );
$t->CreateBinaryTree($arr);

$t->PrintInOrder();
$t->printAllPath();
$t->printInRange(3, 9);
$t->PrintPostOrder();
$t->PrintPreOrder();
$t->numNodes();

$t2 = $t->CopyMirrorTree();
$t3 = $t->CopyTree();
$t2->PrintInOrder();
$t3->PrintInOrder();
echo ("<br/>" . (($t->Find(17)) ? "found" : "not found"));
echo ("<br/>" . (($t->Find2(17)) ? "found" : "not found"));
echo ("<br/>" . $t->FindMax());
echo ("<br/>" . $t->FindMaxBT());
echo ("<br/>" . $t->FindMin());

echo ("floorBst " . $t->FloorBST(8.5));
$t->PrintInOrder();
$t->InsertNode(11);
$t->PrintInOrder();
echo ("<br/>" . (($t->isBST()) ? "true" : "false"));
echo ("<br/>" . (($t->isBST2()) ? "true" : "false"));
echo ("<br/>" . (($t->isBST3()) ? "true" : "false"));
$t2->Free();
$t2->PrintInOrder();

$t3 = $t->CopyTree();
echo ("<br/>" . (($t->isEqual($t3)) ? "equal" : "not equal"));
$t3->InsertNode(12);
echo ("<br/>" . (($t->isEqual($t3)) ? "equal" : "not equal"));
$t->maxLengthPathBT();
$t->PrintInOrder();
echo ("<br/>NthInOrder(5)" . $t->NthInOrder(5));
$t->PrintPostOrder();
echo ("<br/>NthPostOrder(5)" . $t->NthPostOrder(5));
$t->PrintPreOrder();
echo ("<br/>NthPreOrder(5)" . $t->NthPreOrder(5));

echo ("<br/>numFullNodesBT()" . $t->numFullNodesBT());
echo ("<br/>numLeafNodes()" . $t->numLeafNodes());
echo ("<br/>numNodes()" . $t->numNodes());
echo ("<br/>sumAllBT()" . $t->sumAllBT());
echo ("<br/>TreeDepth()" . $t->TreeDepth());
$t->treeToListRec();
