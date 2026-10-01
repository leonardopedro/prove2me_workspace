-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.galerkin_gap_eventually_pos
import Definitions.Def_ChapterSirkRitzSpectrum
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology


theorem BookProof.RitzMinMax.galerkin_gap_eventually_pos (T : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    (hgap : minmaxLevel T 0 < minmaxLevel T 1) :
    ∀ᶠ m : ℕ in atTop, 0 < minmaxLevelIn T (galerkinSpan b m) 1
      - minmaxLevelIn T (galerkinSpan b m) 0 := by sorry
