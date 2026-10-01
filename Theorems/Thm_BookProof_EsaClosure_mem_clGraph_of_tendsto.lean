-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.mem_clGraph_of_tendsto
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]
variable [CompleteSpace F] {Dom : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

_spec T x) (clFun_spec T y)

theorem BookProof.EsaClosure.mem_clGraph_of_tendsto {T : D →ₗ[ℂ] F} {ι : Type*} {l : Filter ι} [l.NeBot]
    {x : ι → clDom T} {p q : F}
    (hx : Tendsto (fun n => ((x n : F))) l (nhds p))
    (hA : Tendsto (fun n => clFun T (x n)) l (nhd := by sorry
