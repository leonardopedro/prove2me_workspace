-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.modulus_add
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.modulus_add (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (x : E) :
    ‖coord b T o o x + coord b T o i x‖ = ‖⟪b o, x⟫_ℂ + ⟪b i, x⟫_ℂ‖ := by sorry
