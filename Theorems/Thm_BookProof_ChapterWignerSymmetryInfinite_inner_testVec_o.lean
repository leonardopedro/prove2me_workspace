-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.inner_testVec_o
import Definitions.Def_ChapterWignerSymmetry
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterA4

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.inner_testVec_o {i : ι} (hi : i ≠ o) (z : ℂ) : ⟪b o, testVec b o i z⟫_ℂ = 1 := by sorry
