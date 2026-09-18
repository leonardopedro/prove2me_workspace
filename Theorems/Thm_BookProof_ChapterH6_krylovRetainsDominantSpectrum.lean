-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.krylovRetainsDominantSpectrum
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6


noncomputable section

open Filter Topology

theorem BookProof.ChapterH6.krylovRetainsDominantSpectrum (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) (lam : ℂ) (y : F) (hy : ‖y‖ = 1)
    (heig : compress V X y = lam • y) :
    lam = inner ℂ (V y) (X (V y)) ∧ ‖lam‖ ≤ ‖X‖ := by sorry
