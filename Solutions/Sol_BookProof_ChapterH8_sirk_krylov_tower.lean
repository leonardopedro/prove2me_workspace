-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_krylov_tower
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (v : E) (n : ℕ) :
    krylovSpan H v n ≤ krylovSpan H v (n + 1) := krylovSpan_mono (Nat.le_succ n)
