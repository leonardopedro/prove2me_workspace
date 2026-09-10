-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.one_particle_edge_ge_of_parity_certificate
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology
















































variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

open BookProof.SirkCertifiedGap

theorem BookProof.FockOneParticleGap.one_particle_edge_ge_of_parity_certificate {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO lam : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hvac : sectorGround T P 1 = 0) (hone : sectorGround T P (-1) = lam) :
    c.lower ≤ lam := by sorry
