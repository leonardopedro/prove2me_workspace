-- Generated from ChapterComplexShiftCore.lean — theorem BookProof.HashimotoShiftInvert.closed_of_selfAdjointCriterion
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}



open BookProof.FarisLavine
open Filter Topology

theorem BookProof.HashimotoShiftInvert.closed_of_selfAdjointCriterion {A : Dom →ₗ[ℂ] F}
    (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {ι : Type*} {l : Filter ι} [l.NeBot] {x : ι → Dom} {p : F} {q : F}
    (hx : Tendsto (fun n => ((x n : F))) l (nhds p))
    (hA : Tendsto (fun n => A (x n)) l (nhds q)) :
    ∃ h : p ∈ Dom, A ⟨p, h⟩ = q := by sorry
