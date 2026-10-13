-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_drift_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_drift
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_not_bounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterAbelianDiagonalCountable
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

set_option maxHeartbeats 1000000 in
open BookProof.ChapterAbelianDiagonalCountable BookProof.NavierStokesFlow.DiagonalEsa BookProof.NavierStokesFlow.JacobiDeficiency BookProof.NavierStokesFlow.LpNat
theorem solution :
    ¬ ∃ C : ℝ, ∀ f : diagKR.D, ‖diagKR.drift f‖ ≤ C * ‖f‖ :=
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
