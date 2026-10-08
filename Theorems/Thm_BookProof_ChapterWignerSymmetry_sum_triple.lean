-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.sum_triple
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem BookProof.ChapterWignerSymmetry.sum_triple {o i j : ι} (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j) {f : ι → ℂ}
    (hf : ∀ k, k ≠ o → k ≠ i → k ≠ j → f k = 0) (g : ι → ℂ) :
    ∑ k, g k * f k = g o * f o + g i * f i + g j * f j := by sorry
