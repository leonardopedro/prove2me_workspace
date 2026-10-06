-- Generated from ChapterA.lean — solution of BookProof.ChapterA.System.orthogonal_isSubsystem
import Mathlib
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.System



open scoped ComplexConjugate InnerProductSpace

variable {𝔽 : Type*} [RCLike 𝔽] {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace 𝔽 V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System 𝔽 V) (hM : IsNormal M)
    {W : Submodule 𝔽 V} (hW : IsSubsystem M W) : IsSubsystem M Wᗮ := by

  refine ⟨ ?_, ?_ ⟩;
  · exact Submodule.isClosed_orthogonal W
  · intro m hm w hw v hv; have := hM m hm; simp_all only [Submodule.mem_orthogonal'] ;
    rw [ ← ContinuousLinearMap.adjoint_inner_left ];
    rw [ ← inner_conj_symm, hw _ ( hW.2 _ this _ hv ) ] ; simp
