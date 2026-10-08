-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.modulus_add
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

theorem BookProof.ChapterWignerSymmetryInfinite.modulus_add (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (x : E) :
    ‖coord b T o o x + coord b T o i x‖ = ‖⟪b o, x⟫_ℂ + ⟪b i, x⟫_ℂ‖ := by sorry
