-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.IsRReal.cxSystem_isCReal
import Mathlib
import Definitions.Def_ChapterA1c
import Theorems.Thm_BookProof_ChapterA_cxSystem_isCReal
import Definitions.Def_ChapterA
import Definitions.Def_Complexification
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace
-- `cxSystem` is declared in `Definitions.Def_Complexification`, under
-- `BookProof.Complexification` — not under `BookProof.ChapterA`.  Verified
-- 2026-11-06 by compiling the PUBLISHED text of that bundle: it does declare
-- the name, so importing + opening it is the whole requirement.
open BookProof.Complexification

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℝ W} (_ : IsRReal M) :
    IsCReal (cxSystem M) := _root_.BookProof.ChapterA.cxSystem_isCReal M
