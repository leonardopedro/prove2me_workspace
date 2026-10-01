-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — theorem BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_drift_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

orem diagKR_constraint_zero : diagKR.constraintOp = 0 := diagOp_zero_symbol

theorem BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_drift_not_bounded (v : diagKR.D) :
    ‖(diagKR.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
  rw [diagKR_constraint_zero]
  simp

theorem diagKR_secondOrder_hasZeroDeficiencyOn := by sorry
