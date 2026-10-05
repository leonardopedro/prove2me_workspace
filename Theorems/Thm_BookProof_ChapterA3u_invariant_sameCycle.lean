-- Generated from ChapterA3u.lean — theorem BookProof.ChapterA3u.invariant_sameCycle
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

theorem BookProof.ChapterA3u.invariant_sameCycle {N : ℕ} {σ : Equiv.Perm (Fin N)} {a : Idx N}
    (ha : a ∘ σ = a) {x y : Fin N} (h : σ.SameCycle x y) : a x = a y := by sorry
