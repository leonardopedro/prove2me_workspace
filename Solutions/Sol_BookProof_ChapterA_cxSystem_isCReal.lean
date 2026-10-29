-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.cxSystem_isCReal
import Mathlib
import Definitions.Def_ChapterA1c
import Theorems.Thm_BookProof_Complexification_cxConj_isConjugation
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
import Definitions.Def_Complexification
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace
open BookProof.ChapterA.AntiUnitary

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℝ W) : IsCReal (cxSystem M) := ⟨Cx.cxConj, cxConj_isConjugation M⟩
