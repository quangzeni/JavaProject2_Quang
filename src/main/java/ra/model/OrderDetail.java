package ra.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "order_details")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "price")
    private double price;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "total")
    private double total;

}
