-- Generated from Complexification.lean — solution of BookProof.Complexification.cxConj_isConjugation
import Mathlib
import Definitions.Def_Complexification
import Theorems.Thm_BookProof_Complexification_Cx_cxConj_involutive
import Theorems.Thm_BookProof_Complexification_Cx_cxConj_comm_cxMap
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.Complexification



open scoped RealInnerProductSpace
open RCLike
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in

theorem solution [CompleteSpace W] (M : System ℝ W) :
    IsConjugation (cxSystem M) Cx.cxConj := by
  refine ⟨Cx.cxConj_involutive, ?_⟩
  rintro m' ⟨m, _, rfl⟩ x
  exact Cx.cxConj_comm_cxMap m x
