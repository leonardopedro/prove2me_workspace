-- Generated from ChapterA3p.lean — theorem BookProof.ChapterA3p.sum_signC_eq_zero
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3n
import Mathlib
import Definitions.Def_ChapterA3p
import Definitions.Def_ChapterA3o
open BookProof.ChapterA3o
open BookProof.ChapterA3p


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

theorem BookProof.ChapterA3p.sum_signC_eq_zero {N : ℕ} (hN : 2 ≤ N) :
    ∑ σ : Equiv.Perm (Fin N), signC σ = 0 := by sorry
