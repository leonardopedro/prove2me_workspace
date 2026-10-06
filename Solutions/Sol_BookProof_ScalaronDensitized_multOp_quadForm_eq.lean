-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.multOp_quadForm_eq
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.ScalaronDensitized




open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable (M alpha : ℝ)
variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : boundedEnergyCore mu g) :
    quadForm ((boundedEnergyCore mu g).subtype.comp (multOp mu hg)) f
      = ∫ a, g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 ∂mu := by

  have hkey : ∀ (z : ℂ) (r : ℝ), (inner ℂ z ((r : ℂ) * z) : ℂ) = ((r * ‖z‖ ^ 2 : ℝ) : ℂ) := by
    intro z r
    rw [RCLike.inner_apply]
    have h : (starRingEnd ℂ) z * z = ((‖z‖ : ℂ)) ^ 2 := Complex.conj_mul' z
    push_cast
    rw [← h]; ring
  have hinner : (inner ℂ ((f : Lp ℂ 2 mu))
      (((multOp mu hg f : boundedEnergyCore mu g) : Lp ℂ 2 mu)) : ℂ)
      = ((∫ a, g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 ∂mu : ℝ) : ℂ) := by
    rw [L2.inner_def, ← integral_complex_ofReal]
    refine integral_congr_ae ?_
    filter_upwards [multOp_coeFn mu hg f] with a ha
    rw [ha, hkey]
  simp only [quadForm, LinearMap.comp_apply, Submodule.subtype_apply, hinner,
    Complex.ofReal_re]
