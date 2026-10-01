-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.closed_of_selfAdjointCriterion
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F}
    (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {ι : Type*} {l : Filter ι} [l.NeBot] {x : ι → Dom} {p : F} {q : F}
    (hx : Tendsto (fun n => ((x n : F))) l (nhds p))
    (hA : Tendsto (fun n => A (x n)) l (nhds q)) :
    ∃ h : p ∈ Dom, A ⟨p, h⟩ = q := by

  refine hsa p q fun v => ?_
  have h1 : Tendsto (fun n => (inner ℂ (A v) ((x n : F)) : ℂ)) l (nhds (inner ℂ (A v) p)) :=
    tendsto_const_nhds.inner hx
  have h2 : Tendsto (fun n => (inner ℂ ((v : F)) (A (x n)) : ℂ)) l (nhds (inner ℂ (v : F) q)) :=
    tendsto_const_nhds.inner hA
  have heq : (fun n => (inner ℂ (A v) ((x n : F)) : ℂ))
      = fun n => (inner ℂ (v : F) (A (x n)) : ℂ) :=
    funext fun n => hsym v (x n)
  rw [heq] at h1
  exact tendsto_nhds_unique h1 h2
