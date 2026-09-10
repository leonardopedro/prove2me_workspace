-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.ritzInf_finiteModeDomain_le
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.ChapterSirkRitzSpectrum
open BookProof.HermiteGalerkin







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.ritzInf_finiteModeDomain_le (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {x : F} (hx1 : ‖x‖ = 1) :
    ritzInf (finiteModeRestrict A b) (finiteModeDomain b) ≤ (inner ℂ x (A x) : ℂ).re := by sorry
