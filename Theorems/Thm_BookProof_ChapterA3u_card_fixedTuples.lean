-- Generated from ChapterA3u.lean — theorem BookProof.ChapterA3u.card_fixedTuples
import Definitions.Def_ChapterA3o
import Definitions.Def_ChapterA3q
import Definitions.Def_ChapterA3r
import Mathlib
import Definitions.Def_ChapterA3u
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n
open BookProof.ChapterA3u


open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

theorem BookProof.ChapterA3u.card_fixedTuples {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    (Finset.univ.filter (fun a : Idx N => a ∘ σ = a)).card
      = 4 ^ ((N - σ.cycleType.sum) + σ.cycleType.card) := by sorry
