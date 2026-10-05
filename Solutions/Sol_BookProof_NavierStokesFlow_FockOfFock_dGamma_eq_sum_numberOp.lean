-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.dGamma_eq_sum_numberOp
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_confEnergy_eq_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_basis
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_numberOp_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution (ω : M → ℝ) {n : Conf M} {S : Finset M} (hS : n.support ⊆ S) :
    dGamma ω (fockBasis n) = ∑ m ∈ S, ((ω m : ℝ) : ℂ) • numberOp m (fockBasis n) := by

  rw [dGamma_basis, confEnergy_eq_sum hS]
  simp only [numberOp_basis, smul_smul, ← Complex.ofReal_mul, ← Finset.sum_smul,
    ← Complex.ofReal_sum]
  congr 2
  exact Finset.sum_congr rfl fun m _ => mul_comm _ _
