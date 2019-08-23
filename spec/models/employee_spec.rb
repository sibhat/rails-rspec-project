require 'rails_helper'

RSpec.describe Employee, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # 
  describe "Validations test" do
    it "should validate model when passed with proper attributes" do
      employee = Employee.new({first_name: "test_first_name", last_name: "test_second_name"})
      expect(employee.valid?).to be true
    end
    it " should be invalid without a first_name attr" do
      employee = Employee.new({first_name: nil, last_name: "test_second_name"})
      expect(employee.valid?).to be false
    end
    it "should be invalid without a last_name attr" do
      employee = Employee.new({first_name: "test_first_name", last_name: nil})
      expect(employee.valid?).to be false
    end
  end
  describe "Attributes test" do
    it "should contain exactly firs_name, lsat_name" do
      employee = Employee.new({first_name: "test_first_name", last_name: "test_second_name"}).attribute_names
      expect(employee).to contain_exactly("id", "rewards_balance", "created_at", "updated_at", "first_name", "last_name")
    end
  end

  describe "Scope test" do
    describe ".zero_balance" do
      before  do
        Employee.create([{first_name: "test_first_name", last_name: "test_last_name", rewards_balance: 0},
                         {first_name: "test_first_name2", last_name: "test_last_name2", rewards_balance: 0},
                         {first_name: "test_first_name4", last_name: "test_last_name4", rewards_balance: 10},
                         {first_name: "test_first_name3", last_name: "test_last_name3", rewards_balance: 0}])
      end
      it "return employees with zero balance" do
        expect(Employee.zero_balance.count).to eq 3
      end
      it "return 1 employees with none zero balance" do
        expect(Employee.zero_balance.count).to eq 1
      end
    end
  end

  describe "Instance Methods test" do
    let(:employee) {Employee.create({first_name: "test_first_name", last_name: "test_last_name", rewards_balance: 10})}
    let(:employee2) {Employee.create({first_name: "test_first_name", last_name: "test_last_name", rewards_balance: 0})}

    it " the full-name return as expected " do
      expect(employee.first_name).to eq "test_first_name"
    end
    it " the full-name return false if either first name or last name is changed as expected " do
      expect(employee.first_name).not_to eq "test_first_name2"
    end

    it " should return true if user can afford the cost" do
      expect(employee.can_afford? 9).to eq true
    end
    it " should return false if user can not afford the cost" do
      expect(employee2.can_afford? 9).to eq false
    end
  end
end
