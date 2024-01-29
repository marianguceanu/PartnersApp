using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PNN_Server.Model;

namespace PNN_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PartnerController : ControllerBase
    {
        private readonly PartnerContext _context;

        public PartnerController(PartnerContext context)
        {
            _context = context;
        }

        // GET: api/Partner/get/all
        [HttpGet("get/all")]
        public async Task<ActionResult<IEnumerable<Partner>>> GetPartner()
        {
            if (_context.Partner == null)
            {
                return NotFound();
            }
            return await _context.Partner.ToListAsync();
        }

        // GET: api/Partner/get/5
        [HttpGet("get/{id}")]
        public async Task<ActionResult<Partner>> GetPartner(int id)
        {
            if (_context.Partner == null)
            {
                return NotFound();
            }
            var partner = await _context.Partner.FindAsync(id);

            if (partner == null)
            {
                return NotFound();
            }

            return Ok(await _context.Partner.FindAsync(id));
        }

        // PUT: api/Partner/update
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("update/{id}")]
        public async Task<IActionResult> PutPartner([FromRoute] int id, [FromBody] PartnerDTO partner)
        {
            if (_context.Partner == null)
            {
                return NotFound();
            }

            var partnerToUpdate = await _context.Partner.FindAsync(id);
            if (partnerToUpdate == null)
            {
                return NotFound();
            }
            partnerToUpdate.Name = partner.Name;
            partnerToUpdate.Email = partner.Email;
            partnerToUpdate.Address = partner.Address;
            partnerToUpdate.PhoneNo = partner.PhoneNo;
            partnerToUpdate.OwnerPhoneNo = partner.OwnerPhoneNo;

            _context.Entry(partnerToUpdate).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PartnerExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Ok(partnerToUpdate);
        }

        // POST: api/Partner/add
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost("add")]
        public async Task<ActionResult<Partner>> PostPartner(Partner partner)
        {
            if (_context.Partner == null)
            {
                return Problem("Entity set 'PartnerContext.Partner'  is null.");
            }
            _context.Partner.Add(partner);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPartner", new { id = partner.Id }, partner);
        }

        // DELETE: api/Partner/delete/5
        [HttpDelete("delete/{id}")]
        public async Task<IActionResult> DeletePartner(int id)
        {
            if (_context.Partner == null)
            {
                return NotFound();
            }
            var partner = await _context.Partner.FindAsync(id);
            if (partner == null)
            {
                return NotFound();
            }

            _context.Partner.Remove(partner);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PartnerExists(int id)
        {
            return (_context.Partner?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
