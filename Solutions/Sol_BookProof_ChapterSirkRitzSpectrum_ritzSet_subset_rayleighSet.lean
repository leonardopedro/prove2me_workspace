-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.ritzSet_subset_rayleighSet
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.ChapterSirkRitzSpectrum
open BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit








noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    ritzSet (finiteModeRestrict A b) (finiteModeDomain b) ⊆ rayleighSet A := by

  rintro t ⟨x, -, hx1, rfl⟩
  exact ⟨(x : F), hx1, rfl⟩
