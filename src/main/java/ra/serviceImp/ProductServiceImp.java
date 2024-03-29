package ra.serviceImp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import ra.model.Product;
import ra.model.ProductImage;
import ra.repository.ProductImageRepository;
import ra.repository.ProductRepository;
import ra.service.ProductService;
import ra.service.UploadFileService;

import java.util.List;

@Service
public class ProductServiceImp implements ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private UploadFileService uploadFileService;

    @Autowired
    private ProductImageRepository productImageRepository;


    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public Product findById(String productId) {
        return productRepository.findById(productId).orElse(null);
    }

    @Override
    @Transactional
    public boolean save(Product product, MultipartFile avatar, MultipartFile[] otherImages) {
        String avatar_link = uploadFileService.uploadFile(avatar);
        product.setAvatarImage(avatar_link);
        Product productNew =  productRepository.save(product);
        for (MultipartFile file : otherImages){
            String link = uploadFileService.uploadFile(file);
            ProductImage productImage = new ProductImage();
            productImage.setImageLink(link);
            productImage.setProduct(productNew);
            productImageRepository.save(productImage);
        }
        return productNew != null ? true : false;
    }

    @Override
    @Transactional
    public boolean update(Product productUpdate) {
        boolean result = false;
        try {
            Product existingProduct = productRepository.findById(productUpdate.getId()).orElse(null);
            if (existingProduct != null){
                existingProduct.setProductName(productUpdate.getProductName());
                existingProduct.setPrice(productUpdate.getPrice());
                existingProduct.setDescription(productUpdate.getDescription());
                existingProduct.setStatus(productUpdate.isStatus());
                productRepository.save(existingProduct);
                result = true;
            }else {
                result = false;
            }
        }
        catch (Exception ex){
            ex.printStackTrace();
        }
        return result;
    }

    @Override
    @Transactional
    public boolean delete(String productId) {
        boolean result = false;
        try {
            productRepository.deleteById(productId);
            result = true;
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return true;
    }

    @Override
    public List<Product> searchByName(String productName) {
        return productRepository.findByProductNameContainingIgnoreCase(productName);
    }

    @Override
    public List<Product> sortByName(String sortValue) {
        Sort sort = "asc".equals(sortValue) ? Sort.by(Sort.Order.asc("productName")) : Sort.by(Sort.Order.desc("productName"));
        return productRepository.findAll(sort);
    }
}

