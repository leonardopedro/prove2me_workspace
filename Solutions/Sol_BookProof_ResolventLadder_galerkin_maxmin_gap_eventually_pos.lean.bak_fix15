-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.galerkin_maxmin_gap_eventually_pos
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_galerkin_maxminLevel_tendsto
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    (hgap : maxminLevel R 1 < maxminLevel R 0) :
    ∀ᶠ m : ℕ in atTop, 0 < maxminLevelIn R (galerkinSpan b m) 0
      - maxminLevelIn R (galerkinSpan b m) 1 :=
  (((galerkin_maxminLevel_tendsto R b 0).sub
      (galerkin_maxminLevel_tendsto R b 1)).eventually_const_lt (by linarith))
