-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.imgBasis_apply
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}
variable (κ : ℂ →+* ℂ)


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.imgBasis_apply (hT : IsWignerSymmetry T) (hsurj : Function.Surjective T) :
    ⇑(imgBasis b o hT hsurj) = img b T o := by sorry
