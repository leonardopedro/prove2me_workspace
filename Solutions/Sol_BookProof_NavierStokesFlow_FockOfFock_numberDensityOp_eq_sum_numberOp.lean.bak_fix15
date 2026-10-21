-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.numberDensityOp_eq_sum_numberOp
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_numberOp_basis
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_numberDensityOp_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (dens : M → Ω → ℝ) (ξ : Ω) {n : Conf M} {S : Finset M}
    (hS : n.support ⊆ S) :
    numberDensityOp dens ξ (fockBasis n)
      = ∑ m ∈ S, ((dens m ξ : ℝ) : ℂ) • numberOp m (fockBasis n) := by

  have h : confDensity dens n ξ = ∑ m ∈ S, (n m : ℝ) * dens m ξ :=
    Finset.sum_subset hS fun m _ hm => by
      have hn : n m = 0 := by simpa using hm
      simp [hn]
  rw [numberDensityOp_basis, h]
  simp only [numberOp_basis, smul_smul, ← Complex.ofReal_mul, ← Finset.sum_smul,
    ← Complex.ofReal_sum]
  congr 2
  exact Finset.sum_congr rfl fun m _ => mul_comm _ _
