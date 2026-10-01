package vn.edu.hcmute.service;

import vn.edu.hcmute.dao.CategoryDAO_24110240;
import vn.edu.hcmute.model.Category;

import java.util.List;

public class CategoryService_24110240 {

    private final CategoryDAO_24110240 categoryDAO = new CategoryDAO_24110240();

    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    public Category getCategoryById(Integer id) {
        return categoryDAO.findById(id);
    }

    public void saveCategory(Category category) {
        if (category.getCategoryId() == null || category.getCategoryId() == 0) {
            categoryDAO.create(category);
        } else {
            categoryDAO.update(category);
        }
    }

    public void deleteCategory(Integer id) {
        categoryDAO.delete(id);
    }

    public List<Category> getCategoriesPaginated(int page, int pageSize) {
        return categoryDAO.findPaginated(page, pageSize);
    }

    public int getTotalPages(int pageSize) {
        long count = categoryDAO.countAll();
        return (int) Math.ceil((double) count / pageSize);
    }

    public long getTotalCount() {
        return categoryDAO.countAll();
    }
}
