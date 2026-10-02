-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_drift_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_drift
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
orem diagKR_constraint_zero : diagKR.constraintOp = 0 := diagOp_zero_symbol

theorem solution (v : diagKR.D) :
    ‖(diagKR.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
  rw [diagKR_constraint_zero]
  simp

theorem diagKR_secondOrder_hasZeroDeficiencyOn :=
  :
      HasZeroDeficiencyOn diagKR.D (secondOrder diagKR) := by
    rw [diagKR_secondOrder]
    exact diagOp_hasZeroDeficiencyOn _
  
  /-- **The drift of this instance is not a bounded perturbation**, so the bounded
  Kato–Rellich theorem does not apply to it: the relative version is genuinely
  needed. -/
  theorem diagKR_drift_not_bounded :
      ¬ ∃ C : ℝ, ∀ f : diagKR.D, ‖diagKR.drift f‖ ≤ C * ‖f‖ := by
    rw [diagKR_drift]
    r
