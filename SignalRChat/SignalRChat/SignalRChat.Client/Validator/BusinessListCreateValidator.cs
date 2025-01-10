using FluentValidation;
using SignalRChat.Client.Model;

namespace SignalRChat.Client.Validator
{
    public class BusinessListCreateValidator : AbstractValidator<BusinessListCreateModel>
    {
        public BusinessListCreateValidator() {
            RuleFor(businessList => businessList.address).NotEmpty().NotNull();
            RuleFor(businessList => businessList.phone).NotEmpty().NotNull();
            RuleFor(businessList => businessList.email).NotEmpty().NotNull();
            RuleFor(businessList => businessList.business_name).NotEmpty().NotNull();
            RuleFor(businessList => businessList.business_type_id).NotEmpty().NotNull();
            RuleFor(businessList => businessList.business_url).NotEmpty().NotNull();
        }
    }
}
