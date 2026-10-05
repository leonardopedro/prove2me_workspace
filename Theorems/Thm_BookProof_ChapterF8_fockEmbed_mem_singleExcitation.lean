-- Generated from ChapterF8.lean — theorem BookProof.ChapterF8.fockEmbed_mem_singleExcitation
import Mathlib
import Definitions.Def_ChapterF8
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow.FockManyMode
open BookProof.ChapterF8


noncomputable section

open scoped BigOperators

theorem BookProof.ChapterF8.fockEmbed_mem_singleExcitation {k K : ℕ} (g : Fin k → Fin K) (y : Fin k → ℝ) :
    fockEmbed g y ∈ singleExcitation K := by sorry
