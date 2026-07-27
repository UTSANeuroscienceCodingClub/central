# PyEEG Toolbox: Journal Club Discussion & Code Tutorial
### Presented by the Neuroscience Coding Club  ⬩  **07-01-2026**

### What we used

#### [PyEEG: An Open Source Python Module for EEG/MEG Feature Extraction](https://pmc.ncbi.nlm.nih.gov/articles/PMC3070217/)
**Bao, Liu, Zhang**
This is the paper we decided on pursuing from our prior meeting. It provides background on this Python module and facts about Python and it's relevance in computer-aided diagnosis 15 years ago (published 2011). This paper includes information regarding the functions and their mathematical definitions, as well as an example of it's use on a dataset (below) of healthy vs. epileptic EEG.
* [PyEEG Github](https://github.com/forrestbao/pyeeg)
* [PyEEG Documentation](https://pyeeg.sourceforge.net/)
* Old [Google Code Archive](https://code.google.com/archive/p/pyeeg/) of PyEEG with some helpful information

#### [Bonn EEG Time Series Dataset](https://www.upf.edu/web/ntsa/downloads/-/asset_publisher/xvT6E4pczrBw/content/2001-indications-of-nonlinear-deterministic-and-finite-dimensional-structures-in-time-series-of-brain-electrical-activity-dependence-on-recording-regi)

View the [kaggle](https://www.kaggle.com/datasets/quands/eeg-dataset/data) source of this dataset for important information regarding the samples, though you may download them through the *Universitat Pompeu Fabra* website to avoid having to create an account. 

Note that the dataset divides the folders in letters F, N, O, S, and Z, whereas the dataset descriptions divide them by A-E. Set mappings are as follows:
```python
{'A': 'Z',
 'B': 'O',
 'C': 'N',
 'D': 'F',
 'E': 'S'}
```
### What's in this folder
We have one Jupyter Notebook with script to load the data and visualize it. We began with an in depth analysis of Power Spectral Intensity and Relative Intensity Ratio given information provided in the paper, and wrote three coding challenges!

#### Happy Coding! 
