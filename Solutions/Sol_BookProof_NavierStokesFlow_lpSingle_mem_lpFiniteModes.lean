-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.lpSingle_mem_lpFiniteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
rem mem_lpFiniteModes {f : lp (fun _ : ι => ℂ) 2} :
    f ∈ lpFiniteModes ι ↔ (Function.support ((f : ι → ℂ))).Finite := Iff.rfl

/-- Each canonical basis state :=
  `e_k` has finite support. -/
  theorem lpSingle_mem_lpFiniteModes [DecidableEq ι] (k : ι) (c : ℂ) :
      lp.single 2 k c ∈ lpFiniteModes ι := by
    refine Set.Finite.subset (Set.finite_singleton k) ?_
    intro j hj
    simp only [Functi
