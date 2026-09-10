-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.ritzInf_finiteModeDomain_eq_rayleighInf
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.ChapterSirkRitzSpectrum
open BookProof.HermiteGalerkin







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.ritzInf_finiteModeDomain_eq_rayleighInf [Nontrivial F] (A : F →L[ℂ] F)
    (b : HilbertBasis ℕ ℂ F) :
    ritzInf (finiteModeRestrict A b) (finiteModeDomain b) = rayleighInf A := by sorry
