-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_real_smul
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_real_smul (μ : Measure X) {g h : X → ℝ} (r : ℝ) (hh : Measurable h)
    (hdom : DominatedOn μ g h) :
    ((r : ℝ) : ℂ) • mulD μ hh hdom
      = mulD μ ((measurable_const (a := r)).mul hh) (DominatedOn.const_mul r hdom) := by sorry
