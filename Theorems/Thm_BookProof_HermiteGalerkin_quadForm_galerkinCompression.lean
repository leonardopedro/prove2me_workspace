-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.quadForm_galerkinCompression
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.quadForm_galerkinCompression (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (m : ℕ)
    {u : F} (hu : u ∈ galerkinSpan b m) :
    (inner ℂ u (galerkinCompression A b m u) : ℂ).re = (inner ℂ u (A u) : ℂ).re := by sorry
