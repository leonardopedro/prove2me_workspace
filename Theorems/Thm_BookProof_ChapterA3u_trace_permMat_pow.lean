-- Generated from ChapterA3u.lean — theorem BookProof.ChapterA3u.trace_permMat_pow
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

theorem BookProof.ChapterA3u.trace_permMat_pow {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    Matrix.trace (permMat σ)
      = ((4 ^ ((N - σ.cycleType.sum) + σ.cycleType.card) : ℕ) : ℂ) := by sorry
