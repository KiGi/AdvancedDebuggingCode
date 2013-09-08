#!/bin/sh
cd DataObjects
mogenerator --template-var arc=true -m ../DebuggingModel.xcdatamodeld/DebuggingModel\ v1.0.xcdatamodel
