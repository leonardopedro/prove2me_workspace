-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_secondOrder_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_half_lagPSq_add_nu_lagQSq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    secondOrder (lagCanData nu hnu f) = lagT nu := by

  rw [lagT]
  have hmode := fun i => half_lagPSq_add_nu_lagQSq nu hnu i
  have hhalf : ((1 / 2 : ℝ) : ℂ) = (1 / 2 : ℂ) := by push_cast; ring
  simp only [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, lagCanData,
    Finset.smul_sum, hhalf]
  rw [← Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun i _ => hmode i]
  rw [Finset.sum_add_distrib, ← Finset.smul_sum]
  congr 1
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, ← Nat.cast_smul_eq_nsmul ℂ,
    smul_smul]
  congr 1
  push_cast
  ring
