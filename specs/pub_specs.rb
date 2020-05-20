require('minitest/autorun')
require('minitest/reporters')
require_relative('../pub')
require_relative('../drink')
require_relative('../customer')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestPub < MiniTest::Test

    def setup()
        @drink1 = Drink.new("Hammer", 30)
        @drink2 = Drink.new("TheDrill", 35)
        @drink3 = Drink.new("Hacksaw", 40)
        @drinks = [@drink1, @drink2, @drink3]

        @customer = Customer.new("Frodo", 60, 32)

        @pub = Pub.new("Chanter", 200, @drinks)
    end

    def test_can_get_pub_name()
        assert_equal("Chanter", @pub.name())
    end

    def test_can_get_till_amount()
        assert_equal(200, @pub.till())
    end

    def test_can_return_number_of_drinks()
        assert_equal(3, @pub.number_of_drinks())
    end

    def test_remove_drink()
        @pub.remove_drink(@drink1)
        assert_equal(2, @pub.number_of_drinks())
    end

    def test_add_to_till()
        @pub.add_to_till(100)
        assert_equal(300, @pub.till())
    end
    
    def test_pub_can_sell_drink_to_customer()
        @pub.sell_drink_to_customer("Hammer", @customer)
        assert_equal(2, @pub.number_of_drinks())
        assert_equal(30, @customer.get_wallet_amount())
        assert_equal(230, @pub.till())
    end

end