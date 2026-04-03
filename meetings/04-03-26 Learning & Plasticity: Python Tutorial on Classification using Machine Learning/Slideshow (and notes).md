# Learning & Plasticity: Python Tutorial on Classification using Machine Learning
### Presented by Miranda Gonzales, Neuroscience PhD Student
**04/03/2026** ⬩ See the raw powerpoint [here](https://docs.google.com/presentation/d/1nIV9tHDPhhKCv-mtlrPolSVVmleTukab/edit?usp=sharing&ouid=101472612575020551817&rtpof=true&sd=true)  
Run the attached jpynb in Colab [here](https://colab.research.google.com/github/UTSANeuroscienceCodingClub/central/blob/master/meetings/04-03-26%20Learning%20%26%20Plasticity%3A%20Python%20Tutorial%20on%20Classification%20using%20Machine%20Learning/NCC_Tempotron_MG_260403.ipynb) so you don't need to download libraries!
*supplemental resources are in this subfolder!*  
## Slides and Minutes
### <img src="https://github.com/user-attachments/assets/06fa4b0f-d63b-461a-a0d8-3368b0eafcd2" alt="Slide1" width="1280" height="720" />



### <img src="https://github.com/user-attachments/assets/fce2f9e7-2cf9-4eb7-a76a-f5dd0babc3c5" alt="Slide2" width="1280" height="720" />

### How we think about learning plasticity in the brain
* Can change over time
* Neurons can change, plastically, in a structural, functional, or network fashion.
#### "Models of the Mind" Grace Lindsay figure on the right: why Perceptron came about
*   So inspiraitonal: directly inspired by Neuroscience
*   Rightmost: cerebellum network structures, where cells provide input and may act like a classifier

### <img src="https://github.com/user-attachments/assets/b587e215-ed0f-4112-849d-05c1c8abc07f" alt="Slide3" width="1280" height="720" />

### What is Artificial Intelligence: LLMs
* Like ChatGPT, Grok, Gemini, are **really specific** in terms of artificial intelligence

### <img src="https://github.com/user-attachments/assets/624dea4f-3234-4670-aac1-5d2adb7f25c7" alt="Slide4" width="1280" height="720" />

Being able to identify discrete things, where machine networks can do this same thing
Supervised learning is a broad topic where classified learning is a subtopic. 
* Another type of supervised learning in comparison to classification is **regression**, using continuous data

Discrete: if loan status = rejected/approved
Continuous: predicting loan amounts on the continuous timeline

### <img src="https://github.com/user-attachments/assets/20b14c8a-ea71-4c68-8ed6-26ddc1afdd53" alt="Slide5" width="1280" height="720" />

### Perceptron
An example of superivsed learning, inspired by the brain
### History
Published in seminal paper 1958, Frank Rosenblatt in the advent of computers
* Using algorithims to see if computers can _think_

### <img src="https://github.com/user-attachments/assets/fe025530-e422-49c8-89a2-1c3e35839978" alt="Slide6" width="1280" height="720" />

### Pushing the Perceptron's limits
Getting inputs to read the data, learn from errors, then train a single readout unit for a single task
* These models get inspiration from Neuroscience and abstract them into a single principle
### Comparison to a unit of a neuron (right)
Perceptrons can be directly compared to real neurons

### <img src="https://github.com/user-attachments/assets/a4bbeed0-334a-4f4c-ac92-b7d1c8904996" alt="Slide7" width="1280" height="720" />

Standard Perceptron alg. jhas you initizlize weights
Go thru training steps (1) and apply a summation (multiply weights acrosss activity x.P) 
  Update weights dependent on result^

Could learn something that is linearlly separable, seen i nthe upper right figure. Can define a line that cuts between which neurons do and do not spike.

Q: How to decide which model is clearer, or if our data doesnt allow for a single line to separate?
> Proved Perceptron had limitations: linear separability

### <img src="https://github.com/user-attachments/assets/6a74568d-6139-4851-bc29-7b87e5382c5f" alt="Slide8" width="1280" height="720" />

### The Temprotron
Basically, the Perceptron, but used spiking neural entwork to implement learning network
Perception used mean firing, whereas Tempotron doesn't

Left figure: Output neuron (right triangle fiure) = array of input strikes at time, and when received, changes voltage, and when passes threshold, $V_thr$, it either will (above) or wont (below). Once spikes, does provide activity, but decays, exponentially (shown in figure C)

Right figure: If the model doesnt spike when it should, or it does when it shouldnt (gray outline), will trigger a weight update, effectively retraining the Tempotron. Spike scloser to where they _should_ spike are weighted larger ($t_max$), and further from where they should spike, they are weighted less, (almost 0 value)

### <img src="https://github.com/user-attachments/assets/0681571a-f430-485f-b42c-1b7f91044128" alt="Slide9" width="1280" height="720" />

Tempotron = spikes to trigger updates, voltage bases but 50 years later
Perc = Rate-based mean firing rates and similar weight-based

### <img src="https://github.com/user-attachments/assets/139c031f-cd0e-4bfa-bf6a-b3be128d670f" alt="Slide10" width="1280" height="720" />
_courtesy of NotebookLM_

### <img src="https://github.com/user-attachments/assets/f60ff391-3c75-4cc3-a907-733ce78ce21e" alt="Slide11" width="1280" height="720" />

Q: How can I use Tempotron to accomplish my tasks and research?

### <img src="https://github.com/user-attachments/assets/9d34c8f5-fdb2-4b68-b938-15c50ee48d91" alt="Slide12" width="1280" height="720" />

Basic equation (1) weights are multiplied by kernel to provide Voltage, $V(t)$. Kernel represented by the graph as a function of time, depending on $\tau$, the membrane time constant

Code on top right is a LIF, taking $\tau$ and into (line 15) exponential equation, a rising phase and a decay.

### <img src="https://github.com/user-attachments/assets/7b92528c-c07d-4152-b4e7-66e924c28199" alt="Slide13" width="1280" height="720" />

With the neuron equation, problem = how to represent my research by a set of spikes? Using tokens, can a Tempotron neuron see a sequence, label feedback, and update weights to recognize the sequence faster?

This pattern has some deterministic portions, so the tempotron should b able to recognize

How to represent the letter 'G' as a set of spikes?
Assign a specific neuron with a specific token, e.g. Neuron 3 on C, N4 on G, etc.
> Didn't work



### <img src="https://github.com/user-attachments/assets/b30c9a2e-fd07-40c6-a7ce-9c0c52e2b26f" alt="Slide14" width="1280" height="720" />

The Tempotron _did_ learn, but didn't learn everything.

Bottom left figure: After ~500 trials, Tempotron stagnated at same weights
Bottom right figure: After 100,000 trials, extreme weight variance
 
### <img src="https://github.com/user-attachments/assets/726d8482-e417-44d5-abaa-ff48afa0f0c3" alt="Slide15" width="1280" height="720" />

Hypothesis: neurons requried time to rise and decay, potentially gap between token presentations could chang ethe dynamics

### <img src="https://github.com/user-attachments/assets/b91c375f-5d41-4998-9ce5-e8975b1bd0c5" alt="Slide16" width="1280" height="720" />

Note the periods before the token presentation in the spiking figures on the top

### <img src="https://github.com/user-attachments/assets/e98b447d-0f69-4164-a6ec-58658d2462cd" alt="Slide17" width="1280" height="720" />

Changing the learning rate and $\tau$ provided interesting patterns, but didn't go anywhere. However, this only happened in unique pairs; there were symmetry for the inputs.

### <img src="https://github.com/user-attachments/assets/7dbf15f9-f5ea-4fce-a479-f358690b4d50" alt="Slide18" width="1280" height="720" />



### <img src="https://github.com/user-attachments/assets/798405f3-482b-45d2-8e74-fb154f633737" alt="Slide19" width="1280" height="720" />

Top figure: first starts learning prior to updates, initialized state contains high rate of errors.
As the Tempotron updates w/feedback, training error decreases to deterministic where weights do not change, therefore can perfectly determine when token 'G' can occur.

### <img src="https://github.com/user-attachments/assets/a939c091-e604-4c58-8907-5a4951cbe598" alt="Slide20" width="1280" height="720" />

There were points without 0% error, e.g.g Tempotron C, which was a successs as only training with two tokens

### <img src="https://github.com/user-attachments/assets/c02533a6-97d9-46ed-8310-5f2488d4a085" alt="Slide21" width="1280" height="720" />

Tempotrons get down to their minimum error

### <img src="https://github.com/user-attachments/assets/ed1bc840-b83c-4dcb-8edb-287e4a45cf19" alt="Slide22" width="1280" height="720" />

Classic ML example = training your model on MNIST dataset

### <img src="https://github.com/user-attachments/assets/aa9f5029-8b8a-4a93-8ca3-d9e91320d9f8" alt="Slide23" width="1280" height="720" />

Miranda will show their code on how to make the histogram 
Make sure to open the debugger panel and show line numbers in the view tab, when using Jupyter Notebook!



### <img src="https://github.com/user-attachments/assets/5a5dcd68-823e-4524-88ff-90ce094ba0c6" alt="Slide24" width="1280" height="720" />


