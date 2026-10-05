-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.phase_self
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet
open BookProof.ChapterWignerSymmetryInfinite

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterWignerSymmetryInfinite.phase_self : phase b T o o = 1 := by sorry
