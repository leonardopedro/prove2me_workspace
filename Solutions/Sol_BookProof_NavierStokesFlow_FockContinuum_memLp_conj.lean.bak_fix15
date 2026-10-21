-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.memLp_conj
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution {μ : Measure X} {F : X → ℂ} (h : MemLp F 2 μ) :
    MemLp (fun x => (starRingEnd ℂ) (F x)) 2 μ :=
  μ hg x, multOp_coeFn μ hg y] with a hx hy
    simp only [RCLike.inner_apply, hx, hy, map_mul, Complex.conj_ofReal]
    ring
  
  /-- Complex conjugation preserves square-integrability. -/
  theorem memLp_conj {μ : Measure X} {F : X → ℂ} (h : MemLp F 2 μ) :
