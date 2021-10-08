import torch
import torchvision
import torch2trt

class ModelWrapper(torch.nn.Module):
    def __init__(self, model):
        super(ModelWrapper, self).__init__()
        self.model = model
    def forward(self, x):
        return self.model(x)['out']
        
model = torchvision.models.segmentation.deeplabv3_resnet101(pretrained=True)

model = model.cuda().eval().half()
model_w = ModelWrapper(model).half()

data = torch.ones((1, 3, 224, 224)).cuda().half()



model_trt = torch2trt.torch2trt(model_w, [data], fp16_mode=True)
torch.save(model_trt.state_dict(), 'segment_trt.pth')