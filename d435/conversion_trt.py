import os
import torch
from torch import nn
from torchvision.datasets import MNIST
from torch.utils.data import DataLoader
from torchvision import transforms
from torch2trt import torch2trt

def encoder_block(inchannel, outchannel):
    conv=nn.Sequential(
        nn.Conv2d(inchannel, outchannel, kernel_size=3, padding=1),
        nn.BatchNorm2d(outchannel),
        nn.ReLU(inplace=True),
        nn.Conv2d(outchannel, outchannel, kernel_size=3, padding=1),
        nn.BatchNorm2d(outchannel),
        nn.ReLU(inplace=True),)
    
      
    return conv


def bottleneck (inchannel, outchannel):
    conv=nn.Sequential(
        nn.Conv2d(inchannel, outchannel, kernel_size=3, padding=1),
        nn.BatchNorm2d(outchannel),
        nn.ReLU(inplace=True),
        nn.Conv2d(outchannel, outchannel, kernel_size=3, padding=1),
        nn.BatchNorm2d(outchannel),
        nn.ReLU(inplace=True),
        
    )
    return conv


    
def decoder_conv(inchannel, outchannel):
    conv=nn.Sequential(
        nn.Conv2d(outchannel+outchannel, outchannel, kernel_size=3, padding=1),
        nn.BatchNorm2d(outchannel),
        nn.ReLU(inplace=True),
        nn.Conv2d(outchannel, outchannel, kernel_size=3, padding=1),
        nn.BatchNorm2d(outchannel),
        nn.ReLU(inplace=True),
        
    )
    return conv

class UNet(nn.Module):
    def __init__(self):
        super().__init__()
       
                
        """ Encoder """
        self.maxpool = nn.MaxPool2d(kernel_size=2, stride=2)        
        self.e1 = encoder_block(3, 16)
        self.e2 = encoder_block(16, 32)
        self.e3 = encoder_block(32, 64)
        self.e4 = encoder_block(64, 128)

        """ Bottleneck """
        self.b = bottleneck(128, 256)

        """ Decoder """
        self.dtrans1 = nn.ConvTranspose2d(256, 128, kernel_size=2, stride=2, padding=0)
        self.d1 = decoder_conv(128+128, 128)
        self.dtrans2 = nn.ConvTranspose2d(128, 64, kernel_size=2, stride=2, padding=0)
        self.d2 = decoder_conv(64+64, 64)
        self.dtrans3 = nn.ConvTranspose2d(64, 32, kernel_size=2, stride=2, padding=0)
        self.d3 = decoder_conv(32+32, 32)
        self.dtrans4 = nn.ConvTranspose2d(32, 16, kernel_size=2, stride=2, padding=0)
        self.d4 = decoder_conv(16+16, 16)

        """ Classifier """
        self.sigmoid=nn.Sigmoid()
        self.outputs = nn.Conv2d(16, 1, kernel_size=1, stride=1, padding=0)

    def forward(self, inputs):
        """ Encoder """
        s1 = self.e1(inputs)
        p1 = self.maxpool(s1)
        s2 = self.e2(p1)
        p2 = self.maxpool(s2)
        s3 = self.e3(p2)
        p3 = self.maxpool(s3)
        s4 = self.e4(p3)
        p4 = self.maxpool(s4)

        """ Bottleneck """
        b = self.b(p4)

        """ Decoder """
        
        x = self.dtrans1(b)
        x = torch.cat([x, s4], axis=1)
        d1= self.d1(x)
        x = self.dtrans2(d1)
        x = torch.cat([x, s3], axis=1)
        d2= self.d2(x)
        x = self.dtrans3(d2)
        x = torch.cat([x, s2], axis=1)
        d3= self.d3(x)
        x = self.dtrans4(d3)
        x = torch.cat([x, s1], axis=1)
        d4= self.d4(x)
        
        """ Classifier """
        outputs = self.outputs(d4)
        out = self.sigmoid(outputs)
        
        return out

mlp = UNet()
print("load model")
mlp = torch.load('filter_corrison_model.pth')
print("load parameters")
model = mlp.eval().cuda()
x = torch.ones((1, 3, 128, 128)).cuda()
model_trt = torch2trt(model, [x])
print("done conversion and ready to save the file")
torch.save(model_trt.state_dict(), 'filter_trt.pth')


