-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.key_global
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.key_global (hT : IsWignerSymmetry T) :
    (∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ) ∨
    (∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = conj (conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ)) := by sorry
