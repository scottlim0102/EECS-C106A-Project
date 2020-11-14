import rospy
import numpy as np
import kin_func_skeleton as kfs
from sensor_msgs.msg import JointState


def lab3(message):
    q = np.ndarray((3,8))
    w = np.ndarray((3,7))
    
    q[0:3,0] = [0.0635, 0.2598, 0.1188]
    q[0:3,1] = [0.1106, 0.3116, 0.3885]
    q[0:3,2] = [0.1827, 0.3838, 0.3881]
    q[0:3,3] = [0.3682, 0.5684, 0.3181]
    q[0:3,4] = [0.4417, 0.6420, 0.3177]
    q[0:3,5] = [0.6332, 0.8337, 0.3067]
    q[0:3,6] = [0.7152, 0.9158, 0.3063]
    q[0:3,7] = [0.7957, 0.9965, 0.3058]

    w[0:3,0] = [-0.0059,  0.0113,  0.9999]
    w[0:3,1] = [-0.7077,  0.7065, -0.0122]
    w[0:3,2] = [ 0.7065,  0.7077, -0.0038]
    w[0:3,3] = [-0.7077,  0.7065, -0.0122]
    w[0:3,4] = [ 0.7065,  0.7077, -0.0038]
    w[0:3,5] = [-0.7077,  0.7065, -0.0122]
    w[0:3,6] = [ 0.7065,  0.7077, -0.0038]

    R = np.array([[0.0076, 0.0001, -1.0000],
                          [-0.7040, 0.7102, -0.0053],
                          [0.7102, 0.7040, 0.0055]]).T

    # YOUR CODE HERE

    xi_s0 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,0])), np.array(q[0:3,0])), [w[0:3,0]])
    xi_s1 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,1])), np.array(q[0:3,1])), [w[0:3,1]])
    xi_e0 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,2])), np.array(q[0:3,2])), [w[0:3,2]])
    xi_e1 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,3])), np.array(q[0:3,3])), [w[0:3,3]])
    xi_w0 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,4])), np.array(q[0:3,4])), [w[0:3,4]])
    xi_w1 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,5])), np.array(q[0:3,5])), [w[0:3,5]])
    xi_w2 = np.append(np.matmul(-kfs.skew_3d(np.array(w[0:3,6])), np.array(q[0:3,6])), [w[0:3,6]])
    
    arg1 = np.array([xi_s0, xi_s1, xi_e0, xi_e1, xi_w0, xi_w1, xi_w2]).T
    arg2 = np.array([message.position[4], message.position[5], message.position[2], 
                            message.position[3], message.position[6], message.position[7], message.position[8]])

    g_st_0 = np.zeros((4,4))
    g_st_0[0:3, 0:3] = R
    g_st_0[0:3, 3] = q[0:3,7]
    g_st_0[3, 3] = 1
    g_st_final = np.matmul(kfs.prod_exp(arg1, arg2), g_st_0)

    print(g_st_final)

#Define the method which contains the node's main functionality
def listener():

    #Create a new instance of the rospy.Subscriber object which we can 
    #use to receive messages of type std_msgs/String from the topic /chatter_talk.
    #Whenever a new message is received, the method callback() will be called
    #with the received message as its first argument.
    rospy.Subscriber("robot/joint_states", JointState, lab3)


    #Wait for messages to arrive on the subscribed topics, and exit the node
    #when it is killed with Ctrl+C
    rospy.spin()

if __name__ == "__main__":
    rospy.init_node('listener', anonymous=True)
    listener()