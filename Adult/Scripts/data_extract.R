# Load training data
data = read.table('C:/Users/Gibril Gaye/Downloads/adult.data',
		            	sep = ',', na.strings = ' ?')

headers_data = c('age', 'workclass', 'final_wt','educ', 'educ_num',
			           'marital_status', 'occupation', 'relationship',
		          	 'race', 'sex', 'cap_gain', 'cap_loss', 'hours_per_week',
			           'native-country', 'class')

write.table(data, 'C:/Users/Gibril Gaye/Desktop/SProject-Data analysis/raw_train.csv')

names(data) = headers_data


# remove missing values: 7% of dataset

data = na.omit(data)

write.table(data, 'C:/Users/Gibril Gaye/Desktop/SProject-Data analysis/train.csv')

# load data description and redirect output to txt file

data_desc = readLines('C:/Users/Gibril Gaye/Downloads/adult.names')
write.table(data_desc, 'C:/Users/Gibril Gaye/Desktop/SProject-Data analysis/desc.txt',
		        row.names = FALSE)

# load test data
test_data = read.table('C:/Users/Gibril Gaye/Downloads/adult.test', sep = ',',
			                 skip = 1, na.strings = ' ?')

names(test_data) = headers_data

write.table(test_data, 'C:/Users/Gibril Gaye/Desktop/SProject-Data analysis/test.csv')
