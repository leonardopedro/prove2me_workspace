-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.sum_triple
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
import Theorems.Thm_BookProof_ChapterWignerSymmetry_sum_supported
open BookProof.ChapterWignerSymmetry



open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {o i j : ι} (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j) {f : ι → ℂ}
    (hf : ∀ k, k ≠ o → k ≠ i → k ≠ j → f k = 0) (g : ι → ℂ) :
    ∑ k, g k * f k = g o * f o + g i * f i + g j * f j := by

  classical
  rw [sum_supported (s := ({o, i, j} : Finset ι)) (fun k hk => by
      simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hk
      exact hf k hk.1 hk.2.1 hk.2.2) g]
  rw [Finset.sum_insert (by simp [Ne.symm hio, Ne.symm hjo]),
    Finset.sum_insert (by simp [hij]), Finset.sum_singleton, add_assoc]
