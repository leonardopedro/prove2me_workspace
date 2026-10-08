-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.phase_ne_zero
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterWignerSymmetry
open BookProof.NsLagrangianDet
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {b : HilbertBasis ι ℂ E} {o : ι}

theorem BookProof.ChapterWignerSymmetryInfinite.phase_ne_zero (hT : IsWignerSymmetry T) (i : ι) : phase b T o i ≠ 0 := by sorry
