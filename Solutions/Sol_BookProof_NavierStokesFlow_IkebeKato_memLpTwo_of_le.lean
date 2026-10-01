-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.memLpTwo_of_le
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_summable_normSq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
g h.summable

theorem solution (f : L2I ι) {g : ι → ℂ} (h : ∀ k, ‖g k‖ ≤ ‖(f : ι → ℂ) k‖) : :=
    Memℓp g 2 :=
    memLpTwo_of_summable_normSq
      (Summable.of_nonneg_of_le (fun k => sq_nonneg _)
        (fun k => by nlinarith [norm_nonneg (g k), norm_nonneg ((f : ι → ℂ) k), h k])
        (summa
