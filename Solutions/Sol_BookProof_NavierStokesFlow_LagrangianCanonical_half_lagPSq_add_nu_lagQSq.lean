-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.half_lagPSq_add_nu_lagQSq
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_posSq_add_momSq
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_omega_pos
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_omega_sq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hnu : 0 < nu) (i : Fin 3) :
    (1 / 2 : ℂ) • (lagP nu i).comp (lagP nu i)
        + ((nu : ℝ) : ℂ) • (lagQ nu i).comp (lagQ nu i)
      = ((omega nu : ℝ) : ℂ) • numOp i + ((omega nu / 2 : ℝ) : ℂ) • LinearMap.id := by

  have hw : 0 < omega nu := omega_pos nu hnu
  have hsq : Real.sqrt (omega nu) * Real.sqrt (omega nu) = omega nu :=
    Real.mul_self_sqrt (le_of_lt hw)
  have hspos : 0 < Real.sqrt (omega nu) := Real.sqrt_pos.mpr hw
  have hP : (lagP nu i).comp (lagP nu i) = ((omega nu : ℝ) : ℂ) • (mom i).comp (mom i) := by
    simp only [lagP, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul, ← Complex.ofReal_mul,
      hsq]
  have hQ : (lagQ nu i).comp (lagQ nu i)
      = (((omega nu)⁻¹ : ℝ) : ℂ) • (pos i).comp (pos i) := by
    have hinv : (Real.sqrt (omega nu))⁻¹ * (Real.sqrt (omega nu))⁻¹ = (omega nu)⁻¹ := by
      rw [← mul_inv, hsq]
    simp only [lagQ, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul, ← Complex.ofReal_mul,
      hinv]
  have hnuw : nu * (omega nu)⁻¹ = omega nu / 2 := by
    have h2 : omega nu * omega nu = 2 * nu := omega_sq nu (le_of_lt hnu)
    field_simp
    linarith [h2]
  have hcombine : (1 / 2 : ℂ) • (((omega nu : ℝ) : ℂ) • (mom i).comp (mom i))
        + ((nu : ℝ) : ℂ) • ((((omega nu)⁻¹ : ℝ) : ℂ) • (pos i).comp (pos i))
      = ((omega nu / 2 : ℝ) : ℂ) • ((pos i).comp (pos i) + (mom i).comp (mom i)) := by
    have hs : ((nu : ℝ) : ℂ) * (((omega nu)⁻¹ : ℝ) : ℂ) = ((omega nu / 2 : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, hnuw]
    have hs2 : (1 / 2 : ℂ) * ((omega nu : ℝ) : ℂ) = ((omega nu / 2 : ℝ) : ℂ) := by
      push_cast
      ring
    simp only [smul_smul, hs, hs2]
    module
  rw [hP, hQ, hcombine, posSq_add_momSq i]
  have hs3 : ((omega nu / 2 : ℝ) : ℂ) * (2 : ℂ) = ((omega nu : ℝ) : ℂ) := by
    push_cast
    ring
  simp only [smul_add, smul_smul, hs3]
