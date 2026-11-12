-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_hFull_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_essentiallySelfAdjointOn_of_drive_eq_P
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_drive
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagOp_zero_symbol
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_secondOrder_hasZeroDeficiencyOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

open BookProof.NavierStokesFlow.DiagonalEsa BookProof.NavierStokesFlow.JacobiDeficiency BookProof.NavierStokesFlow.LpNat
set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn diagKR.D (lagrangianCore diagKR) :=
  -- `diagKR_constraint_bound` as published on the platform carries the WRONG
  -- statement (`HasZeroDeficiencyOn diagKR.D (secondOrder diagKR)`), so the
  -- pointwise bound the caller needs is proved here instead (source:
  -- `BookProof/ChapterNavierStokesLagrangianKatoRellich.lean:466`).
  have hC : ∀ v : diagKR.D, ‖(diagKR.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
    intro v
    rw [show diagKR.constraintOp = 0 from diagOp_zero_symbol]
    simp
  hFull_essentiallySelfAdjointOn_of_drive_eq_P diagKR diagKR_drive le_rfl hC
    ((essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn diagKR.D (secondOrder diagKR)).mpr
      diagKR_secondOrder_hasZeroDeficiencyOn)
