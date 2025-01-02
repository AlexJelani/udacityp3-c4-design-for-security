from diagrams import Diagram, Cluster, Edge
from diagrams.programming.language import Python
from diagrams.onprem.vcs import Github
from diagrams.aws.security import Inspector, IAM
from diagrams.aws.management import Config, Cloudwatch
from diagrams.aws.storage import S3
from diagrams.onprem.ci import Jenkins
from diagrams.aws.compute import EC2

with Diagram("DevSecOps Pipeline", show=False, direction="LR"):
    # Development Stage
    with Cluster("Development"):
        code = Python("Application Code")
        repo = Github("Source Control")
        
    # Build & Security Scan Stage    
    with Cluster("Build & Security"):
        build = Jenkins("Build Server")
        checkov = EC2("Checkov IaC Scan")
        inspector = Inspector("AMI Scan")
        
    # Deploy Stage
    with Cluster("Deployment"):
        iam = IAM("IAM Validation")
        s3 = S3("Artifact Store")
        
    # Monitoring Stage
    with Cluster("Security Monitoring"):
        config = Config("AWS Config")
        securityhub = Cloudwatch("Security Hub")
        
    # Flow
    code >> repo >> build
    build >> checkov >> inspector
    inspector >> iam >> s3
    s3 >> config >> securityhub
