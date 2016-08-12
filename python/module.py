
# coding: utf-8

# In[35]:

import os
import numpy as np
from scipy import *
from scipy.sparse import *
from scipy.spatial import distance
from scipy.stats import entropy
import pandas as pd
from fancyimpute import BiScaler, KNN, NuclearNormMinimization, SoftImpute
import matplotlib.pyplot as plt
import seaborn as sns

def sparseload(file):
    f = open(file)
    h = f.readline()
    col = []
    data = []
    chrom = []
    for l in f:
        l = l.strip()
        chrom.append(l.split('\t')[0])
        col.append(int(l.split('\t')[1]))
        data.append(int(float(l.split('\t')[2])))
    col = np.array(col)
    data = np.array(data)
    chrom = np.array(chrom)
    f.close()
    return chrom,col,data

def structure_genome(resolution):
    f = open('/home/garner1/Work/pipelines/data/relevant-chr-size_list.txt')
    base = 0
    positionlist = []
    chromlist = []
    border = []
    for l in f.readlines():
        l = l.strip()
        chrom = l.split('\t')[0]
        size = l.split('\t')[1]
        end = base + int(size)/resolution
        border.append(end)
        array = arange(base, end)
        positionlist.extend(array)
        chromlist.extend([chrom]*len(array))
        base = base + int(size)/resolution
    f.close()
    return positionlist, chromlist, border

def load_data(experiment,resolution,positionlist):
    regions = os.listdir('/home/garner1/Work/dataset/restseq/data/'+str(experiment)+'/'+str(resolution))
    length = 0
    row_list = []
    indexExp_list = []
    index0_list = []
    index1_list = []
    index2_list = []
    index3_list = []
    for region in sorted(regions):
        filename = '/home/garner1/Work/dataset/restseq/data/'+str(experiment)+'/'+str(resolution)+'/'+region
        if experiment=='xz_13' or experiment=='xz_14' or experiment=='xz_18' or experiment=='xz_19' or experiment=='xz_20' or experiment=='xz_21' or experiment=='xz_22'  or experiment=='xz_23' or experiment=='xz_24' or experiment=='xz_23_24':
            indexExp = experiment
            index0 = region[0]
            index1 = region[2]
            indexExp_list.append(indexExp)
            index0_list.append(index0)
            index1_list.append(index1)
        if experiment=='xz_10_15':
            index0 = region[0]
            index1 = region[2]
            if len(region[3:len(region)-4])==3:
                index2 = region[3:len(region)-4][0]
                index3 = region[3:len(region)-4][2]
            if len(region[3:len(region)-4])==2:
                index2 = 'A'
                index3 = region[3:len(region)-4][1]
            index0_list.append(index0)
            index1_list.append(index1)
            index2_list.append(index2)
            index3_list.append(index3)
        chrom, col, data = sparseload(filename)
        row = np.zeros(len(col))
        vec_sparse = csc_matrix((data,(row,col-1)), shape=(1,len(positionlist)))
        row_list.append(vec_sparse.toarray())
    X = np.vstack( row_list )
    return X,indexExp_list,index0_list,index1_list,index2_list,index3_list

def load_RCdf(X,experiment,chromlist,positionlist,groupby,RC_threshold,indexExp_list,index0_list,index1_list,index2_list,index3_list):
    arrays = [chromlist, positionlist]
    columns = pd.MultiIndex.from_arrays(arrays, names=['chromosome', 'bin'])
    if experiment=='xz_10_15':
        row = pd.MultiIndex.from_arrays([index0_list,index1_list,index2_list,index3_list],names=['patient','type','set','fragment'])
    if experiment=='xz_13' or experiment=='xz_14' or experiment=='xz_18' or experiment=='xz_19' or experiment=='xz_20' or experiment=='xz_21' or experiment=='xz_22'  or experiment=='xz_23' or experiment=='xz_24' or experiment=='xz_23_24':
        row = pd.MultiIndex.from_arrays([indexExp_list,index0_list,index1_list],names=['experiment','row','column'])
    X_df = pd.DataFrame(data=X,index=row,columns=columns)
    '''
    Remove rows with 0 read counts
    '''
    X_df = X_df.loc[~(X_df==0).all(axis=1)]
    '''
    Group data
    '''
    if groupby=='10-15-reduced':
        X_red_df = X_df.groupby(level=['patient','type','set']).sum()
    if groupby=='13-14-reduced' or groupby=='23-24-reduced':
        X_red_df = X_df.groupby(level=['row','column']).sum()
    if groupby=='none':
        X_red_df = X_df
    '''
    Set zero columns
    '''
#    mask = X==0
#    row_sum = (~mask).sum(axis=0)
#    mask = row_sum==0
#    zero_col = np.arange(X.shape[1])[mask]
    '''
    Remove columns with 0 read counts
    '''
#    X_red_df = X_red_df[X_red_df.columns[(X_red_df != 0).any()]]
    '''
    Remove rows with read counts less than threshold
    '''
    X_red_df = X_red_df.loc[~(X_red_df.sum(axis=1)<RC_threshold)]
    '''
    Define the data matrix
    '''
    X = X_red_df.as_matrix()
    return X_df,X_red_df,X#,zero_col


# In[40]:

#def impute(X,zero_col):
def impute(X):
    X_incomplete = X.copy()
    X_incomplete = X_incomplete*1.0
    X_incomplete[X_incomplete==0] = np.nan
    softImpute = SoftImpute(max_iters=100,n_power_iterations=3,min_value=0,verbose=False)
    # # simultaneously normalizes the rows and columns of your observed data,
    # # sometimes useful for low-rank imputation methods
    biscaler = BiScaler()
    # # rescale both rows and columns to have zero mean and unit variance
    X_incomplete_normalized = biscaler.fit_transform(X_incomplete)
    X_filled_softimpute_normalized = softImpute.complete(X_incomplete_normalized)
    X_filled_softimpute = biscaler.inverse_transform(X_filled_softimpute_normalized)
    X_filled_softimpute = softImpute.complete(X_incomplete)
    '''
    Re-insert the zeros cols
    '''
    #zero_col = zero_col[:-2]
    #X_filled_softimpute = np.insert(X_filled_softimpute,zero_col,0,axis=1) 
    return X_filled_softimpute


# In[41]:

'''
Normalize rows to 1
'''
def normalize(X_array,X_red_df):
    col_sum = X_array.sum(axis=1)
    X_array_normalized = np.zeros(X_array.shape)
    for ind in range(X_array.shape[0]):
        X_array_normalized[ind,:] = X_array[ind,:]*1.0/col_sum[ind]
    X_array_normalized_df = pd.DataFrame(data=X_array_normalized,index=X_red_df.index)
    X_df = pd.DataFrame(data=X_array,index=X_red_df.index)
    return X_array_normalized_df,X_df
'''
Normalize rows to 1
'''
def new_normalize(X_df):
    X_array = np.asarray(X_df)
    col_sum = X_array.sum(axis=1)
    X_array_normalized = np.zeros(X_array.shape)
    for ind in range(X_array.shape[0]):
        X_array_normalized[ind,:] = X_array[ind,:]*1.0/col_sum[ind]
    X_normalized_df = pd.DataFrame(data=X_array_normalized,index=X_df.index)
    return X_normalized_df


# In[42]:

def shannonDF(X_filled_df):
    index = ['A','B','C','D','E','F','G','H','I','J']
    columns = ['1','2','3','4','5','6','7']
    shannon_df_xz1314 = pd.DataFrame(0,index=index, columns=columns)
    shannon_df_xz13 = pd.DataFrame(0,index=index, columns=columns)
    shannon_df_xz14 = pd.DataFrame(0,index=index, columns=columns)
    shannon = []
    df = X_filled_df
    for i in df.index:
        shannon.append( entropy(df.ix[i]) )
    for i in range(len(df.index.values)):
        if df.index.values[i][0]=='xz13':
            shannon_df_xz13.ix[df.index.values[i][1],df.index.values[i][2]] = shannon[i]
        if df.index.values[i][0]=='xz14':
            shannon_df_xz14.ix[df.index.values[i][1],df.index.values[i][2]] = shannon[i]
        if df.index.values[i][0]!='xz13' and df.index.values[i][0]!='xz14':
            shannon_df_xz1314.ix[df.index.values[i][0],df.index.values[i][1]] = shannon[i]
    return shannon_df_xz1314,shannon_df_xz13,shannon_df_xz14

def readcountDF(X_filled_df):
    index = ['A','B','C','D','E','F','G','H','I','J']
    columns = ['1','2','3','4','5','6','7']
    totalRC_df_xz1314 = pd.DataFrame(0,index=index, columns=columns)
    totalRC_df_xz13 = pd.DataFrame(0,index=index, columns=columns)
    totalRC_df_xz14 = pd.DataFrame(0,index=index, columns=columns)
    totalRC = []
    df = X_filled_df
    for i in df.index:
        totalRC.append( df.ix[i].sum(axis=0) )
    for i in range(len(df.index.values)):
        if df.index.values[i][0]=='xz13' or df.index.values[i][0]=='xz23':
            totalRC_df_xz13.ix[df.index.values[i][1],df.index.values[i][2]] = totalRC[i]
        if df.index.values[i][0]=='xz14' or df.index.values[i][0]=='xz24':
            totalRC_df_xz14.ix[df.index.values[i][1],df.index.values[i][2]] = totalRC[i]
        if df.index.values[i][0]!='xz13' and df.index.values[i][0]!='xz14':
            totalRC_df_xz1314.ix[df.index.values[i][0],df.index.values[i][1]] = totalRC[i]
        if df.index.values[i][0]!='xz23' and df.index.values[i][0]!='xz24':
            totalRC_df_xz1314.ix[df.index.values[i][0],df.index.values[i][1]] = totalRC[i]
    return totalRC_df_xz1314,totalRC_df_xz13,totalRC_df_xz14


'''
Distance between regions
'''
def NNdistDF(X_filled_df, shannon_df_xz1314,shannon_df_xz13,shannon_df_xz14,totalRC_df_xz1314,totalRC_df_xz13,totalRC_df_xz14):
    index = ['A','a-b','B','b-c','C','c-d','D','d-e','E','e-f','F','f-g','G','g-h','H','h-i','I','i-j','J']
    columns = ['1','1-2','2','2-3','3','3-4','4','4-5','5','5-6','6','6-7','7']
    df = X_filled_df
    delta_df_xz1314 = pd.DataFrame(0,index=index, columns=columns)
    delta_df_xz13 = pd.DataFrame(0,index=index, columns=columns)
    delta_df_xz14 = pd.DataFrame(0,index=index, columns=columns)
    if len(df.index.values[0])==2:
        rr = 0
        for row in range(len(shannon_df_xz1314.ix[:,0])-1):
            cc = 1
            for col in range(len(shannon_df_xz1314.ix[0,:])-1):
                if totalRC_df_xz1314.ix[row,col]!=0 and totalRC_df_xz1314.ix[row,col+1]!=0:
                    ind1 = str(shannon_df_xz1314.index.values[row])
                    ind2 = str(shannon_df_xz1314.columns.values[col])
                    ind3 = str(shannon_df_xz1314.columns.values[col+1])
                    delta_df_xz1314.ix[index[rr],columns[cc]] = distance.cosine(df.ix[ind1,ind2],df.ix[ind1,ind3])
                cc = cc+2
            rr = rr+2
        rr = 1
        for row in range(len(shannon_df_xz1314.ix[:,0])-1):
            cc = 0
            for col in range(len(shannon_df_xz1314.ix[0,:])-1):
                if totalRC_df_xz1314.ix[row,col]!=0 and totalRC_df_xz1314.ix[row+1,col]!=0:
                    ind1 = str(shannon_df_xz1314.index.values[row])
                    ind2 = str(shannon_df_xz1314.columns.values[col])
                    ind3 = str(shannon_df_xz1314.index.values[row+1])
                    delta_df_xz1314.ix[index[rr],columns[cc]] = distance.cosine(df.ix[ind1,ind2],df.ix[ind3,ind2])
                cc = cc+2
            rr = rr+2
    if len(df.index.values[0])==3:
        rr = 0
        for row in range(len(shannon_df_xz13.ix[:,0])-1):
            cc = 1
            for col in range(len(shannon_df_xz13.ix[0,:])-1):
                if totalRC_df_xz13.ix[row,col]!=0 and totalRC_df_xz13.ix[row,col+1]!=0:
                    ind0 = 'xz13'
                    ind1 = str(shannon_df_xz13.index.values[row])
                    ind2 = str(shannon_df_xz13.columns.values[col])
                    ind3 = str(shannon_df_xz13.columns.values[col+1])
                    delta_df_xz13.ix[index[rr],columns[cc]] = distance.cosine(df.ix[ind0,ind1,ind2],df.ix[ind0,ind1,ind3])
                cc = cc+2
            rr = rr+2
        rr = 1
        for row in range(len(shannon_df_xz13.ix[:,0])-1):
            cc = 0
            for col in range(len(shannon_df_xz13.ix[0,:])-1):
                if totalRC_df_xz13.ix[row,col]!=0 and totalRC_df_xz13.ix[row+1,col]!=0:
                    ind0 = 'xz13'
                    ind1 = str(shannon_df_xz13.index.values[row])
                    ind2 = str(shannon_df_xz13.columns.values[col])
                    ind3 = str(shannon_df_xz13.index.values[row+1])
                    delta_df_xz13.ix[index[rr],columns[cc]] = distance.cosine(df.ix[ind0,ind1,ind2],df.ix[ind0,ind3,ind2])
                cc = cc+2
            rr = rr+2
        rr = 0
        for row in range(len(shannon_df_xz14.ix[:,0])-1):
            cc = 1
            for col in range(len(shannon_df_xz14.ix[0,:])-1):
                if totalRC_df_xz14.ix[row,col]!=0 and totalRC_df_xz14.ix[row,col+1]!=0:
                    ind0 = 'xz14'
                    ind1 = str(shannon_df_xz14.index.values[row])
                    ind2 = str(shannon_df_xz14.columns.values[col])
                    ind3 = str(shannon_df_xz14.columns.values[col+1])
                    delta_df_xz14.ix[index[rr],columns[cc]] = distance.cosine(df.ix[ind0,ind1,ind2],df.ix[ind0,ind1,ind3])
                cc = cc+2
            rr = rr+2
        rr = 1
        for row in range(len(shannon_df_xz14.ix[:,0])-1):
            cc = 0
            for col in range(len(shannon_df_xz14.ix[0,:])-1):
                if totalRC_df_xz14.ix[row,col]!=0 and totalRC_df_xz14.ix[row+1,col]!=0:
                    ind0 = 'xz14'
                    ind1 = str(shannon_df_xz14.index.values[row])
                    ind2 = str(shannon_df_xz14.columns.values[col])
                    ind3 = str(shannon_df_xz14.index.values[row+1])
                    delta_df_xz14.ix[index[rr],columns[cc]] = distance.cosine(df.ix[ind0,ind1,ind2],df.ix[ind0,ind3,ind2])
                cc = cc+2
            rr = rr+2
    return delta_df_xz1314,delta_df_xz13,delta_df_xz14


# In[46]:

'''
Fluctuations with respect to the average
'''
def fluctuationDF(X_filled_df,X_filled_softimpute):
    mean = X_filled_softimpute.sum(axis=0)
    mean = mean*1.0/mean.sum()
    index = ['A','B','C','D','E','F','G','H','I','J']
    columns = ['1','2','3','4','5','6','7']
    fluctuation_df_xz1314 = pd.DataFrame(0,index=index, columns=columns)
    fluctuation_df_xz13 = pd.DataFrame(0,index=index, columns=columns)
    fluctuation_df_xz14 = pd.DataFrame(0,index=index, columns=columns)
    fluctuation = []
    df = X_filled_df
    if len(df.index.values[0])==2:
        for i in df.index:
            fluctuation.append( distance.cosine(df.ix[i],mean) )
        for i in range(len(df.index.values)):
            fluctuation_df_xz1314.ix[df.index.values[i][0],df.index.values[i][1]] = fluctuation[i]
    if len(df.index.values[0])==3:
        for i in df.index:
            fluctuation.append( distance.cosine(df.ix[i],mean) )
        for i in range(len(df.index.values)):
            if df.index.values[i][0]=='xz13':
                fluctuation_df_xz13.ix[df.index.values[i][1],df.index.values[i][2]] = fluctuation[i]
            if df.index.values[i][0]=='xz14':
                fluctuation_df_xz14.ix[df.index.values[i][1],df.index.values[i][2]] = fluctuation[i]
    return fluctuation_df_xz1314,fluctuation_df_xz13,fluctuation_df_xz14


# In[55]:

'''
Fluctuations between co-localized regions, measured with KL
'''
def local_fluctuationsDF(X_filled_df):
    index = ['A','B','C','D','E','F','G','H','I','J']
    columns = ['1','2','3','4','5','6','7']
    local_fluctuation_df = pd.DataFrame(0,index=index, columns=columns)
    fluctuation = []
    df = X_filled_df
    if len(df.index.values[0])==3:
        for i in range(len(df.index.values)):
            if ('xz13',df.index.values[i][1],df.index.values[i][2]) in df.index and ('xz14',df.index.values[i][1],df.index.values[i][2]) in df.index:
                state1 = df.ix['xz13',df.index.values[i][1],df.index.values[i][2]]
                state2 = df.ix['xz14',df.index.values[i][1],df.index.values[i][2]]
                local_fluctuation_df.ix[ df.index.values[i][1],df.index.values[i][2] ] = distance.cosine(state1,state2)
    return local_fluctuation_df

