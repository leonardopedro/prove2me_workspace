-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.trace_permMat_pow
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_card_fixedTuples
import Theorems.Thm_BookProof_ChapterA3r_trace_permMat
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    Matrix.trace (permMat σ)
      = ((4 ^ ((N - σ.cycleType.sum) + σ.cycleType.card) : ℕ) : ℂ) := by

  rw [trace_permMat, card_fixedTuples]
