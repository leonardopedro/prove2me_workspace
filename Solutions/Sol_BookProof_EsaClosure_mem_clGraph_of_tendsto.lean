-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.mem_clGraph_of_tendsto
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_clGraph_isClosed
open BookProof.EsaClosure











open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {T : D →ₗ[ℂ] F} {ι : Type*} {l : Filter ι} [l.NeBot]
    {x : ι → clDom T} {p q : F}
    (hx : Tendsto (fun n => ((x n : F))) l (nhds p))
    (hA : Tendsto (fun n => clFun T (x n)) l (nhds q)) : (p, q) ∈ clGraph T := by

  have hprod : Tendsto (fun n => (((x n : F)), clFun T (x n))) l (nhds (p, q)) :=
    hx.prodMk_nhds hA
  exact (clGraph_isClosed T).mem_of_tendsto hprod
    (Eventually.of_forall fun n => clFun_spec T (x n))
