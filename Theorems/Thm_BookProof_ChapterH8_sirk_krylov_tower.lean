-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_krylov_tower
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH5
open BookProof.ChapterH5
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH8.sirk_krylov_tower (H : E →ₗ[K] E) (v : E) (n : ℕ) :
    krylovSpan H v n ≤ krylovSpan H v (n + 1) := by sorry
