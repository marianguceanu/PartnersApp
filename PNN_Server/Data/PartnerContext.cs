using Microsoft.EntityFrameworkCore;
using PNN_Server.Model;

public class PartnerContext : DbContext
{
    public PartnerContext(DbContextOptions<PartnerContext> options)
        : base(options)
    {
    }

    public DbSet<Partner> Partner { get; set; } = default!;
}
