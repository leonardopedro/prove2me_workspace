-- Generated from ChapterA1h.lean — solution of BookProof.ChapterA.rImagCx_commutes
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_Complexification
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification
open BookProof.ChapterA.AntiUnitary
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℝ W} {J : W ≃ₗᵢ[ℝ] W} (hJ : IsRImaginary M J)
    {m : W →L[ℝ] W} (hm : m ∈ M.ops) (x : Cx W) :
    rImagCx J (Cx.cxMap m x) = Cx.cxMap m (rImagCx J x) := by

  ext <;> simp [rImagCx_apply, Cx.cxMap_apply, hJ.2 m hm]
