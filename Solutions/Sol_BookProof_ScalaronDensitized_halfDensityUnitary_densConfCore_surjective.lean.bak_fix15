-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.halfDensityUnitary_densConfCore_surjective
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_densConfV_apply
import Theorems.Thm_BookProof_QuantumGravityHalfDensity_halfDensityUnitary_symm_apply
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
theorem solution (h : densConfCore M alpha) :
    ∃ x : physConfCore M alpha,
      halfDensityUnitary (x : Lp ℂ 2 physMeasure) = (h : Lp ℂ 2 qgSrcMeasure) := by

  obtain ⟨n, hn⟩ := h.2
  have hmem : (halfDensityUnitary.symm (h : Lp ℂ 2 qgSrcMeasure)) ∈ physConfCore M alpha := by
    refine ⟨n, ?_⟩
    have hpull := measurePreserving_qgSqrt.quasiMeasurePreserving.ae hn
    filter_upwards [halfDensityUnitary_symm_apply ((h : Lp ℂ 2 qgSrcMeasure)), hpull,
      ae_restrict_mem measurableSet_Ioi] with e he hpe hepos hbig
    rw [he]
    refine hpe ?_
    rwa [densConfV_apply, Real.sq_sqrt (le_of_lt hepos)]
  exact ⟨⟨_, hmem⟩, halfDensityUnitary.apply_symm_apply _⟩
