-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.galerkin_model_gap_eventually_pos
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.galerkin_model_gap_eventually_pos (T T' : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {eps : ℝ} (hd : ‖T - T'‖ ≤ eps) (hgap : 2 * eps < minmaxGap T) :
    ∀ᶠ m : ℕ in atTop, 0 < minmaxLevelIn T' (galerkinSpan b m) 1
      - minmaxLevelIn T' (galerkinSpan b m) 0 := by sorry
