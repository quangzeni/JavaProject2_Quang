package ra.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ra.model.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
}
