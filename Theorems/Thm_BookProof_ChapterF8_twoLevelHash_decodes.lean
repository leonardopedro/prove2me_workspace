-- Generated from ChapterF8.lean — theorem BookProof.ChapterF8.twoLevelHash_decodes
import Mathlib
import Definitions.Def_ChapterF8
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow.FockManyMode
open BookProof.ChapterF8


noncomputable section

open scoped BigOperators

theorem BookProof.ChapterF8.twoLevelHash_decodes {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (hg : Function.Injective g) (x : Fin d → ℝ) (j : Fin k) :
    twoLevelHash h g x (Finsupp.single (g j) 1) = ((featureHash h x j : ℝ) : ℂ) := by sorry
