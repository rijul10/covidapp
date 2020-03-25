import flask
import pickle
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import img_to_array
# from tensorflow.keras.applications import imagenet_utils
from PIL import Image
import io
import cv2
import numpy as np
import h5py
from flask import jsonify
import os

os.environ['KMP_DUPLICATE_LIB_OK']='True'

app = flask.Flask(__name__,template_folder = 'templates')
model = None

def load_model1():

	global model
	model = load_model('my_model.h5')

def prepare_image(image):
    
	image = cv2.cvtColor(np.float32(image), cv2.COLOR_BGR2RGB)
	image = cv2.resize(image, (224, 224))
	image = np.array(image)
	image = image / 255.0
	image = np.expand_dims(image, axis=0)

	

	return image

@app.route("/", methods=["GET"])
def main():
	if flask.request.method == 'GET':
		return(flask.render_template('main.html'))


@app.route("/upload", methods=["GET","POST"])
def uploader():

	if flask.request.method == "POST":
		
		image = flask.request.files["file"].read()
		image = Image.open(io.BytesIO(image))

		image = prepare_image(image)

        
		preds = model.predict(image.tolist(), batch_size = 1).tolist()
		preds = np.argmax(preds, axis=1).tolist()
            # results = imagenet_utils.decode_predictions(preds)
			
            # data["predictions"] = []
			
			# data['pred'] = preds

            # for (imagenetID, label, prob) in results[0]:
            #     r = {"label": label, "probability": float(prob)}
            #     data["predictions"].append(r)

            
            # data["success"] = True

    
	return jsonify({'preds': preds})



if __name__ == "__main__":
	print(("* Loading Keras model and Flask starting server..."
        "please wait until server has fully started"))
	load_model1()
	app.run()