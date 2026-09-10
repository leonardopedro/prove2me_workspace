-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.comm_lagP_lagQ
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_omega_pos
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato  BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.CanonicalVector BookProof.NavierStokesFlow.ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hnu : 0 < nu) (i : Fin 3) :
    (lagP nu i).comp (lagQ nu i) - (lagQ nu i).comp (lagP nu i)
      = (-Complex.I) • LinearMap.id := by

  have hpos : 0 < Real.sqrt (omega nu) := Real.sqrt_pos.mpr (omega_pos nu hnu)
  have hscal : ((Real.sqrt (omega nu) : ℝ) : ℂ) * (((Real.sqrt (omega nu))⁻¹ : ℝ) : ℂ) = 1 := by
    rw [← Complex.ofReal_mul, mul_inv_cancel₀ (ne_of_gt hpos), Complex.ofReal_one]
  have hL : (lagP nu i).comp (lagQ nu i) - (lagQ nu i).comp (lagP nu i)
      = (((Real.sqrt (omega nu) : ℝ) : ℂ) * (((Real.sqrt (omega nu))⁻¹ : ℝ) : ℂ)) •
        ((mom i).comp (pos i) - (pos i).comp (mom i)) := by
    simp only [lagP, lagQ, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    rw [mul_comm ((((Real.sqrt (omega nu))⁻¹ : ℝ)) : ℂ) (((Real.sqrt (omega nu) : ℝ)) : ℂ)]
    module
  rw [hL, comm_mom_pos i, hscal, one_smul]
