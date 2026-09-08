-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.galerkin_gap_eventually_pos
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_galerkin_gap_tendsto
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    (hgap : minmaxLevel T 0 < minmaxLevel T 1) :
    ∀ᶠ m : ℕ in atTop, 0 < minmaxLevelIn T (galerkinSpan b m) 1
      - minmaxLevelIn T (galerkinSpan b m) 0 := (galerkin_gap_tendsto T b).eventually_const_lt (by linarith)
