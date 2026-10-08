-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.key_consistent
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}

theorem BookProof.ChapterWignerSymmetryInfinite.key_consistent (hT : IsWignerSymmetry T) (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j)
    (hlin : ∀ x : E, conj (coord b T o o x) * coord b T o i x = conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ)
    (hanti : ∀ x : E, conj (coord b T o o x) * coord b T o j x
      = conj (conj ⟪b o, x⟫_ℂ * ⟪b j, x⟫_ℂ)) : False := by sorry
