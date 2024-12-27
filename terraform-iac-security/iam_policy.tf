
resource "aws_iam_policy" "policy" {
  name        = "cand-c3-l4-e1-iam-policy"
  path        = "/"
  description = "a policy to test IAC scanning"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}
