import os
import torch
from torch import nn
from torchvision.datasets import MNIST
from torch.utils.data import DataLoader
from torchvision import transforms
from torch2trt import torch2trt

def double_conv(inchannel, outchannel):
    conv=nn.Sequential(
        nn.Conv2d(inchannel, outchannel, kernel_size=3,stride=1),
        nn.ReLU(inplace=True),
        nn.Conv2d(outchannel, outchannel, kernel_size=3,stride=1),
        nn.ReLU(inplace=True)
    )
    return conv

def crop_img(tensor, target_tensor):
    target_size=target_tensor.size()[2]
    tensor_size=target_tensor.size()[2]
    delta=tensor_size-target_size
    delta=delta//2
    
    return tensor[:,:, delta:tensor_size-delta, delta:tensor_size-delta]

class UNet(nn.Module):

    def __init__(self):
        super(UNet, self).__init__()
        
        self.maxpool = nn.MaxPool2d(kernel_size=2, stride=2)
        
        self.dconv_down1 = double_conv(3, 16)
        self.dconv_down2 = double_conv(16, 32)
        self.dconv_down3 = double_conv(32, 64)
        self.dconv_down4 = double_conv(64, 128) 
        self.dconv_down5 = double_conv(128, 256) 
        
        self.uptrans1=nn.ConvTranspose2d(256, 128, kernel_size=3, stride=2, output_padding=1)              
        self.upconv1 = double_conv(256, 128)
        
        self.uptrans2=nn.ConvTranspose2d(128, 64, kernel_size=3, stride=1)
        self.upconv2 = double_conv(128, 64)
        
        self.uptrans3=nn.ConvTranspose2d(64, 32, kernel_size=3, stride=1)
        self.upconv3 = double_conv(64,32)
        
        
        self.uptrans4=nn.ConvTranspose2d(32, 16, kernel_size=3, stride=1)
        
        self.upconv4 = double_conv(32, 16)
        
        self.conv_last = nn.Conv2d(16, 2, 3)

    def forward(self, x):
        #encoder
        
        x1 = self.dconv_down1(x)
        x2 = self.maxpool(x1)

        x3 = self.dconv_down2(x2)
        x4 = self.maxpool(x3)
        
        x5 = self.dconv_down3(x4)
        x6 = self.maxpool(x5)   
        
        x7 = self.dconv_down4(x6)
        
        
        x8 = self.dconv_down5(x7)
        
        #decoder
        
        x=self.uptrans1(x8)
        y=crop_img(x7,x)
        #x=self.upconv1(torch.cat([y, x7], 1))
       
        
               
        x=self.uptrans2(y)
        y=crop_img(x5,x)
        x=self.upconv2(torch.cat([x, y], 1))
        
       
                   
        x=self.uptrans3(x)
        y=crop_img(x3,x)
        x=self.upconv3(torch.cat([x, y], 1))
        
                   
        x=self.uptrans4(x)
        y=crop_img(x1,x)
        #x=self.upconv3(torch.cat([x, y], 1))
        
        
        x=self.conv_last(x)
        
        print(x.size())
        print(x1.size())
        print(y.size())
        
        #return x
        

mlp = UNet()
mlp = torch.load('corrision')
model = mlp.eval().cuda()
x = torch.ones((1, 3, 128, 128)).cuda()
model_trt = torch2trt(model, [x])
torch.save(model_trt.state_dict(), 'corrision_trt.pth')


