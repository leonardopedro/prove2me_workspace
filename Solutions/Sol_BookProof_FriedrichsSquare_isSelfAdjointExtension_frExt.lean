-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.isSelfAdjointExtension_frExt
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_FriedrichsSquare_adjPairs_factorRel
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] (A : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) (hstab : ∀ v : D, (A v : F) ∈ D) :
    IsSelfAdjointExtension (sqOp A hstab) (frExt A hdense hsym) := by

  refine ⟨fun v => ?_, fun x y => ?_, fun w u hwu => ?_⟩
  · have hmem : ((v : F), sqOp A hstab v) ∈ factorRel A := mem_factorGraph_sqOp A hsym hstab v
    refine ⟨mem_frDom_iff.2 ⟨_, hmem⟩, ?_⟩
    exact frFun_unique hdense hsym hmem
  · exact factorGraph_symmetric (frFun_spec A x) (frFun_spec A y)
  · have hadj : (w, u) ∈ adjPairs (factorRel A) := by
      intro q hq
      have hq1 : q.1 ∈ frDom A := mem_frDom_iff.2 ⟨q.2, by simpa using hq⟩
      have hval : frFun A ⟨q.1, hq1⟩ = q.2 := frFun_unique hdense hsym (by simpa using hq)
      have := hwu ⟨q.1, hq1⟩
      simpa [hval] using this
    have hmem : (w, u) ∈ factorRel A := by
      rw [← adjPairs_factorRel A]; exact hadj
    exact ⟨mem_frDom_iff.2 ⟨u, hmem⟩, frFun_unique hdense hsym hmem⟩
