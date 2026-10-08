-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.sum_pair'
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem BookProof.ChapterWignerSymmetry.sum_pair_prime {o i : ι} (hi : i ≠ o) {f : ι → ℂ} (hf : ∀ k, k ≠ o → k ≠ i → f k = 0)
    (g : ι → ℂ) : ∑ k, g k * f k = g o * f o + g i * f i := by sorry
