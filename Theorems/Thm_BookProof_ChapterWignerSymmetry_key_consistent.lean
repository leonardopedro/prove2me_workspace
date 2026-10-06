-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.key_consistent
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.key_consistent (hS : WignerCoord S o) {i j : ι} (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j)
    (hi : ∀ v, conj (S v o) * S v i = conj (v o) * v i)
    (hj : ∀ v, conj (S v o) * S v j = conj (conj (v o) * v j)) : False := by sorry
