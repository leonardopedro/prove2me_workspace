-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clGraph_inner_pair
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {T : D →ₗ[ℂ] F} (hsym : SymmetricOn D T) {p q : F × F}
    (hp : p ∈ clGraph T) (hq : q ∈ clGraph T) :
    (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2 := by

  have hclosed : IsClosed {r : F × F | (inner ℂ p.2 r.1 : ℂ) = inner ℂ p.1 r.2} :=
    isClosed_eq (continuous_const.inner continuous_fst) (continuous_const.inner continuous_snd)
  exact clGraph_subset_of_isClosed hclosed (fun v => clGraph_inner hsym hp v) hq
