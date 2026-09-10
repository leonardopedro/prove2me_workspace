-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.ritzSet_finiteModeRestrict_bddBelow
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.ChapterSirkRitzSpectrum
open BookProof.HermiteGalerkin







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.ritzSet_finiteModeRestrict_bddBelow (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    BddBelow (ritzSet (finiteModeRestrict A b) (finiteModeDomain b)) := by sorry
