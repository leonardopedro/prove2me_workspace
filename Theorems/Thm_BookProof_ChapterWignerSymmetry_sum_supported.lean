-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.sum_supported
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem BookProof.ChapterWignerSymmetry.sum_supported {s : Finset ι} {f : ι → ℂ} (hf : ∀ k, k ∉ s → f k = 0) (g : ι → ℂ) :
    ∑ k, g k * f k = ∑ k ∈ s, g k * f k := by sorry
