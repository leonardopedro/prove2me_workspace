-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.multOp_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    IsSymmetricDom (multOp μ hg) :=
  μ) : X → ℂ)
        =ᵐ[μ] fun x => (g x : ℂ) * ((f : Lp ℂ 2 μ) : X → ℂ) x :=
    (memLp_mul hg f.2).coeFn_toLp
  
  /-- The multiplication operator is symmetric on the core. -/
  theorem multOp_isSymmetricDom (μ : Measure X) {g
