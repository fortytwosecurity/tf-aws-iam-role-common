resource "aws_iam_role" "iam_role" {
  name_prefix = "${var.iam_role_name}-"

  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "ec2_tags" {
  name = "ec2Tags"
  role = aws_iam_role.iam_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EC2AllowDescribeCreateTags",
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
                "ec2:CreateTags"
            ],
            "Resource": "*"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "IamRoleManagedPolicyRoleAttachment0" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
