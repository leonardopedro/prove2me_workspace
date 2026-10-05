-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.twoLevelHash_decodes
import Mathlib
import Definitions.Def_ChapterF8
import Theorems.Thm_BookProof_ChapterF8_featureHash_decodes
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (hg : Function.Injective g) (x : Fin d → ℝ) (j : Fin k) :
    twoLevelHash h g x (Finsupp.single (g j) 1) = ((featureHash h x j : ℝ) : ℂ) := featureHash_decodes g hg (featureHash h x) j
