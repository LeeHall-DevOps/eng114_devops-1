# Auto Scaling & Monitoring

## How to set up auto-scaling and alarms

You must have a launch template ready

1. Click Auto Scaling Groups at the bottom right
2. Click on create auto scaling group
3. Type the name of your auto scaling group - remember naming conventions.
4. Add your launch template
5. Choose the correct VPC and the correct Availability Zones and subnets.
6. You now want to attach a new load balancer - follow naming conventions.
7. Pick internet facing and create a target group in Listeners and routing and pick it as your default routing.
8. Set your capacity to however much you need.
9. Pick Target tracking scaling policy, select metric type to the one you need, and select the target value.
10. Add notifications and select your SNS Topic.
11. Then just skip to done and you have now just made a auto-scaling group with alarms.

