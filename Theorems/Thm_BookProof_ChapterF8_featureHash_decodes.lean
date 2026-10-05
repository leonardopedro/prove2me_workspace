-- Generated from ChapterF8.lean — theorem BookProof.ChapterF8.featureHash_decodes
import Mathlib
import Definitions.Def_ChapterF8
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow.FockManyMode
open BookProof.ChapterF8


noncomputable section

open scoped BigOperators

theorem BookProof.ChapterF8.featureHash_decodes {k K : ℕ} (g : Fin k → Fin K) (hg : Function.Injective g)
    (y : Fin k → ℝ) (j : Fin k) :
    fockEmbed g y (Finsupp.single (g j) 1) = (y j : ℂ) := by sorry
