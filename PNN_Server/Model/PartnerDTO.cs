using System.ComponentModel.DataAnnotations;

namespace PNN_Server.Model
{
    public class PartnerDTO
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        public string Email { get; set; } = string.Empty;
        [Required]
        public string Address { get; set; } = string.Empty;
        [Required]
        public string PhoneNo { get; set; } = string.Empty;
        [Required]
        public string OwnerPhoneNo { get; set; } = string.Empty;
    }
}