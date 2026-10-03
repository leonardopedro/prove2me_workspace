-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.exists_zeta
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.exists_zeta (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ∃ zeta : ℂ, (zeta = Complex.I ∨ zeta = -Complex.I) ∧
      ∀ x : E, ‖conj (coord b T o o x) + zeta * conj (coord b T o i x)‖
        = ‖conj ⟪b o, x⟫_ℂ + Complex.I * conj ⟪b i, x⟫_ℂ‖ := by sorry
