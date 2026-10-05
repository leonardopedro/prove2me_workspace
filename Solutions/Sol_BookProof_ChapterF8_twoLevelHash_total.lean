-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.twoLevelHash_total
import Mathlib
import Definitions.Def_ChapterF8
import Theorems.Thm_BookProof_ChapterF8_fockEmbed_mem_singleExcitation
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (x : Fin d → ℝ) : twoLevelHash h g x ∈ singleExcitation K := fockEmbed_mem_singleExcitation g (featureHash h x)
