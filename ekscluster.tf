resource "aws_eks_cluster" "sampleeks" {
  name     = "sampleeks"
  role_arn = "${aws_iam_role.example.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.terra_pub1.id}", "${aws_subnet.terra_pub2.id}"]
  }
  depends_on = [
    "aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.example-AmazonEKSServicePolicy",
  ]
}
