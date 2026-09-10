-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.ritzSet_finiteModeRestrict_eq
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.ChapterSirkRitzSpectrum
open BookProof.HermiteGalerkin







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.ritzSet_finiteModeRestrict_eq (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    ritzSet (finiteModeRestrict A b) (finiteModeDomain b) =
      {t : ℝ | ∃ u : F, u ∈ finiteModeDomain b ∧ ‖u‖ = 1 ∧ t = (inner ℂ u (A u) : ℂ).re} := by sorry
