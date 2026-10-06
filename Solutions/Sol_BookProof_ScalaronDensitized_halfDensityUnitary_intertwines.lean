-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.halfDensityUnitary_intertwines
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_densConfV_apply
import Theorems.Thm_BookProof_ScalaronDensitized_halfDensityUnitary_mem_densConfCore
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
import Theorems.Thm_BookProof_QuantumGravityHalfDensity_halfDensityUnitary_apply
open BookProof.ScalaronDensitized




open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable (M alpha : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (x : physConfCore M alpha) :
    ((densConfOp M alpha ⟨halfDensityUnitary (x : Lp ℂ 2 physMeasure),
        halfDensityUnitary_mem_densConfCore M alpha x⟩ : densConfCore M alpha) :
          Lp ℂ 2 qgSrcMeasure)
      = halfDensityUnitary ((physConfOp M alpha x : physConfCore M alpha) :
          Lp ℂ 2 physMeasure) := by

  refine Lp.ext ?_
  have h1 := multOp_coeFn qgSrcMeasure (measurable_densConfV M alpha)
    (⟨halfDensityUnitary (x : Lp ℂ 2 physMeasure),
      halfDensityUnitary_mem_densConfCore M alpha x⟩ : densConfCore M alpha)
  have h2 := halfDensityUnitary_apply ((x : Lp ℂ 2 physMeasure))
  have h3 := halfDensityUnitary_apply
    (((physConfOp M alpha x : physConfCore M alpha) : Lp ℂ 2 physMeasure))
  have h4 := (multOp_coeFn physMeasure (measurable_confV M alpha) x).comp_tendsto
    measurePreserving_qgSquare.quasiMeasurePreserving.tendsto_ae
  filter_upwards [h1, h2, h3, h4] with y hy1 hy2 hy3 hy4
  simp only [Function.comp_apply, qgSquare] at hy4
  refine hy1.trans ?_
  rw [hy2, densConfV_apply, hy3]
  exact hy4.symm
