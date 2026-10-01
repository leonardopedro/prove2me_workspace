-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clGraph_inner_pair
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

theorem BookProof.EsaClosure.clGraph_inner_pair {T : D →ₗ[ℂ] F} (hsym : SymmetricOn D T) {p q : F × F}
    (hp : p ∈ clGraph T) (hq : q ∈ clGraph T) :
    (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2 := by sorry
